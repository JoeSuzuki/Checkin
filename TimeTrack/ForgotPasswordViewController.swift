//
//  ForgotPasswordViewController.swift
//  Firebase-boilerplate
//
//  Created by Mariano Montori on 7/25/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    // hides keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hides keyboard when pressing return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        return(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func resetPasswordClicked(_ sender: UIButton) {
        guard let email = emailTextField.text,
            !email.isEmpty else {
            return
        }
        AuthService.passwordReset(email: email)
    }
}

extension ForgotPasswordViewController{
    func configureView(){
//        applyKeyboardPush()
//        applyKeyboardDismisser()
        self.view.backgroundColor = UIColor(red: 71/255, green: 186/255, blue: 251/255, alpha: 1)

    }
}
