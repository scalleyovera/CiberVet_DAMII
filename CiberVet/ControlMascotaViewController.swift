import UIKit
import FSCalendar

struct Actividad {
    let hora: String
    let lugar: String
    let actividad: String
}

class ControlMascotaViewController: UIViewController {

    @IBOutlet weak var tablaActividades: UITableView!
    @IBOutlet weak var nonActivitiesLabel: UILabel!
    @IBOutlet weak var calendar: FSCalendar!

    var activitys: [Actividad] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        tablaActividades.dataSource = self

        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        let todayFormatted = formatter.string(from: Date())

    
        getActivitiesFromApi(formattedDate: todayFormatted)
    }

    func getActivitiesFromApi(formattedDate: String) {
        print("FECHA RECIBIDA \(formattedDate) para el API")
        let urlString = "\(PetAPI.url)/listarCitasByFecha?fecha=\(formattedDate)"
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
                   let activitiesData = json["data"] as? [[String: Any]] {
                    self.activitys = activitiesData.compactMap { activity in
                        guard let hora = activity["hora"] as? String,
                              let lugar = activity["lugar"] as? String,
                              let actividad = activity["actividad"] as? String else {
                            print("Error al parsear actividad")
                            return nil
                        }
                        return Actividad(hora: hora, lugar: lugar, actividad: actividad)
                    }

                    DispatchQueue.main.async {
                        self.tablaActividades.reloadData()
                        self.nonActivitiesLabel.isHidden = !self.activitys.isEmpty
                    }
                }
            } catch {
                print("Error al procesar JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

// MARK: - FSCalendar

extension ControlMascotaViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        let formattedDate = formatter.string(from: date)
        print("Fecha seleccionada: \(formattedDate)")
        getActivitiesFromApi(formattedDate: formattedDate)
    }
}

// MARK: - UITableViewDataSource

extension ControlMascotaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actividadCell", for: indexPath) as! ActividadTableViewCell

        let actividad = activitys[indexPath.row]
        cell.horaLabel.text = "\(actividad.hora)"
        cell.lugarLabel.text = "Lugar: \(actividad.lugar)"
        cell.actividadLabel.text = "Actividad: \(actividad.actividad)"

        return cell
    }
}
