//
//  NowPlayingTransformer.swift
//  NowPlaying
//
//  Created by Dimas Wicaksono on 01/01/22.
//

import Core
import MovieDomain

public struct NowPlayingTransformer: Mapper {
    public typealias Response = [NowPlayingResponse]
    public typealias Entity = [NowPlayingModuleEntity]
    public typealias Domain = [NowPlayingModel]
     
    public init() {}
    
    public func tranformResponseToEntity(response: [NowPlayingResponse]) -> [NowPlayingModuleEntity] {
        return response.map { result in
            let newNowPlaying = NowPlayingModuleEntity()
            newNowPlaying.id = result.id ?? 0
            newNowPlaying.title = result.title ?? "No Title"
            newNowPlaying.posterPath = result.posterPath ?? ""
            newNowPlaying.overview = result.overview ?? ""
            newNowPlaying.popularity = result.popularity ?? 0.0
            newNowPlaying.releaseDate = result.releaseDate ?? "TBA"
            newNowPlaying.voteAverage = result.voteAverage ?? 0.0
            newNowPlaying.voteCount = result.voteCount ?? 0
            return newNowPlaying
        }
    }
    
    public func tranformEntityToDomain(entity: [NowPlayingModuleEntity]) -> [NowPlayingModel] {
        return entity.map { result in
            return NowPlayingModel(
                id: result.id,
                title: result.title,
                posterPath: result.posterPath,
                overview: result.overview,
                popularity: result.popularity,
                releaseDate: result.releaseDate,
                voteAverage: result.voteAverage,
                voteCount: result.voteCount
            )
        }
    }
    
    public func tranformResponseToDomain(response: [NowPlayingResponse]) -> [NowPlayingModel] {
        return response.map { result in
            return NowPlayingModel(
                id: result.id ?? 0,
                title: result.title ?? "No Title",
                posterPath: result.posterPath,
                overview: result.overview ?? "",
                popularity: result.popularity ?? 0.0,
                releaseDate: result.releaseDate,
                voteAverage: result.voteAverage ?? 0.0,
                voteCount: result.voteCount ?? 0
            )
        }
    }
    
    public func tranformDomainToEntity(domain: [NowPlayingModel]) -> [NowPlayingModuleEntity] {
        fatalError()
    }
}
