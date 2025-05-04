//
//  SocialViewController.swift
//  CiberVet
//
//  Created by user279229 on 5/3/25.
//

import UIKit

struct MascotaSocial {
    let nombre: String
    let fechaUnion: String
    let imagen: String
}

class SocialViewController: UIViewController {


    @IBOutlet weak var allPets: UITableView!
    
    var allPetsItems: [MascotaSocial] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        allPets.dataSource = self
        allPets.delegate = self
        loadAllPetsToMeet()
    }
    
    func loadAllPetsToMeet() {
        let urlString = "\(PetAPI.url)/listarGenero"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data else {
                print("Error de red: \(error?.localizedDescription ?? "Desconocido")")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Respuesta de la API: \(jsonString)")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let petFriendsData = json["data"] as? [[String: Any]] {
                    self.allPetsItems = petFriendsData.compactMap { petItem in
                        guard let nombre = petItem["nombre"] as? String,
                              let fechaUnion = petItem["fechaUnion"] as? String,
                              let imagen = petItem["imagen"] as? String else {
                            print("Error al parsear")
                            return nil
                        }
                        return MascotaSocial(nombre: nombre, fechaUnion: fechaUnion, imagen: imagen)
                    }
                    
                    DispatchQueue.main.async {
                        self.allPets.reloadData()
                        if self.allPetsItems.isEmpty {
                            print("No se encontró data")
                        }
                    }
                }
            } catch {
                print("Error al procesar JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

// MARK: - UITableViewDataSource
extension SocialViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPetsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "petFriendCell", for: indexPath) as? PetFriendTableViewCell else {
            return UITableViewCell()
        }

        let petFriend = allPetsItems[indexPath.row]
        cell.petDetailsLabel.text = "\(petFriend.nombre) \(petFriend.fechaUnion)"
        cell.petFriendImage.image = UIImage(named: "placeholder") // Imagen temporal opcional

        if let url = URL(string: petFriend.imagen) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let currentIndexPath = tableView.indexPath(for: cell), currentIndexPath == indexPath {
                            cell.petFriendImage.image = image
                        }
                    }
                }
            }.resume()
        }

        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SocialViewController: UITableViewDelegate {
    // Puedes agregar métodos de selección de fila si los necesitas
}

// MARK: - PetFriendCellDelegate
extension SocialViewController: PetFriendCellDelegate {
    
    func didTapMeetFriend() {
        let alert = UIAlertController(
            title: "Has contactado con esta mascota.",
            message: "Hemos enviado tu solicitud de amistad a su amo.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
