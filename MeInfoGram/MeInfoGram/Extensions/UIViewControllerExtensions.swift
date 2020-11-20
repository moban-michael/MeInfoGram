//
//  UIViewControllerExtensions.swift
//  MeInfoGram
//
//  Created by Moban K Michael on 20/11/2020.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showAlert(_ str:String) {
        DispatchQueue.main.async() {
            self.hideProgress()
            //i18n:
            let alertViewController = UIAlertController(title: "MeInfoGram", message: str, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            }
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    func setLeftBackBarButtonItem() {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backClicked))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc public func backClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showProgress(with title: String? = nil) {
        onMainQueue {
            let progress = MBProgressHUD.showAdded(to: self.view, animated: true)
            progress.label.text = title ?? "Loading..."
        }
    }
    
    func hideProgress() {
        onMainQueue {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func className() -> String {
        return String(describing: type(of: self))
    }
}
