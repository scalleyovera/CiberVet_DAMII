//
//  HomeViewController.swift
//  CiberVet
//
//  Created by Cristina Belen Molle Rodriguez on 26/04/25.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    
    @IBOutlet weak var tablaMascotas: UITableView!
    
    var mascotas: [MascotaCD] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaMascotas.dataSource = self
        tablaMascotas.delegate = self
        cargarMascotas()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func vovlerTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func agregarMascotaTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Mascota", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Nombre de tú mascota"
            
        }

        alert.addTextField { textField in
                textField.placeholder = "Peso"
                textField.keyboardType = .decimalPad
        }
        
        alert.addAction(UIAlertAction(title: "Agregar", style: .default) { _ in
            guard let nombre = alert.textFields?[0].text, !nombre.isEmpty,
                  let pesoTexto = alert.textFields?[1].text, !pesoTexto.isEmpty,
                  let peso = Double(pesoTexto) else { return }
            
                  let nuevaMascota = MascotaCD(context: self.context)
            
            nuevaMascota.nombre = nombre
            nuevaMascota.peso = peso
            
            do {
                try self.context.save()
                self.cargarMascotas()
            } catch {
                print("Error...")
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
        
    }
    
    func cargarMascotas() {
        let request: NSFetchRequest<MascotaCD> = MascotaCD.fetchRequest()
        do {
            mascotas = try context.fetch(request)
            tablaMascotas.reloadData()
        } catch {
            print("Error")
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ 16: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mascotas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda mascota", for: indexPath)
        let mascota = mascotas[indexPath.row]
        
        return cell
    }
}
