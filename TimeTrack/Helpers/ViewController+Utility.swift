//
//  ViewController+Utility.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/23/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class Keyboard {
        static var pushValue : CGFloat = 0
    }
    
    func applyKeyboardPush(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    func keyboardWillShow(notification: NSNotification) {
        view.alpha = 0.9
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
                Keyboard.pushValue = keyboardSize.height
                print(Keyboard.pushValue)
            }
        }
        self.view.backgroundColor = UIColor(red: 71/255, green: 186/255, blue: 251/255, alpha: 1)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.alpha = 1
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += Keyboard.pushValue
                print(Keyboard.pushValue)
            }
        }
        self.view.backgroundColor = UIColor(red: 71/255, green: 186/255, blue: 251/255, alpha: 1)

    }
    
    func applyKeyboardDismisser(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
}
