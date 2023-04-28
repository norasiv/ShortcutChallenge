//
//  LicensingViewController.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 28/04/2023.
//

import Foundation
import UIKit


class LicensingViewController: UIViewController {
    
    
    
    @IBOutlet weak var licenseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        licenseLabel.text = "This work is licensed under a Creative Commons Attribution-NonCommercial 2.5 License"
    }
    
    
    @IBAction func goToPressed(_ sender: Any) {
        guard let url = URL(string: "https://xkcd.com") else { return }
        UIApplication.shared.open(url)
    }
    
}
