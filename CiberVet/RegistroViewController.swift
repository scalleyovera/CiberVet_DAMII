//
//  RegistroViewController.swift
//  CiberVet
//
//

import UIKit
import FSCalendar
import FirebaseAuth
import FirebaseCore

class RegistroViewController: UIViewController {

    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var docNumberTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func volverTapped(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func createNewUser(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let nameOrNick = nameTextField.text, let lastName = lastNameTextField.text, let documentNumber = docNumberTextField.text, let phone = phoneTextField.text, let email = emailTextField.text else {
            let alertError = UIAlertController(title: "Ups!", message: "Todos los campos deben estar completos.", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            self.present(alertError, animated: true)
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
            }
            
        }     }
    
    
    
}
