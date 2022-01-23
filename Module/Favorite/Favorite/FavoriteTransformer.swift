//
//  FavoriteTransformer.swift
//  Favorite
//
//  Created by Dimas Wicaksono on 20/01/22.
//

import Core
import MovieDomain

public struct FavoriteTransformer: Mapper {
    public typealias Response = Any
    public typealias Entity = FavoriteModuleEntity
    public typealias Domain = DetailModel
     
    public init() {}
    
    public func tranformResponseToEntity(response: Any) -> FavoriteModuleEntity {
        fatalError()
    }
    
    public func tranformEntityToDomain(entity: FavoriteModuleEntity) -> DetailModel {
        fatalError()
    }
    
    public func tranformResponseToDomain(response: Any) ->DetailModel {
        fatalError()
    }
    
    public func tranformDomainToEntity(domain: DetailModel) -> FavoriteModuleEntity {
        let favorite = FavoriteModuleEntity()
        favorite.id = domain.id
        favorite.title = domain.title
        favorite.posterPath = domain.posterPath ?? ""
        favorite.overview = domain.overview
        favorite.popularity = domain.popularity
        favorite.releaseDate = domain.releaseDate
        favorite.voteAverage = domain.voteAverage
        favorite.voteCount = domain.voteCount
        return favorite
    }
}
