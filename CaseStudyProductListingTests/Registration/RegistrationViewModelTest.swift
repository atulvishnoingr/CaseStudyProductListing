//
//  RegistrationViewModelTest.swift
//  CaseStudyProductListingTests
//
//  Created by Atul Vishnoi on 17/07/23.
//

import XCTest
import CaseStudyProductListing

final class RegistrationViewModelTest: XCTestCase {
    var viewModel: RegistrationViewModelProtocol!

    override func setUp() {
        super.setUp()
        viewModel = RegistrationViewModel()
    }

    func testIsEmailValidWhenIsEmpty() {
        let isEmailValid = viewModel.isEmailValid(value: "")
        XCTAssertEqual(isEmailValid, false)
        XCTAssertEqual(viewModel.errorMessage.value, "Email is empty")
    }

    func testIsEmailValidWhenIsInvalid() {
        let isEmailValid = viewModel.isEmailValid(value: "test@")
        XCTAssertEqual(isEmailValid, false)
        XCTAssertEqual(viewModel.errorMessage.value, "Please enter a valid email address")
    }

    func testIsEmailValidWhenIsValid() {
        let isEmailValid = viewModel.isEmailValid(value: "test@valid.com")
        XCTAssertEqual(isEmailValid, true)
        XCTAssertEqual(viewModel.errorMessage.value, nil)
    }

    func testIsNameValidWhenIsEmpty() {
        let isNameValid = viewModel.isNameValid(value: "")
        XCTAssertEqual(isNameValid, false)
        XCTAssertEqual(viewModel.errorMessage.value, "Name should be at least 3 letters length")
    }

    func testIsNameValidWhenIsLessThan3CharacterLength() {
        let isNameValid = viewModel.isNameValid(value: "te")
        XCTAssertEqual(isNameValid, false)
        XCTAssertEqual(viewModel.errorMessage.value, "Name should be at least 3 letters length")
    }

    func testIsNameValidWhenIsGreaterThan3CharacterLength() {
        let isNameValid = viewModel.isNameValid(value: "test")
        XCTAssertEqual(isNameValid, true)
        XCTAssertEqual(viewModel.errorMessage.value, nil)
    }

    func testIsPasswordValidWhenEmpty() {
        let isPasswordValid = viewModel.isPasswordValid(value: "")
        XCTAssertEqual(isPasswordValid, false)
        XCTAssertEqual(viewModel.errorMessage.value, "Password is empty")
    }

    func testIsPasswordValidWhenInvalid() {
        let isPasswordValid = viewModel.isPasswordValid(value: "Test12342")
        XCTAssertEqual(isPasswordValid, false)
        XCTAssertEqual(
            viewModel.errorMessage.value,
            "Password must have at least 8 characters with at least 1 number, 1 uppercase & 1 special character"
        )
    }

    func testIsPasswordValidWhenValid() {
        let isPasswordValid = viewModel.isPasswordValid(value: "Test@12342")
        XCTAssertEqual(isPasswordValid, true)
        XCTAssertEqual(viewModel.errorMessage.value, nil)
    }
}
