//
//  ReAlaCell.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/08.
//

import UIKit

class ReAlaCell: UITableViewCell {

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var cBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}

