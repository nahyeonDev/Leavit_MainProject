//
//  JobOfferLoadView.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/14.
//

import UIKit

class JobOfferLoadView: UIViewController {

    var check = false
    @IBOutlet weak var cBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func okBtn(_ sender: UIButton) {
        if(check == false){
            
        }
        else{
            let preVC = self.presentingViewController
            
            guard let vc = preVC as? JobOfferWrite else {
                return
            }
            
            vc.txtMyTitle.text = "스타벅스 태릉입구역 DT점"
            vc.selectJobTxt.text = "[프랜차이즈]카페,캐셔,매장관리"
            vc.locationTxt.text = "서울/노원구/공릉동653-8"
            vc.locUrlTxt.text = "https://m.place.naver.com/restaurant/1221245848/photo"
            vc.wantTxt.text = "20대(대학생)"
            vc.howWork.text = "수 ,18:00~22:00,[시급],10000원"
            vc.tagTxt.text = "카페/커피,스타벅스,캐셔"
            vc.detailTxt.text = "스타벅스 5월 18일 하루 알바 구합니다. 급여는 당일에 지급하겠습니다!"
            
            self.presentingViewController?.dismiss(animated: true)
        }
    }
    
    @IBAction func checkMenu(_ sender: UIButton) {
        if(check == false){
            cBtn.image("wrsuCheckOk.png")
            check = true
        }else{
            cBtn.image("wrsuCheck.png")
            check = false
        }
    }

}
