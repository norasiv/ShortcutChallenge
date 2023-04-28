//
//  MyFavoriteComics+CoreDataProperties.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 27/04/2023.
//
//

import Foundation
import CoreData


extension MyFavoriteComics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyFavoriteComics> {
        return NSFetchRequest<MyFavoriteComics>(entityName: "MyFavoriteComics")
        
    }

    @NSManaged public var title: String?
    @NSManaged public var img: String?
    @NSManaged public var num: Int16

}

extension MyFavoriteComics : Identifiable {

}
