//
//  item1TableViewCell.swift
//  MainProject
//
//  Created by 김나현 on 2021/12/07.
//

import UIKit

class item1TableViewCell: UITableViewCell {

    //프로필 사진
    @IBOutlet weak var profileImg: UIImageView!
    //위치
    @IBOutlet weak var locationTxt: UILabel!
    //이름
    @IBOutlet weak var nameTxt: UILabel!
    //성별, 나이
    @IBOutlet weak var genderTxt: UILabel!
    //태그
    @IBOutlet weak var tagTxt1: UILabel!
    @IBOutlet weak var tagTxt2: UILabel!
    @IBOutlet weak var tagTxt3: UILabel!
    
    @IBOutlet weak var user: UILabel!
    //수행 건수
    @IBOutlet weak var pNumTxt: UILabel!
    //별
    @IBOutlet weak var star: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
