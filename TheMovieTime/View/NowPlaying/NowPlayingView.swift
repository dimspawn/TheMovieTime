//
//  NowPlayingView.swift
//  TheMovieTime
//
//  Created by Dimas Wicaksono on 17/01/22.
//

import SwiftUI
import NowPlaying
import Core
import MovieDomain

struct NowPlayingView<
    FavoriteRouter: View,
    ProfileRouter: View,
    DetailRouter: View>: View {
    
    let favoriteRouter: () -> FavoriteRouter
    let profileRouter: () -> ProfileRouter
    let detailRouter: (_ id: Int) -> DetailRouter
    
    @ObservedObject var presenter: NowPlayingPresenter<
        Any,
        NowPlayingModel,
        Interactor<
            Any,
            [NowPlayingModel],
            GetNowPlayingRepository<
                NowPlayingLocalDataSource,
                GetNowPlayingRemoteDataSource,
                NowPlayingTransformer
            >
        >
    >
    
    init(presenter: NowPlayingPresenter<
        Any,
        NowPlayingModel,
        Interactor<
            Any,
            [NowPlayingModel],
            GetNowPlayingRepository<
                NowPlayingLocalDataSource,
                GetNowPlayingRemoteDataSource,
                NowPlayingTransformer
            >
         >>,
        detailRouter: @escaping (Int) -> DetailRouter,
        profileRouter: @escaping () -> ProfileRouter,
        favoriteRouter: @escaping () -> FavoriteRouter) {
        self.presenter = presenter
        self.detailRouter = detailRouter
        self.profileRouter = profileRouter
        self.favoriteRouter = favoriteRouter
    }
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                VStack {
                    Text("Loading...")
                    CustomActivityIndicator()
                }.frame(minWidth: 0, maxWidth: .infinity,
                        minHeight: 0, maxHeight: .infinity,
                        alignment: .center)
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(self.presenter.list, id: \.id){ movie in
                        ZStack {
                            NavigationLink(
                                destination: self.detailRouter(movie.id)
                            ) {
                                NowPlayingRow(movie: movie)
                            }
                        }.padding(8)
                    }
                }
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
        }
        .background(Color.movieBackground)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {}, label: {
                    NavigationLink(destination: self.profileRouter()) {
                        Image(systemName: "person.circle").imageScale(.large)
                    }
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}, label: {
                    NavigationLink(destination: self.favoriteRouter()) {
                        Image(systemName: "star.fill").imageScale(.large)
                    }
                })
            }
        }
        .navigationTitle("The Movie Time")
    }
}
