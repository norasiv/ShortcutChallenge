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
var spinnerView = UIView()
var spinner : UIView?
var spinnerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))


extension UIViewController {
    
    
    func spinnerAlert(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        spinnerView.backgroundColor = UIColor.white
        
        spinnerLabel.font = UIFont(name: "Arial", size: 12)
        spinnerLabel.sizeToFit()
        spinnerLabel.center = CGPoint(x: spinnerView.center.x, y: spinnerView.center.y - 30)
        
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        indicator.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(spinnerLabel)
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
