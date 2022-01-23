//
//  FavoriteLocalDataSource.swift
//  Detail
//
//  Created by Dimas Wicaksono on 06/01/22.
//

import Foundation
import RealmSwift

public struct GenreModuleResponse: Decodable {
    let id: Int?
    let name: String?
}

public struct DetailModuleResponse: Decodable {
    let id: Int?
    let backdropPath: String?
    let genres: [GenreModuleResponse]
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let tagline: String?
    let title: String?
    let voteAverage: Double?
    let voteCount: Int?

    public enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genres
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case tagline
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
