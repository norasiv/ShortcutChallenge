//
//  FavoritesViewController.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 25/04/2023.
//

import Foundation
import UIKit



class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var favoritesManager = FavoritesManager()
    var comics = [String?: [MyFavoriteComics]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorite Comics"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FavoritesCell", bundle: nil), forCellReuseIdentifier: "FavoritesCell")
    }
    
    //updates every time user goes to view
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { [self] in
            comics = favoritesManager.fetchFavoriteComics()
            tableView.reloadData()
            print(comics)
            if comics.count == 0 {
                print("Nothing is saved")
            }
        }
        
    }
    
}


//MARK: - Tableview favorites
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        comics.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(comics)[section].value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesCell
        cell.titleLabel.text = Array(comics)[indexPath.section].value[indexPath.row].title
        cell.numberLabel.text = String(Array(comics)[indexPath.section].value[indexPath.row].num)
        
        ImageFetcher().fetchComicImage(Array(comics)[indexPath.section].value[indexPath.row].img ?? "") { image in
            DispatchQueue.main.async {
                cell.comicImage.image = image ?? UIImage(named: "Image Not Found")
                }
        }
        
        return cell
    }

}
