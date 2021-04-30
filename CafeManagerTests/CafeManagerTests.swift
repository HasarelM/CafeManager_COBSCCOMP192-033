//
//  CafeManagerTests.swift
//  CafeManagerTests
//
//  Created by Hasarel Madola on 2021-04-27.
//

import XCTest
@testable import CafeManager

class CafeManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginValidations() throws {
        //Testing a valid email
        XCTAssertTrue(InputFieldValidator.isValidEmail("hisharadilshan3@gmail.com"))
        
        //Testing an invalid email
        XCTAssertFalse(InputFieldValidator.isValidEmail("abc@_gmail.com"))
        
        //Testing an invalid email
        XCTAssertFalse(InputFieldValidator.isValidEmail("abc@_gmail.123"))
        
        //Testing a valid password
        XCTAssertTrue(InputFieldValidator.isValidPassword(pass: "abc@123", minLength: 6, maxLength: 20))
        
        //Testing n invalid password
        XCTAssertFalse(InputFieldValidator.isValidPassword(pass: "abc", minLength: 6, maxLength: 20))
        
        //Testing an invalid password
        XCTAssertFalse(InputFieldValidator.isValidPassword(pass: "abc@1234@1234@abcdedfrefs@12345", minLength: 6, maxLength: 20))
    }
    
    func testSignUpValidations() throws {
        //Testing a valid name
        XCTAssertTrue(InputFieldValidator.isValidName("hishara"))
        
        //Testing an invalid name
        XCTAssertFalse(InputFieldValidator.isValidName("hishara123"))
        
        //Testing an invalid name
        XCTAssertFalse(InputFieldValidator.isValidName(""))
        
        //Testing a valid email
        XCTAssertTrue(InputFieldValidator.isValidEmail("hish2k15@gmail.com"))
        
        //Testing an invalid email
        XCTAssertFalse(InputFieldValidator.isValidEmail("abc@_gmail.com"))
        
        //Testing a valid mobileNo
        XCTAssertTrue(InputFieldValidator.isValidMobileNo("0711116601"))
        
        //Testing an invalid mobileNo
        XCTAssertFalse(InputFieldValidator.isValidMobileNo("0112123455"))
        
        //Testing an invalid mobileNo
        XCTAssertFalse(InputFieldValidator.isValidMobileNo("072212345"))
        
        //Testing an invalid mobileNo
        XCTAssertFalse(InputFieldValidator.isValidMobileNo("07a2212345"))
        
        //Testing a valid password
        XCTAssertTrue(InputFieldValidator.isValidPassword(pass: "abc@123", minLength: 6, maxLength: 20))
        
        //Testing n invalid password
        XCTAssertFalse(InputFieldValidator.isValidPassword(pass: "abc", minLength: 6, maxLength: 20))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class CafeManagerRegisterTests : XCTestCase, FirebaseActions {
    private var result: XCTestExpectation!
    let firebaseOP = FirebaseOP.instance
    var userRegistered = false
    
    func testRegistration() {
        firebaseOP.delegate = self
        result = expectation(description: "Successful signup!")
        let user = User(_id: "",
                        userName: "Hasarel Madola",
                        email: "hish2k15@gmail.com",
                        phoneNo: "0711116601",
                        password: "abc@123", imageRes: "")
        firebaseOP.registerUser(user: user)
        waitForExpectations(timeout: 10)
        XCTAssertEqual(self.userRegistered, true)
    }
    
    func isExisitingUser(error: String) {
        userRegistered = false
        result.fulfill()
    }
    
    func isSignUpSuccessful(user: User?) {
        userRegistered = true
        result.fulfill()
    }
    
    func isSignUpFailedWithError(error: String) {
        userRegistered = false
        result.fulfill()
    }
    
    func onConnectionLost() {
        
    }
}

class CafeManagerLoginTests : XCTestCase, FirebaseActions {
    private var result: XCTestExpectation!
    let firebaseOP = FirebaseOP.instance
    var userFound = false
    
    func testLogin() {
        firebaseOP.delegate = self
        result = expectation(description: "Successful login!")
        firebaseOP.signInUser(email: "hisharadilshan3@gmail.com", password: "idmcc3")
        waitForExpectations(timeout: 10)
        XCTAssertEqual(self.userFound, true)
    }
    
    func onUserSignInSuccess(user: User?) {
        userFound = true
        result.fulfill()
    }
    
    func onUserSignInFailedWithError(error: String) {
        userFound = false
        result.fulfill()
    }
    
    func onUserNotRegistered(error: String) {
        userFound = false
        result.fulfill()
    }
    
    func onConnectionLost() {
        
    }
}
