//
//  DetailsViewController.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 24/04/2023.
//

import Foundation
import UIKit

class DetailsViewController: UICollectionViewController {
    
    var comicManager = ComicManager()
    var comicId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        comicManager.delegate = self
        
        fetchedComic()
    }
    
    func fetchedComic(){
        print(comicId)
        let id = String(comicId)
        comicManager.fetchComic(comicId: id)
    }
    
}


//MARK: - ComicManagerDelegate
extension DetailsViewController: ComicManagerDelegate {
    func didFetchComic(_ comicManager: ComicManager, comic: Comic) {
        DispatchQueue.main.async {
            print(comic.title)
        }
    }
    
    func didGetError(error: Error) {
        stopSpinner()
        print(error)
        Alert(alertTitle: "There was an error", alertText: error.localizedDescription)
    }
    
}


