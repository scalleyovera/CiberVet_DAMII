//  TipsViewController.swift
//  CiberVet
//
//  Created by user279229 on 5/3/25.
//

import UIKit

struct Question {
    let question: String
    let answer: String
}

class TipsViewController: UIViewController {

    @IBOutlet weak var tipsTable: UITableView!
    
    
    @IBOutlet weak var newQuestionTextField: UITextField!
    
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipsTable.dataSource = self
        loadQuestions()
    }

    func loadQuestions() {
        let urlString = "\(PetAPI.url)/listarPreguntas"
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
                   let dataArray = json["data"] as? [[String: Any]] {
                    
                    self.questions = dataArray.compactMap { item in
                        guard let questionText = item["question"] as? String,
                              let answerText = item["answer"] as? String else {
                            print("Error al parsear item: \(item)")
                            return nil
                        }
                        return Question(question: questionText, answer: answerText)
                    }
                    
                    DispatchQueue.main.async {
                        self.tipsTable.reloadData()
                        if self.questions.isEmpty {
                            print("No se encontró data")
                        }
                    }
                }
            } catch {
                print("Error al procesar JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    
    
    @IBAction func sendQuestionTapped(_ sender: UIButton) {
        guard let question = newQuestionTextField.text, !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            let alertError = UIAlertController(title: "Ups!", message: "Al parecer no enviaste ninguna pregunta", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            present(alertError, animated: true)
            return
        }

        let alertSuccess = UIAlertController(
            title: "¡Gracias!",
            message: "Tu pregunta: \"\(question)\" ha sido registrada exitosamente. La revisaremos pronto.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Aceptar", style: .default) { _ in
            self.newQuestionTextField.text = ""
        }
        
        alertSuccess.addAction(okAction)
        present(alertSuccess, animated: true)
    }


    
    
}

extension TipsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipCell", for: indexPath) as! QuestionTableViewCell
        
        let question = questions[indexPath.row]
        cell.questionText.text = question.question
        cell.answerText.text = question.answer
        
        return cell
    }
}
