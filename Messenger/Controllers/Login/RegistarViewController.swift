//
//  RegistarViewController.swift
//  Messenger
//
//  Created by Chris Kelly on 19/12/20.
//

import UIKit

class RegistarViewController: UIViewController {
    
    
    // Define the scroll view
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        
        return scrollView
    }()
    
    // Make the Image for ref view
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person") // System image "person" gives a person siloute
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
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
    
    // First name
    private let firstNameFeild: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name"
        
        // Make the text not dispaly on the left edge
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    }()
    
    private let lastNameFeild: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name"
        
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
    private let regButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registar"
        view.backgroundColor = .green
        
        // Nav Bar Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Registrer", style: .done, target: self, action: #selector(didTapRegister))
        
        
        // Log in Button selector (Make the Button Work)
        regButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // Auto Login when hitting return in the password field
        emailFeild.delegate = self
        passwordFeild.delegate = self
        
        // Add Sub-Views
        view.addSubview(scrollView)
        
        // Add the views into the scroll view
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameFeild)
        scrollView.addSubview(lastNameFeild)
        scrollView.addSubview(emailFeild)
        scrollView.addSubview(passwordFeild)
        scrollView.addSubview(regButton)
        
        // Allow user to interact with image to change
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        // Change the Profile Pic
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Make the scroll view full screen
        scrollView.frame = view.bounds
        
        // Use the size of the scrollView
        let size = scrollView.width/3
        
        // Display the items
        imageView.frame = CGRect(x: (scrollView.width-size)/2 , y: 20, width: size, height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        firstNameFeild.frame = CGRect(x: 30 , y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
        lastNameFeild.frame = CGRect(x: 30 , y: firstNameFeild.bottom + 10, width: scrollView.width - 60, height: 52)
        emailFeild.frame = CGRect(x: 30 , y: lastNameFeild.bottom + 10, width: scrollView.width - 60, height: 52)
        passwordFeild.frame = CGRect(x: 30 , y: emailFeild.bottom + 10, width: scrollView.width - 60, height: 52)
        regButton.frame = CGRect(x: 30 , y: passwordFeild.bottom + 10, width: scrollView.width - 60, height: 52)
    }
    
    @objc private func loginButtonTapped() {
        
        // Close the Keyboard
        emailFeild.resignFirstResponder()
        passwordFeild.resignFirstResponder()
        
        guard let firstname = firstNameFeild.text,
              let lastname = lastNameFeild.text,
              let email = emailFeild.text,
              let password = passwordFeild.text,
              !email.isEmpty,
              !password.isEmpty,
              !firstname.isEmpty,
              !lastname.isEmpty,
              password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        // Firebase Log In
        
    }
    // Alert for when the user hits the Login Button and has the wrong info
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter all infomation to create a new account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegistarViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RegistarViewController: UITextFieldDelegate {
    
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


extension RegistarViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Displays an option popup asking the user what way they would like to add a photo
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo ", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        // Get the image from info dict
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage]as? UIImage else{
            return
        }
        // ImgView defined at top
        self.imageView.image = selectedImage
    }
    
    // Close the picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

