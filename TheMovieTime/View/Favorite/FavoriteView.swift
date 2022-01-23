//
//  FavoriteView.swift
//  TheMovieTime
//
//  Created by Dimas Wicaksono on 21/01/22.
//

import SwiftUI
import Favorite
import Core
import MovieDomain

struct FavoriteView<DetailRouter: View>: View {
    
    let detailRouter: (_ id: Int) -> DetailRouter
    
    @ObservedObject var presenter: FavoritePresenter<
        Any,
        FavoriteModel,
        Interactor<
            Any,
            [FavoriteModel],
            GetFavoriteRepository<
                FavoriteLocalDataSource,
                FavoritesTransformer
            >
        >
    >
    
    init(presenter: FavoritePresenter<
        Any,
        FavoriteModel,
        Interactor<
            Any,
            [FavoriteModel],
            GetFavoriteRepository<
                FavoriteLocalDataSource,
                FavoritesTransformer
            >
         >>,
         detailRouter: @escaping (Int) -> DetailRouter) {
        self.presenter = presenter
        self.detailRouter = detailRouter
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
                                FavoriteRow(movie: movie)
                            }
                        }.padding(8)
                    }
                }
            }
        }.onAppear {
            self.presenter.getList(request: nil)
        }
        .background(Color.movieBackground)
        .navigationTitle("Favorites Movie")
        .navigationBarTitleDisplayMode(.inline)
    }
}
