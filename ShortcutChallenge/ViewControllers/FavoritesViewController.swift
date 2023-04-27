//
//  FavoritesViewController.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 25/04/2023.
//

import Foundation
import UIKit





class FavoritesViewController: UIViewController {
    
    var favoritesManager = FavoritesManager()
    var comics = [String?: [MyFavoriteComics]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorite Comics"
    }
    
    //updates every time user goes to view
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { [self] in
            comics = favoritesManager.fetchFavoriteComics()
            print(comics)
            if comics.count == 0 {
                print("Nothing is saved")
            }
        }
        
    }
    
}
