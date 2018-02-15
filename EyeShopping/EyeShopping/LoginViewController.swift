//
//  LoginViewController.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 12.02.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailDividerView: LoginDivider!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordDividerView: LoginDivider!
    @IBOutlet weak var emailValidationImage: UIImageView!
    @IBOutlet weak var passwordValidationImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChangeEmailAction(_ sender: Any) {
        validateEmail()
    }
    @IBAction func onChangePasswordAction(_ sender: Any) {
        validatePassword()
    }
    
    private func validateEmail() {
        if (emailTextField.text?.validateEmail())! {
            let defaultColor = UIColor(red: 130/255, green: 150/255, blue: 163/255, alpha: 1)
            emailDividerView.backgroundColor = defaultColor
            emailValidationImage.image = UIImage(named:"valid_field")
        }
        else {
            let redColor = UIColor(red: 253/255, green: 100/255, blue: 85/255, alpha: 1)
            emailDividerView.backgroundColor = redColor
            emailValidationImage.image = UIImage(named:"invalid_field")
        }
    }
    
    private func validatePassword() {
        if (passwordTextField.text?.validatePassword())! {
            let defaultColor = UIColor(red: 130/255, green: 150/255, blue: 163/255, alpha: 1)
            passwordDividerView.backgroundColor = defaultColor
            passwordValidationImage.image = UIImage(named:"valid_field")
        }
        else {
            let redColor = UIColor(red: 253/255, green: 100/255, blue: 85/255, alpha: 1)
            passwordDividerView.backgroundColor = redColor
            passwordValidationImage.image = UIImage(named:"invalid_field")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
