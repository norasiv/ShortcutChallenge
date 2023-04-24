//
//  Alert.swift
//  ShortcutChallenge
//
//  Created by Nora Sivertsen Bull on 22/04/2023.
//

import Foundation
import UIKit


//MARK: - Alerts
extension UIViewController {
    
    func Alert(alertTitle: String, alertText: String, style: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: alertText, message: alertText, preferredStyle: style)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


//MARK: - Spinner
var spinner : UIView?
let indicator = UIActivityIndicatorView(frame: CGRect(x: 150, y: 180, width: 30, height: 30))

extension UIViewController {
    
    func spinnerAlert(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.frame = CGRect(x: 33, y: 300, width: 350, height: 360)
        spinnerView.backgroundColor = UIColor.white
        
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large

        DispatchQueue.main.async {
            spinnerView.addSubview(indicator)
            onView.addSubview(spinnerView)
        }
        spinner = spinnerView
    }
    
    func stopSpinner() {
        DispatchQueue.main.async {
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }
    
}
