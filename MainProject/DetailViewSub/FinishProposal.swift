//
//  FinishProposal.swift
//  MainProject
//
//  Created by 김나현 on 2021/12/14.
//

import UIKit

class FinishProposal: UIViewController {

    @IBOutlet weak var topMainView: UIView!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var locTitle: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    
    var name: String?
    var loc: String?
    var time: String?
    
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
        self.dismiss(animated: true, completion: nil)
    }
    
    //디폴트로 배치되는 뒤로가기 버튼 삭제
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
        if let na = name {
            self.nameTitle.text = na
        }
        if let lo = loc {
            self.locTitle.text = lo
        }
        if let ti = time{
            self.timeTitle.text = ti
        }
    }
}
