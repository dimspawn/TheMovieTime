//
//  GetFavoriteRepository.swift
//  Favorite
//
//  Created by Dimas Wicaksono on 20/01/22.
//

import Combine
import Core
import MovieDomain

public struct GetFavoriteRepository<
    FavoriteLocalDataSource: LocalDataSource,
    Transformer: Mapper>: Repository
where
FavoriteLocalDataSource.Response == FavoriteModuleEntity,
Transformer.Response == Any,
Transformer.Entity == [FavoriteModuleEntity],
Transformer.Domain == [FavoriteModel]{
    public typealias Request = Any
    public typealias Response = [FavoriteModel]
    
    private let _localDataSource: FavoriteLocalDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: FavoriteLocalDataSource,
        mapper: Transformer
    ) {
        _localDataSource = localDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[FavoriteModel], Error> {
        return _localDataSource.list(request: nil)
            .map { _mapper.tranformEntityToDomain(entity: $0)}
            .eraseToAnyPublisher()
    }
}
