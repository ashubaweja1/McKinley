//
//  UserListViewController.swift
//  Test
//
//  Created by Ashu Baweja on 20/05/20.
//  Copyright © 2019 Ashu Baweja. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtnBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: Initialization Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = kLoginScreenTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotification()
    }
    
    
    // MARK: Private Methods
    /// This method will fetch user list
    private func hitLoginApi(){
        weak var weakSelf = self
        activityIndicator.startAnimating()
        let params = ["email": idTextField.text ?? "", "password": passwordTextField.text ?? ""]
        
        LoginHandler.hitLoginApi(params: params) { (token, error) in
            DispatchQueue.main.async {
                weakSelf?.activityIndicator.stopAnimating()
                if let apiToken = token{
                    UserDefaultHelper.setToken(token: apiToken)
                    (UIApplication.shared.delegate as? AppDelegate)?.updateRootController()
                }
            }
        }
        
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if (idTextField.text?.count ?? 0) > 0 && (passwordTextField.text?.count ?? 0) > 0{
            hitLoginApi()
        }
    }
    
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var safeAreaBottomInset: CGFloat = 0.0
            if #available(iOS 11.0, *) {
                safeAreaBottomInset = self.view.safeAreaInsets.bottom
            }
            let updatedBottomConstraint = keyboardSize.height - safeAreaBottomInset + 30
            
            if loginBtnBottomConstraint.constant != updatedBottomConstraint {
                
                UIView.animate(withDuration: 0.325, animations: {
                    self.loginBtnBottomConstraint.constant = updatedBottomConstraint
                    self.view.layoutIfNeeded()
                    let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
                    self.scrollView.setContentOffset(bottomOffset, animated: true)
                })
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if self.loginBtnBottomConstraint.constant != 30 {
            UIView.animate(withDuration: 0.325, animations: {
                self.loginBtnBottomConstraint.constant = 30
                self.view.layoutIfNeeded()
            })
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




