//
//  Alert.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 22/04/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func Alert(alertTitle: String, alertText: String, style: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: alertText, message: alertText, preferredStyle: style)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
