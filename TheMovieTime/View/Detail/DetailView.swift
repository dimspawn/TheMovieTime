//
//  DetailView.swift
//  TheMovieTime
//
//  Created by Dimas Wicaksono on 17/01/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Detail
import Favorite
import MovieDomain

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter<
        Interactor<
            Int,
            DetailModel,
            GetDetailRepository<
                GetDetailRemoteDataSource,
                DetailTransformer
            >
        >,
        Interactor<
            Int,
            Bool,
            IsFavoriteRepository<FavoriteLocalDataSource>
        >,
        Interactor<
            DetailModel,
            Bool,
            AddFavoriteRepository<
                FavoriteLocalDataSource,
                FavoriteTransformer
            >
        >,
        Interactor<
            DetailModel,
            Bool,
            DeleteFavoriteRepository<
                FavoriteLocalDataSource,
                FavoriteTransformer
            >
        >
    >
    
    public init(presenter: DetailPresenter<
                Interactor<
                    Int,
                    DetailModel,
                    GetDetailRepository<
                        GetDetailRemoteDataSource,
                        DetailTransformer
                    >
                >,
                Interactor<
                    Int,
                    Bool,
                    IsFavoriteRepository<FavoriteLocalDataSource>
                >,
                Interactor<
                    DetailModel,
                    Bool,
                    AddFavoriteRepository<
                        FavoriteLocalDataSource,
                        FavoriteTransformer
                    >
                >,
                Interactor<
                    DetailModel,
                    Bool,
                    DeleteFavoriteRepository<
                        FavoriteLocalDataSource,
                        FavoriteTransformer
                    >
                >
            >) {
        self.presenter = presenter
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
                    ZStack {
                        VStack {
                            VStack {
                                imageMovie
                                title
                            }
                            VStack {
                                mainView
                            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(16)
                            VStack {
                                tagline
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.taglineBackground)
                                .cornerRadius(20)
                                .padding(16)
                            VStack {
                                ratings
                            }
                        }
                        .background(Color.movieCard)
                        .cornerRadius(20)
                    }.padding(8)
                }
            }
        }.onAppear {
            self.presenter.getDetail()
            self.presenter.checkIsFavorite()
        }
        .background(Color.movieBackground)
        .navigationBarTitle("Detail Movie", displayMode: .inline)
        .toolbar {
            Button {
                self.presenter.favoriteToggle()
            } label: {
                if self.presenter.isFavorite {
                    Image(systemName: "bookmark.fill").imageScale(.large)
                } else {
                    Image(systemName: "bookmark").imageScale(.large)
                }
            }
        }
    }
}

extension DetailView {
    @ViewBuilder
    var imageMovie: some View {
        if let backdropPath = presenter.detail?.backdropPath {
            let image = "\(API.imageSource)\(backdropPath)"
            WebImage(url: URL(string: image))
                .resizable()
                .indicator(.activity)
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: .infinity)
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 130)
        }
    }
    
    var title: some View {
        Text(textExtract(oText: presenter.detail?.title))
            .font(.title)
            .bold()
            .padding(10)
            .foregroundColor(Color.movieFont)
    }
    
    var mainView: some View {
        VStack(alignment: .leading) {
            Text("Released Date:").bold().font(.title2).foregroundColor(Color.movieFont)
            Text(dateExtract(oText: presenter.detail?.releaseDate)).padding(.bottom)
                .foregroundColor(Color.movieFont).foregroundColor(Color.movieFont)
            Text("Genres:").bold().font(.title2).foregroundColor(Color.movieFont)
            Text(genreExtract(genres: presenter.detail?.genres)).padding(.bottom).foregroundColor(Color.movieFont)
            Text("Overview:").bold().font(.title2).foregroundColor(Color.movieFont)
            Text(textExtract(oText: presenter.detail?.overview)).foregroundColor(Color.movieFont)
        }
    }
    
    var tagline: some View {
        Text("\"" + textExtract(oText: presenter.detail?.tagline) + "\"")
            .bold()
            .foregroundColor(Color.movieFont)
            .padding(20)
    }
    
    var ratings: some View {
        HStack(spacing: 15) {
            Image(systemName: "star.fill")
                .renderingMode(.template)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.movieAccent)
            Text(doubleExtract(voteAverage: presenter.detail?.voteAverage))
                .font(.title)
                .bold()
                .foregroundColor(Color.movieFont)
        }.padding()
    }
        
    func textExtract(oText: String?) -> String {
        guard let nText = oText else { return "Text Error" }
        return nText
    }
    
    func dateExtract(oText: String?) -> String {
        guard let nText = oText else { return "Text Error" }
        return Helper.dateConverter(format: nText)
    }
    
    func genreExtract(genres: [GenreModel]?) -> String {
        guard let mGenres = genres else { return "No Genres" }
        var textGenre = ""
        for (dex, genre) in mGenres.enumerated() {
            if dex != 0 {
                textGenre += ", "
            }
            textGenre += genre.name
        }
        return textGenre
    }
    
    func doubleExtract(voteAverage: Double?) -> String {
        guard let dVote = voteAverage else { return "0.0" }
        let vote = String(format: "%.1f", dVote)
        return "\(vote)"
    }
}
