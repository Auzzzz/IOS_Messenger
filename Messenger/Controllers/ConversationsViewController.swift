//
//  ViewController.swift
//  Messenger
//
//  Created by Chris Kelly on 19/12/20.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        // User is not logged in
        if !isLoggedIn {
            
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            // Not allow the user to swipe down and clear the login screen
            nav.modalPresentationStyle = .fullScreen
            
            // Set to false to prevent seeing the change to login screen
            present(nav, animated: false)
        }
    }

}

