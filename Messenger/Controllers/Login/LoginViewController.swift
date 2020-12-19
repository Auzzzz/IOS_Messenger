//
//  LoginViewController.swift
//  Messenger
//
//  Created by Chris Kelly on 19/12/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Define the scroll view
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        
        return scrollView
    }()
    
    // Make the Image for ref view
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // Make the Email feild for reg view
    private let emailFeild: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address"
        
        // Make the text not dispaly on the left edge
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    }()
    
    // Make the Password feild for reg view
    private let passwordFeild: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password ...."
        field.isSecureTextEntry = true
        
        // Make the text not dispaly on the left edge
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    }()
    
    // Login Button
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = .yellow
        
        // Nav Bar Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Registrer",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        
        // Log in Button selector (Make the Button Work)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // Auto Login when hitting return in the password field
        emailFeild.delegate = self
        passwordFeild.delegate = self
        
        
        
        // Add Sub-Views
        view.addSubview(scrollView)
        
        // Add the views into the scroll view
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailFeild)
        scrollView.addSubview(passwordFeild)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Make the scroll view full screen
        scrollView.frame = view.bounds
        
        // Use the size of the scrollView
        let size = scrollView.width/3
        
        // Display the items
        imageView.frame = CGRect(x: (scrollView.width-size)/2 , y: 20, width: size, height: size)
        emailFeild.frame = CGRect(x: 30 , y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
        passwordFeild.frame = CGRect(x: 30 , y: emailFeild.bottom + 10, width: scrollView.width - 60, height: 52)
        loginButton.frame = CGRect(x: 30 , y: passwordFeild.bottom + 10, width: scrollView.width - 60, height: 52)
    }
    
    @objc private func loginButtonTapped() {
        // Close the Keyboard
        emailFeild.resignFirstResponder()
        passwordFeild.resignFirstResponder()
        
        guard let email = emailFeild.text, let password = passwordFeild.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else{
            alertUserLoginError()
            return
        }
        
        // Firebase Log In
        
    }
    // Alert for when the user hits the Login Button and has the wrong info
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter all infomation to login", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegistarViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    // Move between the email and password feilds with return and submit in password
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailFeild{
            passwordFeild.becomeFirstResponder()
        }
        else if textField == passwordFeild {
            loginButtonTapped()
        }
        return true
    }
    
}
