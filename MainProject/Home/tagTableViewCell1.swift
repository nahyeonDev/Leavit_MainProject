//
//  tagTableViewCell1.swift
//  MainProject
//
//  Created by 김나현 on 2021/12/09.
//

import UIKit

class tagTableViewCell1: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10, right: 0.0))
    }

}
