//
//  HopeWorkView.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/15.
//

import UIKit
import FirebaseFirestore

class HopeWorkView: UIViewController {
    
    //각 업무 버튼
    @IBOutlet weak var cafeBtn: UIButton! //카페
    @IBOutlet weak var foodBtn: UIButton! //음식
    @IBOutlet weak var saleBtn: UIButton!  //유통,판매
    @IBOutlet weak var serviceBtn: UIButton!  //서비스
    @IBOutlet weak var acBtn: UIButton!  //사무,회계
    @IBOutlet weak var itBtn: UIButton! //it,인터넷
    @IBOutlet weak var leisureBtn: UIButton! //문화,여가
    @IBOutlet weak var designBtn: UIButton! //디자인
    @IBOutlet weak var eduBtn: UIButton! //교육
    @IBOutlet weak var etcBtn: UIButton! //기타
    
    @IBOutlet weak var touchPopup: UIButton! //건너뛰기 버튼
    
    var num: [Int] = [0,0,0,0,0,0,0,0,0,0]
    var name: [String] = ["","","","","","","","","",""]
    var checkN : String = ""
    
    @IBOutlet weak var goNextBtn: UIButton!
    
    let db = Firestore.firestore()
    var keyNumber2 : String? //사용자 키 값 받아오기
    var cusKeyNum2 : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //팝업창
        touchPopup.addTarget(self, action: #selector(goAlert), for: .touchUpInside)
        
        goNextBtn.isEnabled = false
        
        self.cusKeyNum2 = keyNumber2
    }
    
    @objc func goAlert(){
        let alert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlter") as! CustomPopUp
        alert.modalPresentationStyle = .overCurrentContext
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goNext(_ sender: UIButton) {
        for nm in 0...9{
            if(name[nm].count > 1){
                checkN += name[nm]
                checkN += ", "
                
            }
        }
        db.collection("가입세부정보").document(cusKeyNum2!).setData(["희망 업무" : checkN, "경험 업무" : 0, "키워드" : 0, "프로필사진": 0])
        // navigation controller 로 화면 전환
          guard let expVC = self.storyboard?.instantiateViewController(withIdentifier: "expWorkController")as? ExpWorkView else { return }
        expVC.keyNumber3 = self.cusKeyNum2!
          self.navigationController?.pushViewController(expVC, animated: true)
    }
    //카페 버튼
    @IBAction func clickCafe(_ sender: UIButton) {
        if(num[0] == 0){
            cafeBtn.setImage(UIImage(named: "jfCafe.png"), for: .normal)
            num[0] += 1
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = true
            name[0] = "카페"
        }
        else if(num[0] == 1){
            cafeBtn.setImage(UIImage(named: "jlCafe.png"), for: .normal)
            num[0] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[0] = ""
        }
    }
    //음식점 버튼
    @IBAction func clickFood(_ sender: UIButton) {
        if(num[1] == 0){
            foodBtn.setImage(UIImage(named: "jfFood.png"), for: .normal)
            num[1] += 1
            goNextBtn.isEnabled = true
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            name[1] = "음식점"
        }
        else if(num[1] == 1){
            foodBtn.setImage(UIImage(named: "jlfood.png"), for: .normal)
            num[1] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[1] = ""
        }
    }
    //유통,판매 버튼
    @IBAction func clickSale(_ sender: UIButton) {
        if(num[2] == 0){
            saleBtn.setImage(UIImage(named: "jfSale.png"), for: .normal)
            num[2] += 1
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = true
            name[2] = "유통/판매"
        }
        else if(num[2] == 1){
            saleBtn.setImage(UIImage(named: "jlSale.png"), for: .normal)
            num[2] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[2] = ""
        }
    }
    //서비스 버튼
    @IBAction func clickService(_ sender: UIButton) {
        if(num[3] == 0){
            serviceBtn.setImage(UIImage(named: "jfService.png"), for: .normal)
            num[3] += 1
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = true
            name[3] = "서비스"
        }
        else if(num[3] == 1){
            serviceBtn.setImage(UIImage(named: "jlService.png"), for: .normal)
            num[3] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[3] = ""
        }
    }
    //사무,회계 버튼
    @IBAction func clickAc(_ sender: UIButton) {
        if(num[4] == 0){
            acBtn.setImage(UIImage(named: "jfAc.png"), for: .normal)
            num[4] += 1
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = true
            name[4] = "사무/회계"
        }
        else if(num[4] == 1){
            acBtn.setImage(UIImage(named: "jlAc.png"), for: .normal)
            num[4] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[4] = ""
        }
    }
    //It,인터넷 버튼
    @IBAction func clickIt(_ sender: UIButton) {
        if(num[5] == 0){
            itBtn.setImage(UIImage(named: "jfIt.png"), for: .normal)
            num[5] += 1
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = true
            name[5] = "IT/인터넷"
        }
        else if(num[5] == 1){
            itBtn.setImage(UIImage(named: "jlIt.png"), for: .normal)
            num[5] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[5] = ""
        }
    }
    //문화,여가 버튼
    @IBAction func clickLeisure(_ sender: UIButton) {
        if(num[6] == 0){
            leisureBtn.setImage(UIImage(named: "jfLei.png"), for: .normal)
            num[6] += 1
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = true
            name[6] = "문화/여가"
        }
        else if(num[6] == 1){
            leisureBtn.setImage(UIImage(named: "jlLei.png"), for: .normal)
            num[6] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[6] = ""
        }
    }
    //디자인 버튼
    @IBAction func clickDesign(_ sender: UIButton) {
        if(num[7] == 0){
            designBtn.setImage(UIImage(named: "jfDesign.png"), for: .normal)
            num[7] += 1
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = true
            name[7] = "디자인"
        }
        else if(num[7] == 1){
            designBtn.setImage(UIImage(named: "jlDesign.png"), for: .normal)
            num[7] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[7] = ""
        }
    }
    //교육 버튼
    @IBAction func clickEdu(_ sender: UIButton) {
        if(num[8] == 0){
            eduBtn.setImage(UIImage(named: "jfEdu.png"), for: .normal)
            num[8] += 1
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = true
            name[8] = "교육"
        }
        else if(num[8] == 1){
            eduBtn.setImage(UIImage(named: "jlEdu.png"), for: .normal)
            num[8] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[8] = ""
        }
    }
    //기타 버튼
    @IBAction func clickEtc(_ sender: UIButton) {
        if(num[9] == 0){
            etcBtn.setImage(UIImage(named: "jfEtc.png"), for: .normal)
            num[9] += 1
            goNextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = true
            name[9] = "기타"
        }
        else if(num[9] == 1){
            etcBtn.setImage(UIImage(named: "jlEtc.png"), for: .normal)
            num[9] -= 1
            goNextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
            goNextBtn.isEnabled = false
            name[9] = ""
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
