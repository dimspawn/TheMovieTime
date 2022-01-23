//
//  FavoriteDomainModel.swift
//  Favorite
//
//  Created by Dimas Wicaksono on 18/01/22.
//

import Foundation

public struct FavoriteDomainModel: Equatable, Identifiable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let overview: String
    public let popularity: Double
    public let releaseDate: String?
    public let voteAverage: Double
    public let voteCount: Int
}
