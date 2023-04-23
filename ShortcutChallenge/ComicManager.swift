//
//  ComicManager.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 21/04/2023.
//

import Foundation


protocol ComicManagerDelegate {
    func didFetchComic(_ comicManager: ComicManager, comic: Comic)
    func didGetError(error: Error)
}


struct ComicManager {
    
    var delegate: ComicManagerDelegate?

    func fetchComic(comicId: String){
        let urlString = "https://xkcd.com/\(comicId)/info.0.json"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didGetError(error: error!)
                    return
                }
                if let fetchedData = data {
                    if let comic = self.parseJSON(fetchedData) {
                        self.delegate?.didFetchComic(self, comic: comic)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ comicData: Data) -> Comic? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Comic.self, from: comicData)
            let month = decodedData.month
            let num = decodedData.num
            let link = decodedData.link
            let year = decodedData.year
            let news = decodedData.news
            let safe_title = decodedData.safe_title
            let transcript = decodedData.transcript
            let alt = decodedData.alt
            let img = decodedData.img
            let title = decodedData.title
            let day = decodedData.day
            
            let comic = Comic(month: month, num: num, link: link, year: year, news: news, safe_title: safe_title, transcript: transcript, alt: alt, img: img, title: title, day: day)
            return comic
        } catch {
            delegate?.didGetError(error: error)
            return nil
        }
    }
    
    
}
