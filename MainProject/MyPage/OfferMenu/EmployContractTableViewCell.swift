//
//  EmployContractTableViewCell.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/03.
//

import UIKit

class EmployContractTableViewCell: UITableViewCell {

    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var offerNameTitle: UILabel!
    @IBOutlet weak var offerPhone: UILabel!
    @IBOutlet weak var resNameTitle: UILabel!
    @IBOutlet weak var resPhone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
