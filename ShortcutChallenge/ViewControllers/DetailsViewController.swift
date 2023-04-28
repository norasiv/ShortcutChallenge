//
//  DetailsViewController.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 24/04/2023.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var safeLabel: UILabel!
    @IBOutlet weak var transcriptLabel: UILabel!
    @IBOutlet weak var altLabel: UILabel!
    @IBOutlet weak var imgLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    var comicManager = ComicManager()
    var comicId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            self.monthLabel.text = "Month: \(comic.month)"
            self.numLabel.text = "Num: \(String(comic.num))"
            self.linkLabel.text = "Link: \(comic.link)"
            self.yearLabel.text = "Year: \(comic.year)"
            self.newsLabel.text = "News: \(comic.news)"
            self.safeLabel.text = "Safe Title: \(comic.safe_title)"
            self.transcriptLabel.text = "Transcript: \(comic.transcript)"
            self.altLabel.text = "Alt: \(comic.alt)"
            self.imgLabel.text = "Img: \(comic.img)"
            self.titleLabel.text = "Title: \(comic.title)"
            self.dayLabel.text = "Day: \(comic.day)"
        }
    }
    
    func didGetError(error: Error) {
        stopSpinner()
        print(error)
        Alert(alertTitle: "There was an error", alertText: error.localizedDescription)
    }
    
}


