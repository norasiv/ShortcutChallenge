//
//  FavoritesManager.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 25/04/2023.
//

import Foundation
import UIKit


class FavoritesManager: UIViewController {


    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var favoritedComics = [String?: [MyFavoriteComics]]()
    var model = [MyFavoriteComics]()

    //MARK: - save and fetch data with CoreData
    func saveComics(title: String, img: String, num: Int) {
        let favoriteComics = MyFavoriteComics(context: context)
        favoriteComics.title = title
        favoriteComics.img = img
        favoriteComics.num = Int16(num)
        do {
            try context.save()
            print("comic saved")
        }
        catch {
            print("there was an error \(error)")
        }
    }
    

    func fetchFavoriteComics() -> [String?: [MyFavoriteComics]] {
        do {
            model = try context.fetch(MyFavoriteComics.fetchRequest())
            favoritedComics = Dictionary(grouping: model, by: {$0.title})
            print("Comics have been fetched")
        }
        catch {
            print("there was an error \(error)")
        }
        return favoritedComics
    }

}
