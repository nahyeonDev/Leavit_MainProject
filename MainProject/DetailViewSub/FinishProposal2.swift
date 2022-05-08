//
//  FinishProposal2.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/04.
//

import UIKit

class FinishProposal2: UIViewController {
    
    @IBOutlet weak var topMainView: UIView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var money: UILabel!
    
    var money2: String?
    var loc2: String?
    var time2: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //상단 뷰
        topMainView.layer.shadowColor = UIColor.black.cgColor // 색깔
        topMainView.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        topMainView.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        topMainView.layer.shadowRadius = 2 // 반경
        topMainView.layer.shadowOpacity = 0.1 // alpha값
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //디폴트로 배치되는 뒤로가기 버튼 삭제
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
        if let loc = loc2 {
            self.location.text = loc
        }
        if let money = money2{
            self.money.text = money
        }
        if let time = time2{
            self.time.text = time
        }
    }
    
    @IBAction func okFinBtn(_ sender: UIButton) {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        for viewController in viewControllerStack {
          if let bView = viewController as? DetailViewController {
            self.navigationController?.popToViewController(bView, animated: true)
            }
        }
    }

}
