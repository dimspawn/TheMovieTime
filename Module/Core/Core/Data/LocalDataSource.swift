//
//  LocalDataSource.swift
//  Core
//
//  Created by Dimas Wicaksono on 01/01/22.
//

import Combine

public protocol LocalDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func delete(entity: Response) -> AnyPublisher<Bool, Error>
    func isExist(id: Int) -> AnyPublisher<Bool, Error>
}
