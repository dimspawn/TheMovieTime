//
//  DetailTransformer.swift
//  Detail
//
//  Created by Dimas Wicaksono on 06/01/22.
//

import Core
import MovieDomain

public struct DetailTransformer: Mapper {
    public typealias Response = DetailModuleResponse
    public typealias Entity = Any
    public typealias Domain = DetailModel
    
    public init() {}
    
    public func tranformResponseToDomain(response: DetailModuleResponse) -> DetailModel {
        return DetailModel(
            id: response.id ?? 0,
            backdropPath: response.backdropPath,
            genres: response.genres.map { genre in
                return GenreModel(id: genre.id ?? 0, name: genre.name ?? "")
            },
            overview: response.overview ?? "",
            popularity: response.popularity ?? 0,
            posterPath: response.posterPath,
            releaseDate: response.releaseDate ?? "TBA",
            runtime: response.runtime ?? 0,
            tagline: response.tagline ?? "[No Tagline]",
            title: response.title ?? "[No Title]",
            voteAverage: response.voteAverage ?? 0.0,
            voteCount: response.voteCount ?? 0)
    }
    
    public func tranformEntityToDomain(entity: Any) -> DetailModel {
        fatalError()
    }
    
    public func tranformResponseToEntity(response: DetailModuleResponse) -> Any {
        fatalError()
    }
    
    public func tranformDomainToEntity(domain: DetailModel) -> Any {
        fatalError()
    }
}
