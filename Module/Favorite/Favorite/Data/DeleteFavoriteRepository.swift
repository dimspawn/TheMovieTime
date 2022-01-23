//
//  DeleteRepository.swift
//  Favorite
//
//  Created by Dimas Wicaksono on 20/01/22.
//

import Combine
import Core
import MovieDomain

public struct DeleteFavoriteRepository<
    FavoriteLocalDataSource: LocalDataSource,
    Transformer: Mapper>: Repository
where
FavoriteLocalDataSource.Response == FavoriteModuleEntity,
Transformer.Response == Any,
Transformer.Entity == FavoriteModuleEntity,
Transformer.Domain == DetailModel{
    public typealias Request = DetailModel
    public typealias Response = Bool
    
    private let _localDataSource: FavoriteLocalDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: FavoriteLocalDataSource,
        mapper: Transformer
    ) {
        _localDataSource = localDataSource
        _mapper = mapper
    }
    
    public func execute(request: DetailModel?) -> AnyPublisher<Bool, Error> {
        guard let detail = request else { fatalError() }
        let favModel = _mapper.tranformDomainToEntity(domain: detail)
        return _localDataSource.delete(entity: favModel).eraseToAnyPublisher()
    }
    
}
