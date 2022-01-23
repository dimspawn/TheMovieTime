//
//  SceneDelegate.swift
//  TheMovieTime
//
//  Created by Dimas Wicaksono on 10/12/21.
//

import UIKit
import SwiftUI
import Core
import NowPlaying
import MovieDomain

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let getNowPlayingUseCase: Interactor<
            Any,
            [NowPlayingModel],
            GetNowPlayingRepository<
                NowPlayingLocalDataSource,
                GetNowPlayingRemoteDataSource,
                NowPlayingTransformer
            >
        > = Injection.init().provideNowPlaying()

        let nowPlayingPresenter = NowPlayingPresenter(getNowPlayingUseCase: getNowPlayingUseCase)

        let contentView = ContentView()
          .environmentObject(nowPlayingPresenter)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            window.tintColor = UIColor(.movieFont)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

