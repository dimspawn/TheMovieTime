//
//  DetailDomainModel.swift
//  Detail
//
//  Created by Dimas Wicaksono on 06/01/22.
//

public struct GenreDomainModel: Equatable, Identifiable {
    public let id: Int
    public let name: String
}

public struct DetailDomainModel: Equatable, Identifiable {
    public let id: Int
    public let backdropPath: String?
    public let genres: [GenreDomainModel]
    public let overview: String
    public let popularity: Double
    public let posterPath: String?
    public let releaseDate: String
    public let runtime: Int?
    public let tagline: String
    public let title: String
    public let voteAverage: Double
    public let voteCount: Int
}

