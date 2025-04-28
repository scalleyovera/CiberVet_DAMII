//
//  ControlMascotaViewController.swift
//  CiberVet
//
//  Created by user279229 on 4/28/25.
//

import UIKit
import FSCalendar

class ControlMascotaViewController: UIViewController {

    
    
    @IBOutlet weak var calendar: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
    }
    
    

}
extension ControlMascotaViewController : FSCalendarDataSource {
    
}

extension ControlMascotaViewController : FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = ISO8601DateFormatter()
        let selectedDate = date
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("\(formattedDate)")
    }
}
    



