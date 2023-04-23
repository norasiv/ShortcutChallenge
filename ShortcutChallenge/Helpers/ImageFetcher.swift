//
//  Image.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 23/04/2023.
//

import Foundation
import UIKit


class ImageFetcher {
    
    //Recieves url from API and returns an image if it excists
    func fetchComicImage(_ imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let data = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        .resume()
    }
}
