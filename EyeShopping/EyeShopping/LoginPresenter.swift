//
//  LoginPresenter.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 16.02.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation

class LoginPresenter {
    
    fileprivate var view: LoginView?
    
    func attachView(view: LoginView?) {
        self.view = view
    }
    
    func validateEmail(email: String) {
        if (email.validateEmail()) {
            view?.showSuccessValidation(isEmail: true)
            return
        }
        
        view?.showErrorValidation(isEmail: true)
    }
    
    func validatePassword(password: String) {
        if (password.validatePassword()) {
            view?.showSuccessValidation(isEmail: false)
            return
        }
        
        view?.showErrorValidation(isEmail: false)
    }
}
