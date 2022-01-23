//
//  Mapper.swift
//  Core
//
//  Created by Dimas Wicaksono on 01/01/22.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func tranformResponseToEntity(response: Response) -> Entity
    func tranformEntityToDomain(entity: Entity) -> Domain
    func tranformResponseToDomain(response: Response) -> Domain
    func tranformDomainToEntity(domain: Domain) -> Entity
}
