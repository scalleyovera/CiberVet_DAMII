//
//  RegistroViewController.swift
//  CiberVet
//
//  Created by Cristina Belen Molle Rodriguez on 26/04/25.
//

import UIKit
import FSCalendar

class RegistroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    

    @IBAction func volverTapped(_ sender: UIButton) {
        //Regresar a la pantalla anterior
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

     @IBAction func volverTapped(_ sender: UIButton) {
     }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
