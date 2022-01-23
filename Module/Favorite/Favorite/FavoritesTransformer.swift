//
//  FavoritesTransformer.swift
//  Favorite
//
//  Created by Dimas Wicaksono on 18/01/22.
//

import Core
import MovieDomain

public struct FavoritesTransformer: Mapper {
    public typealias Response = Any
    public typealias Entity = [FavoriteModuleEntity]
    public typealias Domain = [FavoriteModel]
     
    public init() {}
    
    public func tranformResponseToEntity(response: Any) -> [FavoriteModuleEntity] {
        fatalError()
    }
    
    public func tranformEntityToDomain(entity: [FavoriteModuleEntity]) -> [FavoriteModel] {
        return entity.map { result in
            return FavoriteModel(
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
    
    public func tranformResponseToDomain(response: Any) -> [FavoriteModel] {
        fatalError()
    }
    
    public func tranformDomainToEntity(domain: [FavoriteModel]) -> [FavoriteModuleEntity] {
        return domain.map { result in
            let favorite = FavoriteModuleEntity()
            favorite.id = result.id
            favorite.title = result.title
            favorite.posterPath = result.posterPath ?? ""
            favorite.overview = result.overview
            favorite.popularity = result.popularity
            favorite.releaseDate = result.releaseDate ?? "TBA"
            favorite.voteAverage = result.voteAverage
            favorite.voteCount = result.voteCount
            return favorite
        }
    }
//    public func tranformResponseToEntity(response: [FavoriteModel]) -> [FavoriteModuleEntity] {
//        return response.map { result in
//            let favorite = FavoriteModuleEntity()
//            favorite.id = result.id
//            favorite.title = result.title
//            favorite.posterPath = result.posterPath ?? ""
//            favorite.overview = result.overview
//            favorite.popularity = result.popularity
//            favorite.releaseDate = result.releaseDate ?? "TBA"
//            favorite.voteAverage = result.voteAverage
//            favorite.voteCount = result.voteCount
//            return favorite
//        }
//    }
//
//    public func tranformEntityToDomain(entity: [FavoriteModuleEntity]) -> [FavoriteModel] {
//        return entity.map { result in
//            return FavoriteModel(
//                id: result.id,
//                title: result.title,
//                posterPath: result.posterPath,
//                overview: result.overview,
//                popularity: result.popularity,
//                releaseDate: result.releaseDate,
//                voteAverage: result.voteAverage,
//                voteCount: result.voteCount
//            )
//        }
//    }
//
//    public func tranformResponseToDomain(response: [FavoriteModel]) -> [FavoriteModel] {
//        return response
//    }
}
