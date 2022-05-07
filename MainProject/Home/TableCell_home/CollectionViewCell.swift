//
//  CollectionViewCell.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/30.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    //title
    @IBOutlet weak var titleLabel: UILabel!
    //시간
    @IBOutlet weak var tLabel: UILabel!
    //급여
    @IBOutlet weak var mLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
