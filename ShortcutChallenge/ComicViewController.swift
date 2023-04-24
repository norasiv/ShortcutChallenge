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
        spinnerAlert(onView: self.view)
        fetchedComic()
    }
    
    //MARK: - fetches comics with id
    func fetchedComic(){
        let id = String(comicId)
        comicManager.fetchComic(comicId: id)
    }
    
    
    @IBAction func nextPressed(_ sender: Any) {
        if comicId != 2765 {
            spinnerAlert(onView: self.view)
            comicId += 1
            fetchedComic()
        }
    }
    
    @IBAction func previousPressed(_ sender: Any) {
        if comicId != 1 {
            spinnerAlert(onView: self.view)
            comicId -= 1
            fetchedComic()
        }
    }
    
    @IBAction func randomPressed(_ sender: Any) {
        spinnerAlert(onView: self.view)
        generateRandomId()
    }
    
    //MARK: - Gets random number
    func generateRandomId() {
        let randomId = Int.random(in: 1..<2765)
        comicId = randomId
        fetchedComic()
    }
    
}


//MARK: - ComicManagerDelegate
extension ComicViewController: ComicManagerDelegate {
    func didFetchComic(_ comicManager: ComicManager, comic: Comic) {
        DispatchQueue.main.async {
            self.comicTitle.text = comic.title
        }
        ImageFetcher().fetchComicImage(comic.img) { image in
            DispatchQueue.main.async {
                self.stopSpinner()
                self.comicImage.image = image ?? UIImage(named: "Image Not Found")
                }
        }
    }
    
    func didGetError(error: Error) {
        stopSpinner()
        print(error)
        Alert(alertTitle: "There was an error", alertText: error.localizedDescription)
    }
    
}


