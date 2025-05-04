//
//  TestLoginViewController.swift
//  CiberVet
//
//  Created by user279229 on 5/4/25.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class TestLoginViewController: UIViewController {

    
    @IBOutlet weak var userTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = userTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if let _ = error {
                print("user : \(email), password : \(password)")
                let alert = UIAlertController(title: "Error", message: "No se pudo registrar el usuario", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                print("Error : \(error?.localizedDescription)")
                self.present(alert, animated: true)
            } else {
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                    sceneDelegate.window?.rootViewController = tabBarVC
                }
            } }    }
    

}
