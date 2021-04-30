//
//  SignInViewController.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-28.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var txtPassword: CustomTextField!
    @IBOutlet weak var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtEmail.accessibilityIdentifier = "txtEmail"
        self.txtPassword.accessibilityIdentifier = "txtPassword"
        self.btnSignIn.accessibilityIdentifier = "btnSignIn"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firebaseOP.delegate = self
    }

    @IBAction func onSignInPressed(_ sender: UIButton) {
        if !InputFieldValidator.isValidEmail(txtEmail.text ?? "") {
            txtEmail.clearText()
            txtEmail.displayInlineError(errorString: InputErrorCaptions.invalidEmailAddress)
            return
        }
        
        if !InputFieldValidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 20){
            txtPassword.clearText()
            txtPassword.displayInlineError(errorString: InputErrorCaptions.invalidPassword)
            return
        }
        
        displayProgress()
        self.firebaseOP.signInUser(email: txtEmail.text ?? "", password: txtPassword.text ?? "")
    }
    
}

extension SignInViewController : FirebaseActions {
    func onConnectionLost() {
        dismissProgress()
        displayWarningMessage(message: "Please check internet connection", completion: nil)
    }
    func onUserNotRegistered(error: String) {
        dismissProgress()
        displayErrorMessage(message: error, completion: nil)
    }
    func onUserSignInSuccess(user: User?) {
        dismissProgress()
        if let user = user {
            self.dismiss(animated: true, completion: nil)
            SessionManager.saveUserSession(user)
            self.performSegue(withIdentifier: StoryBoardSegues.signInToHome, sender: nil)
        } else {
            displayErrorMessage(message: FieldErrorCaptions.generalizedError, completion: nil)
        }
    }
    func onUserSignInFailedWithError(error: Error) {
        dismissProgress()
        displayErrorMessage(message: error.localizedDescription, completion: nil)
    }
    func onUserSignInFailedWithError(error: String) {
        dismissProgress()
        displayErrorMessage(message: error, completion: nil)
    }
}
