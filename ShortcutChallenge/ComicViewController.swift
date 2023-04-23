//
//  ViewController.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 21/04/2023.
//

import UIKit

class ComicViewController: UIViewController {
    
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var explainButton: UIButton!
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var comicManager = ComicManager()
    var comicId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "xkcd"
        
        comicManager.delegate = self
        fetchedComic()
    }
    
    
    func fetchedComic(){
        let id = String(comicId)
        comicManager.fetchComic(comicId: id)
    }
    
    
    @IBAction func nextPressed(_ sender: Any) {
        comicId += 1
        fetchedComic()
    }
    
    
    @IBAction func previousPressed(_ sender: Any) {
        comicId -= 1
        fetchedComic()
    }
    
    @IBAction func randomPressed(_ sender: Any) {
        generateRandomId()
    }
    
    func generateRandomId() {
        let randomId = Int.random(in: 1..<2765)
        comicId = randomId
        fetchedComic()
    }
    
}



extension ComicViewController: ComicManagerDelegate {
    func didFetchComic(_ comicManager: ComicManager, comic: Comic) {
        DispatchQueue.main.async {
            self.comicTitle.text = comic.title
        }
        ImageFetcher().fetchComicImage(comic.img) { image in
            DispatchQueue.main.async {
                self.comicImage.image = image ?? UIImage(named: "Image Not Found")
                }
        }
    }
    
    func didGetError(error: Error) {
        print(error)
        Alert(alertTitle: "There was an error", alertText: error.localizedDescription)
    }
    
}


