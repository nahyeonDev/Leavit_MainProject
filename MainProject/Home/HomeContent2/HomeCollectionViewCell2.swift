//
//  HomeCollectionViewCell2.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/26.
//

import UIKit

class HomeCollectionViewCell2: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: Model2){
         
        self.imageView.image = UIImage(named: model.imageName)
        self.titleLabel.text = model.title
        self.priceLabel.text = model.price
        
    }

}
