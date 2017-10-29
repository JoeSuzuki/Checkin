//
//  ForgotPasswordViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/23/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//
import UIKit
import SCLAlertView

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
        AuthService.passwordReset(email: email, success: { (success) in
            if success {
                SCLAlertView().showSuccess("Success!", subTitle: "Email sent.")
            }
            else {
                SCLAlertView().showInfo("Opps!", subTitle: "Something is wrong, please try again!")
            }
        })
    }
}

extension ForgotPasswordViewController{
    func configureView(){
        applyKeyboardPush()
        applyKeyboardDismisser()
    }
}

