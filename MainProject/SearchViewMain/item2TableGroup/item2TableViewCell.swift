//
//  item2TableViewCell.swift
//  MainProject
//
//  Created by 김나현 on 2021/12/07.
//

import UIKit

class item2TableViewCell: UITableViewCell {

    //업종 프로필
    @IBOutlet weak var profile: UIImageView!
    //제목
    @IBOutlet weak var title: UILabel!
    //시간
    @IBOutlet weak var time: UILabel!
    //시급,일급
    @IBOutlet weak var money: UILabel!
    //태그
    @IBOutlet weak var tagTxt1: UILabel!
    @IBOutlet weak var tagTxt2: UILabel!
    @IBOutlet weak var tagTxt3: UILabel!
    
    @IBOutlet weak var user: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
