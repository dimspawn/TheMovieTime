//
//  FavoriteLocalDataSource.swift
//  Favorite
//
//  Created by Dimas Wicaksono on 18/01/22.
//

import Foundation
import Core
import RealmSwift
import Combine
import Common

public struct FavoriteLocalDataSource: LocalDataSource {
    public typealias Request = Any
    public typealias Response = FavoriteModuleEntity
    
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func get(id: String) -> AnyPublisher<FavoriteModuleEntity, Error> {
        fatalError()
    }
    
    public func delete(entity: FavoriteModuleEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                let movie = realm.objects(FavoriteModuleEntity.self).filter("id = \(entity.id)").first
                try realm.write {
                    if let favMovie = movie {
                        realm.delete(favMovie)
                        completion(.success(true))
                    } else {
                        completion(.failure(DatabaseError.requestFailed))
                    }
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func isExist(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let movie = realm.objects(FavoriteModuleEntity.self).filter("id = \(id)").first
            if movie != nil {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        }.eraseToAnyPublisher()
    }
    
    public func list(request: Any?) -> AnyPublisher<[FavoriteModuleEntity], Error> {
        return Future<[FavoriteModuleEntity], Error> { completion in
            let movies: Results<FavoriteModuleEntity> = {
                realm.objects(FavoriteModuleEntity.self)
                    .sorted(byKeyPath: "title",ascending: true)
            }()
            completion(.success(movies.toArray(ofType: FavoriteModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [FavoriteModuleEntity]) -> AnyPublisher<Bool, Error> {
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
