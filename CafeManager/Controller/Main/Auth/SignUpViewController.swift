//
//  SignUpViewController.swift
//  CafeManager
//
//  Created by Hasarel Madola on 2021-04-28.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var txtUserName: CustomTextField!
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var txtPhone: CustomTextField!
    @IBOutlet weak var txtPassword: CustomTextField!
    @IBOutlet weak var txtConfirmPass: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firebaseOP.delegate = self
    }
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onSignUpPressed(_ sender: UIButton) {
        if !InputFieldValidator.isValidName(txtUserName.text ?? "") {
            txtUserName.clearText()
            txtUserName.displayInlineError(errorString: InputErrorCaptions.invalidName)
            return
        }
        
        if !InputFieldValidator.isValidEmail(txtEmail.text ?? "") {
            txtEmail.clearText()
            txtEmail.displayInlineError(errorString: InputErrorCaptions.invalidEmailAddress)
            return
        }
        
        if !InputFieldValidator.isValidMobileNo(txtPhone.text ?? "") {
            txtPhone.clearText()
            txtPhone.displayInlineError(errorString: InputErrorCaptions.invalidPhoneNo)
            return
        }
        
        if !InputFieldValidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 20){
            txtPassword.clearText()
            txtPassword.displayInlineError(errorString: InputErrorCaptions.invalidPassword)
            return
        }
        
        if !InputFieldValidator.isValidPassword(pass: txtConfirmPass.text ?? "", minLength: 6, maxLength: 20){
            txtConfirmPass.clearText()
            txtConfirmPass.displayInlineError(errorString: InputErrorCaptions.invalidPassword)
            return
        }
        
        if txtPassword.text ?? " " != txtConfirmPass.text ?? "" {
            txtPassword.clearText()
            txtConfirmPass.clearText()
            txtConfirmPass.displayInlineError(errorString: InputErrorCaptions.passwordNotMatched)
            txtPassword.displayInlineError(errorString: InputErrorCaptions.passwordNotMatched)
            return
        }
        
        if !networkMonitor.isReachable {
            self.displayErrorMessage(message: FieldErrorCaptions.noConnectionTitle, completion: nil)
            return
        }
        
        displayProgress()
        self.firebaseOP.registerUser(user: User(_id: "",
                                                userName: txtUserName.text!,
                                                email: txtEmail.text!,
                                                phoneNo: txtPhone.text!,
                                                password: txtPassword.text!, imageRes: ""))
    }
}

extension SignUpViewController : FirebaseActions {
    func onConnectionLost() {
        dismissProgress()
        displayWarningMessage(message: "Please check internet connection", completion: nil)
    }
    func isSignUpSuccessful(user: User?) {
        dismissProgress()
        if let user = user {
            displaySuccessMessage(message: "Regisration Successful!", completion: {
                SessionManager.saveUserSession(user)
                self.performSegue(withIdentifier: StoryBoardSegues.signUpHome, sender: nil)
            })
        } else {
            displayErrorMessage(message: FieldErrorCaptions.generalizedError, completion: nil)
        }
    }
    func isSignUpFailedWithError(error: Error) {
        dismissProgress()
        displayErrorMessage(message: error.localizedDescription, completion: nil)
    }
    func isSignUpFailedWithError(error: String) {
        dismissProgress()
        displayErrorMessage(message: error, completion: nil)
    }
    func isExisitingUser(error: String) {
        dismissProgress()
        displayErrorMessage(message: error, completion: nil)
    }
}
