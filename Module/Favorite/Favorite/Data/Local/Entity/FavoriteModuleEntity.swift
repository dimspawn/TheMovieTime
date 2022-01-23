//
//  FavoriteModuleEntity.swift
//  Favorite
//
//  Created by Dimas Wicaksono on 18/01/22.
//

import Foundation
import RealmSwift

public class FavoriteModuleEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
