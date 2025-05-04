//
//  RegisterPetViewController.swift
//  CiberVet
//
//  Created by user279229 on 5/3/25.
//

import UIKit

class RegisterPetViewController: UIViewController {

  
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    
    
    @IBOutlet weak var inscriptionDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func registerTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            let alertError = UIAlertController(title: "Ups!", message: "Por favor complete todos los campos.", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            present(alertError, animated: true)
            return
        }
        
        let genderIndex = genderSegmentControl.selectedSegmentIndex
        let date = inscriptionDatePicker.date
        
        let actionSuccess = UIAlertController(
            title: "¡Felicidades!",
            message: "\(name) ha sido registrado exitosamente.",
            preferredStyle: .alert
        )
        
        actionSuccess.addAction(UIAlertAction(title: "Aceptar", style: .default) { _ in
            self.dismiss(animated: true)
        })
        
        present(actionSuccess, animated: true)
    }

    
}
