//
//  QuestionTableViewCell.swift
//  CiberVet
//
//  Created by user279229 on 5/4/25.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var questionText: UITextView!
    
    @IBOutlet weak var answerText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
