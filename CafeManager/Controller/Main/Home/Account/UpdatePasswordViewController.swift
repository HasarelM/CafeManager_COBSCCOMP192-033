//
//  UpdatePasswordViewController.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-30.
//

import UIKit

class UpdatePasswordViewController: BaseViewController {

    @IBOutlet weak var txtCurrentPassword: CustomTextField!
    @IBOutlet weak var txtNewPassword: CustomTextField!
    @IBOutlet weak var txtConfirmPassword: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firebaseOP.delegate = self
    }

    @IBAction func onBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUpdatePressed(_ sender: UIButton) {
        if !InputFieldValidator.isValidPassword(pass: txtCurrentPassword.text ?? "", minLength: 6, maxLength: 20){
            txtCurrentPassword.clearText()
            txtCurrentPassword.displayInlineError(errorString: InputErrorCaptions.invalidPassword)
            return
        }
        
        if !InputFieldValidator.isValidPassword(pass: txtNewPassword.text ?? "", minLength: 6, maxLength: 20){
            txtNewPassword.clearText()
            txtNewPassword.displayInlineError(errorString: InputErrorCaptions.invalidPassword)
            return
        }
        
        if !InputFieldValidator.isValidPassword(pass: txtConfirmPassword.text ?? "", minLength: 6, maxLength: 20){
            txtConfirmPassword.clearText()
            txtConfirmPassword.displayInlineError(errorString: InputErrorCaptions.invalidPassword)
            return
        }
        
        if txtNewPassword.text ?? " " != txtConfirmPassword.text ?? "" {
            txtNewPassword.clearText()
            txtConfirmPassword.clearText()
            txtConfirmPassword.displayInlineError(errorString: InputErrorCaptions.passwordNotMatched)
            txtNewPassword.displayInlineError(errorString: InputErrorCaptions.passwordNotMatched)
            return
        }
        
        guard let email = SessionManager.getUserSesion()?.email else {
            NSLog("User email is empty")
            displayErrorMessage(message: "Could not update user!", completion: nil)
            return
        }
        
        displayProgress()
        firebaseOP.updateUserPassword(email: email, newPassword: txtNewPassword.text!, existingPassword: txtCurrentPassword.text!)
    }
}

extension UpdatePasswordViewController: FirebaseActions {
    func onConnectionLost() {
        dismissProgress()
        displayWarningMessage(message: "Please check internet connection", completion: nil)
    }
    func onPasswordChanged() {
        dismissProgress()
        displaySuccessMessage(message: "Password updated successfully!", completion: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    func onPasswordChangeFailedWithError(error: String) {
        dismissProgress()
        displayErrorMessage(message: error, completion: nil)
    }
}
