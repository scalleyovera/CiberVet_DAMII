//
//  ViewController.swift
//  CiberVet
//
//  Created by Cristina Belen Molle Rodriguez on 26/04/25.
//

import UIKit
import FirebaseAuth
import FirebaseCore


class ViewController: UIViewController {

    

    @IBOutlet weak var userTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = userTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            
            let alert = UIAlertController(title: "Ups!", message: "Email o contraseña incompletos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            present(alert, animated: true)
            return
        }

      
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let _ = error {
                let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrectos.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
                return
            }

            DispatchQueue.main.async {
                self.view.endEditing(true)
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                sceneDelegate.window?.rootViewController = tabBarVC
            }
        }
    }

    
    
    @IBAction func loginTouched(_ sender: UIButton) {
        guard let email = userTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            
            let alert = UIAlertController(title: "Ups!", message: "Email o contraseña incompletos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            present(alert, animated: true)
            return
        }

      
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let _ = error {
                let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrectos.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
                return
            }

            DispatchQueue.main.async {
                self.view.endEditing(true)
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                sceneDelegate.window?.rootViewController = tabBarVC
            }
        }    }
    
    
    
}

