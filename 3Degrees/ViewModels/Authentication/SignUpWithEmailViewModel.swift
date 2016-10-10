//
//  SignUpWithEmailViewModel.swift
//  3Degrees
//
//  Created by Gigster Developer on 4/27/16.
//  Copyright © 2016 Gigster. All rights reserved.
//

import Foundation
import Bond
import LKAlertController
import Rswift
import ThreeDegreesClient

protocol SignUpWithEmailViewDelegate {
    func signUp()
}

extension SignUpWithEmailViewModel: SignUpWithEmailViewDelegate {
    func signUp() {
        guard canSignUp else {
            showFormErrorAlert()
            return
        }
        let privateUser = PrivateUser()
        privateUser.firstName = firstName?.trimmed
        privateUser.lastName = lastName?.trimmed
        privateUser.isSingle = false
        privateUser.emailAddress = email?.trimmed
        privateUser.password = password
        privateUser.dob = birthday?.birthdayNSDate
        privateUser.gender = gender
        apiController.signUp(privateUser) {() in
            let segueId = R.segue
                           .signUpWithEmailViewController
                           .toModeSelection.identifier
            self.router?.showAction(identifier: segueId)
        }
    }

    private func showFormErrorAlert() {
        Alert(
            title: nil,
            message: R.string.localizable.checkInputDataAlertMessage()
        ).showOkay()
    }
}

struct SignUpWithEmailViewModel: ViewModelProtocol {

    var router: RoutingProtocol?
    var apiController: AuthApiProtocol
    let genderPickerDelegate: UIPickerViewDelegate
    let genderPickerDataSource: UIPickerViewDataSource
    let genderObservableValue: Observable<String?>

    var firstName: String? = ""
    var lastName: String? = ""
    var email: String? = ""
    var password: String? = ""
    var confirmPassword: String? = ""
    var birthday: String? = ""
    var gender: PrivateUser.Gender? = nil

    init(router: RoutingProtocol) {
        self.router = router
        self.apiController = AuthApiController()
        self.genderObservableValue = Observable(gender?.rawValue)
        self.genderPickerDelegate = GenderPickerDelegate(observableValue: self.genderObservableValue)
        self.genderPickerDataSource = GenderPickerDataSource()
    }

    var canSignUp: Bool {
        let passwordValid = !(password ?? "").isEmpty && password == confirmPassword
        return passwordValid &&
            !(email ?? "").isEmpty &&
            !(firstName ?? "").isEmpty &&
            !(lastName ?? "").isEmpty &&
            !(birthday ?? "").isEmpty &&
            !(gender?.rawValue ?? "").isEmpty
    }

    func backButtonPressed() {
        router?.popAction()
    }
}
