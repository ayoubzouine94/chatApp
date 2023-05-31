//
//  ViewController.swift
//  ChaApp
//
//  Created by Tami Zouine on 30/5/2023.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLogged = UserDefaults.standard.bool(forKey: "logged_in")
        if !isLogged {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav,animated: true)
            
        }
    }

}

