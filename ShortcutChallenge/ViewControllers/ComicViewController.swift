//
//  ViewController.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 21/04/2023.
//

import UIKit

class ComicViewController: UIViewController, UITextFieldDelegate {
    
    
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
    var favoritesManager = FavoritesManager()
    var comicModel: Comic?
    var comicId = 1
    var isHeartPressed = false
    let heartFilled = UIImage(named: "HeartFilled")
    let heartNotFilled = UIImage(named: "Heart")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "xkcd"
        
        comicManager.delegate = self
        searchField.delegate = self
        spinnerAlert(onView: self.view)
        fetchedComic()
    }
    
    //MARK: - fetches comics with id
    func fetchedComic(){
        let id = String(comicId)
        comicManager.fetchComic(comicId: id)
        favoriteButton.setImage(heartNotFilled, for: .normal)
    }
    
    //MARK: - Next, Previous or Random comic
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
    
    func generateRandomId() {
        let randomId = Int.random(in: 1..<2765)
        comicId = randomId
        fetchedComic()
    }
    
    
    //MARK: - Search by comic number
    @IBAction func searchPressed(_ sender: Any) {
        searchField.endEditing(true)
        print(searchField.text!)
    }
    
    // click on keyboard to search
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        print(searchField.text!)
        return true
    }
    
    // fetches comic with inputnumber
    func textFieldDidEndEditing(_ textField: UITextField) {
            let newId = Int(searchField.text ?? "") ?? 0
            comicId = newId
            spinnerAlert(onView: self.view)
            comicManager.fetchComic(comicId: String(comicId))
            
        searchField.text = ""
    }
    

    
    //MARK: - Sends comicId to DetailsViewController and presents it
    @IBAction func detailsPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "comicDetails", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController {
            vc.comicId = comicId
        }
    }
    
    //MARK: - Sends user to explanation website
    @IBAction func explanationPressed(_ sender: Any) {
        guard let url = URL(string: "https://www.explainxkcd.com/wiki/index.php/\(comicId)") else { return }
        UIApplication.shared.open(url)
    }
    
    
    //MARK: - Favorite comics and save to core data
    @IBAction func heartPressed(_ sender: Any) {
        saveComic()
    }
    
    func saveComic() {
        let title = comicModel?.title ?? "Not"
        let img = comicModel?.img ?? "Working"
        let num = comicModel?.num ?? 0
        favoritesManager.saveComics(title: title, img: img, num: num)
        favoriteButton.setImage(heartFilled, for: .normal)
    }
    
}


//MARK: - ComicManagerDelegate
extension ComicViewController: ComicManagerDelegate {
    
    func didFetchComic(_ comicManager: ComicManager, comic: Comic) {
        comicModel = comic
        DispatchQueue.main.async {
            self.comicTitle.text = "\(comic.title) (\(self.comicId))"
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


