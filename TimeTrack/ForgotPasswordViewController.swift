//
//  ForgotPasswordViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/23/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        applyKeyboardPush()
        applyKeyboardDismisser()
    }
}

