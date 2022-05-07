//
//  ResearchChatting.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/22.
//

import UIKit

class ResearchChatting: UITableViewCell {

    @IBOutlet weak var mnlabel: UILabel!
    @IBOutlet weak var mMessageView: UIView!
    @IBOutlet weak var tlabel: UILabel!
    
    
    @IBOutlet weak var mnlabel2: UILabel!
    @IBOutlet weak var mMessageView2: UIView!
    @IBOutlet weak var tlabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
