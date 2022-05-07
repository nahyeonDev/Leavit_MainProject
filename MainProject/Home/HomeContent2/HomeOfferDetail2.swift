//
//  HomeOfferDetail2.swift
//  MainProject
//
//  Created by 김나현 on 2022/01/17.
//

import UIKit

class HomeOfferDetail2: UIViewController{
    
    @IBOutlet weak var tableView2: UITableView!
    
    var models = [Model2]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        models.append(Model2(imageName: "hwork3.png", title: "자바책 대리구매", price: "시급 8,720원"))
                models.append(Model2(imageName: "hwork3.png", title: "올리브영 대타 ", price: "일급 10,000원"))
                models.append(Model2(imageName: "hwork3.png", title: "학원 일일강사", price: "시급 8,720원"))
                models.append(Model2(imageName: "hwork3.png", title: "가구 옮기기 ", price: "일급 10,000원"))
        
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.register(UINib(nibName: "HomeContentTableView2", bundle: nil), forCellReuseIdentifier: "HomeContentTableView2")
        tableView2.separatorStyle = .none //cell 구분선 없애기
    }


}

extension HomeOfferDetail2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //cell의 갯수 설정
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //cell의 데이터 구성
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeContentTableView2", for: indexPath) as! HomeContentTableView2
//        cell.ProductTitle.text = "이 상품 어때요?"
        cell.configure(with: models)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //cell의 높이 설정
        return 214
    }
}
