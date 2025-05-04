//
//  ActividadTableViewCell.swift
//  CiberVet
//
//  Created by user279229 on 5/4/25.
//

import UIKit

class ActividadTableViewCell: UITableViewCell {

    
    @IBOutlet weak var horaLabel: UILabel!
    
    @IBOutlet weak var lugarLabel: UILabel!
    
    @IBOutlet weak var actividadLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
