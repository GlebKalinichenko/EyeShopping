//
//  LoginPresenter.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 16.02.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    func onSignInClick(firstName: String, lastName: String,
                       email: String, password: String)
}

class LoginPresenter {
    
    fileprivate var view: LoginView?
    fileprivate var dataSource = LoginDataSource()
    
    func attachView(view: LoginView?) {
        self.view = view
    }
    
    func validateEmail(email: String) {
        if (email.validateEmail()) {
            view?.showSuccessValidation(type: LoginType.email)
            return
        }
        
        view?.showErrorValidation(type: LoginType.email)
    }
    
    func validatePassword(password: String) {
        if (password.notNull()) {
            view?.showSuccessValidation(type: LoginType.password)
            return
        }
        
        view?.showErrorValidation(type: LoginType.password)
    }
    
    func validateFirstName(firstName: String) {
        if (firstName.notNull()) {
            view?.showSuccessValidation(type: LoginType.password)
        }
    }
    
    func onSignInClick(firstName: String, lastName: String, email: String, password: String) {
        dataSource.login(firstName: firstName, lastName: lastName, email: email, password: password)
    }
}
