//
//  UpdateProfileViewController.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-30.
//

import UIKit

class UpdateProfileViewController: BaseViewController {

    @IBOutlet weak var txtUserName: CustomTextField!
    @IBOutlet weak var txtPhoneNo: CustomTextField!
    @IBOutlet weak var imgProfile: UIImageView!
    
    let user = SessionManager.getUserSesion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgProfile.generateRoundImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firebaseOP.delegate = self
        txtUserName.text = user?.userName
        txtPhoneNo.text = user?.phoneNo
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUpdatePressed(_ sender: UIButton) {
        if !InputFieldValidator.isValidName(txtUserName.text ?? "") {
            txtUserName.clearText()
            txtUserName.displayInlineError(errorString: InputErrorCaptions.invalidName)
            return
        }
        if !InputFieldValidator.isValidMobileNo(txtPhoneNo.text ?? "") {
            txtPhoneNo.clearText()
            txtPhoneNo.displayInlineError(errorString: InputErrorCaptions.invalidPhoneNo)
            return
        }
        
        guard var user = user else {
            NSLog("User data is empty")
            displayErrorMessage(message: "Could not update user!", completion: nil)
            return
        }
        
        user.userName = txtUserName.text
        user.phoneNo = txtPhoneNo.text
        displayProgress()
        firebaseOP.updateUser(user: user)
    }
    
}

extension UpdateProfileViewController: FirebaseActions {
    func onConnectionLost() {
        refreshControl.endRefreshing()
        dismissProgress()
        displayWarningMessage(message: "Please check internet connection", completion: nil)
    }
    
    func onUserDataUpdated(user: User?) {
        dismissProgress()
        SessionManager.saveUserSession(user!)
        displaySuccessMessage(message: "Profile updated successfully!", completion: {
//            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
    }
    func onUserUpdateFailed(error: String) {
        dismissProgress()
        displayErrorMessage(message: error, completion: nil)
    }
}
