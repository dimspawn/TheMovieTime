//
//  ContentView.swift
//  TheMovieTime
//
//  Created by Dimas Wicaksono on 12/12/21.
//

import SwiftUI
import Core
import NowPlaying
import MovieDomain

struct ContentView: View {
    @EnvironmentObject var nowPlayingPresenter: NowPlayingPresenter<
        Any,
        NowPlayingModel,
        Interactor<Any, [NowPlayingModel],
        GetNowPlayingRepository<
            NowPlayingLocalDataSource,
            GetNowPlayingRemoteDataSource,
            NowPlayingTransformer>
        >
    >
    
    let router = Router()
    
    var body: some View {
        NavigationView {
            NowPlayingView<
                FavoriteView<DetailView>,
                ProfileView,
                DetailView>(
                presenter: nowPlayingPresenter,
                detailRouter: { id in
                    router.makeDetailView(for: id)
                },
                profileRouter: {
                    router.makeProfileView()
                },
                favoriteRouter: {
                    router.makeFavoriteView()
                }
            )
        }
    }
}

