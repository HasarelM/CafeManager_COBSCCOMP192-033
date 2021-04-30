//
//  ForgotPasswordViewController.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-28.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var txtEmail: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firebaseOP.delegate = self
    }

    
    @IBAction func onBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onResetPasswordPressed(_ sender: UIButton) {
        if !InputFieldValidator.isValidEmail(txtEmail.text ?? "") {
            txtEmail.clearText()
            txtEmail.displayInlineError(errorString: InputErrorCaptions.invalidEmailAddress)
            return
        }
        
        if !networkMonitor.isReachable {
            self.displayErrorMessage(message: FieldErrorCaptions.noConnectionTitle, completion: nil)
            return
        }
        
        displayProgress()
        self.firebaseOP.sendResetPasswordRequest(email: txtEmail.text ?? "")
    }
}

extension ForgotPasswordViewController : FirebaseActions {
    func onConnectionLost() {
        dismissProgress()
        displayWarningMessage(message: "Please check internet connection", completion: nil)
    }
    
    func onResetPasswordEmailSent() {
        dismissProgress()
        displaySuccessMessage(message: "Email sent, please check inbox!", completion: nil)
    }
    
    func onResetPasswordEmailSentFailed(error: String) {
        dismissProgress()
        displayErrorMessage(message: error, completion: nil)
    }
}
