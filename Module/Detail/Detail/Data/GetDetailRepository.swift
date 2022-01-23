//
//  GetDetailRepository.swift
//  Detail
//
//  Created by Dimas Wicaksono on 06/01/22.
//

import Combine
import Core
import MovieDomain

public struct GetDetailRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
RemoteDataSource.Response == DetailModuleResponse,
Transformer.Response == DetailModuleResponse,
Transformer.Entity == Any,
Transformer.Domain == DetailModel {
    public typealias Request = Int
    public typealias Response = DetailModel
    
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Int?) -> AnyPublisher<DetailModel, Error> {
        return _remoteDataSource.execute(request: request as? RemoteDataSource.Request)
            .map{ _mapper.tranformResponseToDomain(response: $0)}
            .eraseToAnyPublisher()
    }
}
