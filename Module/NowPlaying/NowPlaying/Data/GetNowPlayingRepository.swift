//
//  GetNowPlayingRepository.swift
//  NowPlaying
//
//  Created by Dimas Wicaksono on 01/01/22.
//

import Combine
import Core
import MovieDomain

public struct GetNowPlayingRepository<
    NowPlayingLocalDataSource: LocalDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
NowPlayingLocalDataSource.Response == NowPlayingModuleEntity,
RemoteDataSource.Response == [NowPlayingResponse],
Transformer.Response == [NowPlayingResponse],
Transformer.Entity == [NowPlayingModuleEntity],
Transformer.Domain == [NowPlayingModel]{
    public typealias Request = Any
    public typealias Response = [NowPlayingModel]
    
    private let _localDataSource: NowPlayingLocalDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: NowPlayingLocalDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        _localDataSource = localDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[NowPlayingModel], Error> {
        return _localDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[NowPlayingModel], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(request: nil)
                        .map { _mapper.tranformResponseToEntity(response: $0)}
                        .catch { _ in _localDataSource.list(request: nil)}
                        .flatMap { _localDataSource.add(entities: $0)}
                        .filter { $0 }
                        .flatMap { _ in _localDataSource.list(request: nil)
                            .map { _mapper.tranformEntityToDomain(entity: $0)}
                        }.eraseToAnyPublisher()
                } else {
                    return _localDataSource.list(request: nil)
                        .map { _mapper.tranformEntityToDomain(entity: $0)}
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
