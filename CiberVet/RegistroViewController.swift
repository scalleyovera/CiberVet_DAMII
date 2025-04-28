//
//  RegistroViewController.swift
//  CiberVet
//
//

import UIKit
import FSCalendar

class RegistroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func volverTapped(_ sender: UIButton) {
        //Regresar a la pantalla anterior
        navigationController?.popViewController(animated: true)
    }
    
}
