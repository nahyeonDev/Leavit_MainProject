//
//  HomeContentTableView1.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/25.
//

import UIKit

class HomeContentTableView1: UITableViewCell {
    
    func configure(with models: [Model]){
            self.models = models
            collectionView.reloadData()
    }
    
    @IBOutlet weak var MajorTitle: UILabel! //학과
    @IBOutlet weak var collectionView: UICollectionView!
    
    var models = [Model]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        // Initialization code
    }
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HomeCollectionViewCell1", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell1") //xib파일 등록
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeContentTableView1: UICollectionViewDelegate, UICollectionViewDataSource {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell1", for: indexPath) as! HomeCollectionViewCell1
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize { //cell의 크기 설정
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let size = CGSize(width: width, height: height)
        return size
        //return CGSize(width: 150, height: 160)
    }
    
}
