
//
//  SaludViewController.swift
//  CiberVet
//
//  Created by user279229 on 5/3/25.
//

import UIKit

class SaludViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var message = "Notificación enviada al veterinario. La estará revisando enseguida."
        var title = "¡Felicidades!"

        if ApiConfig.countTouches > 0 {
            message = "Ya se ha enviado una notificación."
            title = "¡Tranquilo/a!"
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))

        self.present(alert, animated: true)

        ApiConfig.countTouches += 1
    }
}
