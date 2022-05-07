//
//  HomeOfferDetail3.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/25.
//

import UIKit

class HomeOfferDetail3: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        models.append(Model(imageName: "hcu.png", title: "CU 태릉입구점", price: "시급 8,720원"))
                models.append(Model(imageName: "hwork1.png", title: "가구 옮기기 ", price: "일급 10,000원"))
                models.append(Model(imageName: "hcu.png", title: "학원 일일강사", price: "시급 8,720원"))
                models.append(Model(imageName: "hwork1.png", title: "가구 옮기기 ", price: "일급 10,000원"))
                models.append(Model(imageName: "hwork1.png", title: "학원 일일강사", price: "시급 8,720원"))
                models.append(Model(imageName: "hwork1.png", title: "가구 옮기기 ", price: "일급 10,000원"))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeContentTableView1", bundle: nil), forCellReuseIdentifier: "HomeContentTableView1")
        tableView.separatorStyle = .none //cell 구분선 없애기
    }
}

//MARK: - 테이블 뷰 구성
extension HomeOfferDetail3: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //cell의 갯수 설정
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //cell의 데이터 구성
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeContentTableView1", for: indexPath) as! HomeContentTableView1
//        cell.ProductTitle.text = "이 상품 어때요?"
        cell.configure(with: models)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //cell의 높이 설정
        return 141
    }
}
