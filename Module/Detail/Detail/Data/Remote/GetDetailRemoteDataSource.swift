//
//  GetFavoriteLocalDataSource.swift
//  Detail
//
//  Created by Dimas Wicaksono on 06/01/22.
//

import Foundation
import Core
import Realm
import Combine
import Alamofire
import Common

public struct GetDetailRemoteDataSource: DataSource {
    public typealias Request = Int
    public typealias Response = DetailModuleResponse
//    private let _endpoint: String
//    public init(endpoint: String) {
//        _endpoint = endpoint
//    }
    public init(){}
    
    public func execute(request: Int?) -> AnyPublisher<DetailModuleResponse, Error> {
        return Future<DetailModuleResponse, Error> { completion in
            guard let id = request else { fatalError() }
            if let url = URL(string: Endpoints.Gets.movieDetail(id: id).url) {
                AF.request(url).validate()
                    .responseDecodable(of: DetailModuleResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
