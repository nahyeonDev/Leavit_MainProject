//
//  HomeContentTableView2.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/26.
//

import UIKit

class HomeContentTableView2: UITableViewCell {
    
    func configure(with models: [Model2]){
            self.models = models
            collectionView.reloadData()
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    var models = [Model2]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        // Initialization code
    }
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HomeCollectionViewCell2", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell2") //xib파일 등록
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeContentTableView2: UICollectionViewDelegate, UICollectionViewDataSource {
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count //model의 수 만큼 cell개수 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell2", for: indexPath) as! HomeCollectionViewCell2
        cell.configure(with: models[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize { //cell의 크기 설정
//        let width = collectionView.frame.width
//        let height = collectionView.frame.height
        let size = CGSize(width: 202, height:210)
        return size
    }
    
}
