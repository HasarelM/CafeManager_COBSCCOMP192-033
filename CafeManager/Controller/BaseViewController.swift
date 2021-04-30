//
//  BaseViewController.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-28.
//

import Foundation
import UIKit
import Loaf
import NotificationBannerSwift
import CoreLocation

class BaseViewController : UIViewController {
    var networkMonitor = NetworkMonitor.instance
    var progressHUD: ProgressHUD!
    var alertController: UIAlertController!
    var firebaseOP = FirebaseOP.instance
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressHUD = ProgressHUD(view: view)
    }
    
    func displayProgress() {
        progressHUD.displayProgressHUD()
    }
    
    func dismissProgress() {
        progressHUD.dismissProgressHUD()
    }
    
    func displayErrorMessage(message: String, completion: (() -> Void)?) {
        
        guard let completionHandler = completion else {
            displayBanner(type: .ERROR, body: message)
            return
        }
        
        Loaf(message, state: .error, sender: self).show(.custom(2.0)) {
            dismissal in
            completionHandler()
        }
    }
    
    func displaySuccessMessage(message: String, completion: (() -> Void)?) {
        
        guard let completionHandler = completion else {
            displayBanner(type: .SUCCESS, body: message)
            return
        }
        
        Loaf(message, state: .success, sender: self).show(.custom(2.0)) {
            dismissal in
            completionHandler()
        }
    }
    
    func displayInfoMessage(message: String, completion: (() -> Void)?) {
        
        guard let completionHandler = completion else {
            displayBanner(type: .INFO, body: message)
            return
        }
        
        Loaf(message, state: .info, sender: self).show(.custom(2.0)) {
            dismissal in
            completionHandler()
        }
    }
    
    func displayWarningMessage(message: String, completion: (() -> Void)?) {
        
        guard let completionHandler = completion else {
            displayBanner(type: .WARNING, body: message)
            return
        }
        
        Loaf(message, state: .warning, sender: self).show(.custom(2.0)) {
            dismissal in
            completionHandler()
        }
    }
    
    func displayProgressBanner() {
        GrowingNotificationBanner(title: "NIBM Cafe", subtitle: "Please wait", style: .info).show()
    }
    
    fileprivate func displayBanner(type: BANNER_TYPE, body: String) {
        switch type {
            case .SUCCESS:
                GrowingNotificationBanner(title: "Cafeterria", subtitle: "Success", style: .success).show()
            case .WARNING:
                GrowingNotificationBanner(title: "Cafeterria", subtitle: "Warning", style: .warning).show()
            case .INFO:
                GrowingNotificationBanner(title: "Cafeterria", subtitle: "Information", style: .info).show()
            case .ERROR:
                GrowingNotificationBanner(title: "Cafeterria", subtitle: "Error", style: .danger).show()
        }
    }
    
    func displayActionSheet(title: String, message: String, actionTitle1: String, actionTitle2: String, actionHandler1: @escaping (UIAlertAction) -> Void, actionHandler2: @escaping (UIAlertAction) -> Void) {
        alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        alertController.title = title
        alertController.message = message
        alertController.addAction(UIAlertAction(title: actionTitle1, style: .destructive, handler: actionHandler1))
        alertController.addAction(UIAlertAction(title: actionTitle2, style: .default, handler: actionHandler2))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayActionSheet(title: String, message: String, positiveTitle: String, negativeTitle: String, positiveHandler: @escaping (UIAlertAction) -> Void) {

        alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        alertController.title = title
        alertController.message = message
        alertController.addAction(UIAlertAction(title: positiveTitle, style: .default, handler: positiveHandler))
        alertController.addAction(UIAlertAction(title: negativeTitle, style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    enum BANNER_TYPE {
        case SUCCESS
        case WARNING
        case INFO
        case ERROR
    }
}
