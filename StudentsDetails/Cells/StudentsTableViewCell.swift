//
//  StudentsTableViewCell.swift
//  StudentsDetails
//
//  Created by admin on 21/05/21.
//

import UIKit

class StudentsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    
    var callBackForEdit: (() -> ())?
    var callBackForDelete: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        callBackForEdit?()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        callBackForDelete?()
    }
    
}
