//
//  GetNowPlayingLocalDataSource.swift
//  NowPlaying
//
//  Created by Dimas Wicaksono on 01/01/22.
//

import Foundation
import Core
import RealmSwift
import Combine
import Common

public struct NowPlayingLocalDataSource: LocalDataSource {    
    public typealias Request = Any
    public typealias Response = NowPlayingModuleEntity
    
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func get(id: String) -> AnyPublisher<NowPlayingModuleEntity, Error> {
        fatalError()
    }
    
    public func delete(entity: NowPlayingModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func isExist(id: Int) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func list(request: Any?) -> AnyPublisher<[NowPlayingModuleEntity], Error> {
        return Future<[NowPlayingModuleEntity], Error> { completion in
            let movies: Results<NowPlayingModuleEntity> = {
                realm.objects(NowPlayingModuleEntity.self)
                    .sorted(byKeyPath: "title",ascending: true)
            }()
            completion(.success(movies.toArray(ofType: NowPlayingModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [NowPlayingModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try realm.write {
                    for entity in entities {
                        realm.add(entity, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
