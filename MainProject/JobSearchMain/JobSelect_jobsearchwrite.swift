//
//  JobSelect_jobsearchwrite.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/16.
//

import UIKit

class JobSelect_jobselectwrite: UIViewController {
    
    @IBOutlet weak var topView_s: UIView!
    //뒤로가기 버튼
    @IBOutlet weak var backBtn: UIButton!
    
    //프랜차이즈,일반가게 선택
    @IBOutlet weak var selectBtn1: UIButton!
    @IBOutlet weak var selectBtn2: UIButton!
    
    //가능 업무
    @IBOutlet weak var cafe: UIButton!
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var sale: UIButton!
    @IBOutlet weak var service: UIButton!
    @IBOutlet weak var write: UIButton!
    @IBOutlet weak var it: UIButton!
    @IBOutlet weak var culture: UIButton!
    @IBOutlet weak var design: UIButton!
    @IBOutlet weak var edu: UIButton!
    
    @IBOutlet weak var finBtn: UIButton! //완료 버튼
    
    
    var num: [Int] = [0,0,0,0,0,0,0,0,0]
    
    //메인 화면으로 직종 정보 넘길 때 사용
    var jCategory: Array<String> = ["","","","","","","","",""] //직종 종류
    var jSelect: String?//프랜차이즈, 일반 가게 여부
    var jCJobs: String = ""
    var jobs: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jSelect = "프랜차이즈"
        finBtn.isEnabled = false
        
    }
    
    @IBAction func clickSelectBtn1(_ sender: UIButton) {
        selectBtn1.setImage(UIImage(named: "sRadioCheck.png"), for: .normal)
        selectBtn2.setImage(UIImage(named: "ellipse117.png"), for: .normal)
        //버튼 다 원래대로 세팅
        cafe.setImage(UIImage(named: "cafe.png"), for: .normal)
        food.setImage(UIImage(named: "food.png"), for: .normal)
        sale.setImage(UIImage(named: "sale.png"), for: .normal)
        service.setImage(UIImage(named: "service.png"), for: .normal)
        write.setImage(UIImage(named: "write.png"), for: .normal)
        it.setImage(UIImage(named: "internet.png"), for: .normal)
        culture.setImage(UIImage(named: "culture.png"), for: .normal)
        design.setImage(UIImage(named: "design.png"), for: .normal)
        edu.setImage(UIImage(named: "study.png"), for: .normal)
        
        //위의 카운터 세팅을 다 0으로
        for index in 0..<num.count {
            num[index] = 0
        }
        
        jSelect = "프랜차이즈"
    }
    
    @IBAction func clickSelectBtn2(_ sender: UIButton) {
        selectBtn1.setImage(UIImage(named: "ellipse117.png"), for: .normal)
        selectBtn2.setImage(UIImage(named: "sRadioCheck.png"), for: .normal)
        
        //버튼 다 원래대로 세팅
        cafe.setImage(UIImage(named: "cafe.png"), for: .normal)
        food.setImage(UIImage(named: "food.png"), for: .normal)
        sale.setImage(UIImage(named: "sale.png"), for: .normal)
        service.setImage(UIImage(named: "service.png"), for: .normal)
        write.setImage(UIImage(named: "write.png"), for: .normal)
        it.setImage(UIImage(named: "internet.png"), for: .normal)
        culture.setImage(UIImage(named: "culture.png"), for: .normal)
        design.setImage(UIImage(named: "design.png"), for: .normal)
        edu.setImage(UIImage(named: "study.png"), for: .normal)
        
        //위의 카운터 세팅을 다 0으로
        for index in 0..<num.count {
            num[index] = 0
        }
        
        jSelect = "일반 가게"
    }
    
    //카페 버튼
    @IBAction func clickCafe(_ sender: UIButton) {
        if(num[0] == 0){
            cafe.setImage(UIImage(named: "fillCafe2.png"), for: .normal)
            num[0] += 1
            
            jCategory[0] = "카페"
            finBtn.isEnabled = true
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
            
        }
        else if(num[0] == 1){
            cafe.setImage(UIImage(named: "cafe.png"), for: .normal)
            num[0] -= 1
            
            jCategory[0] = ""
            finBtn.isEnabled = false
            finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
    }
    //음식점 버튼
    @IBAction func clickFood(_ sender: UIButton) {
        if(num[1] == 0){
            food.setImage(UIImage(named: "fillFood2.png"), for: .normal)
            num[1] += 1
            
            jCategory[1] = "음식점"
            finBtn.isEnabled = true
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
        }
        else if(num[1] == 1){
            food.setImage(UIImage(named: "food.png"), for: .normal)
            num[1] -= 1
            
            jCategory[1] = ""
            finBtn.isEnabled = false
            finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
    }
    //유통/판매 버튼
    @IBAction func clickSale(_ sender: UIButton) {
        if(num[2] == 0){
            sale.setImage(UIImage(named: "fillSale2.png"), for: .normal)
            num[2] += 1
            
            jCategory[2] = "유통/판매"
            finBtn.isEnabled = true
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
        }
        else if(num[2] == 1){
            sale.setImage(UIImage(named: "sale.png"), for: .normal)
            num[2] -= 1
            jCategory[2] = ""
            finBtn.isEnabled = false
            finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
    }
    //서비스 버튼
    @IBAction func clickService(_ sender: UIButton) {
        if(num[3] == 0){
            service.setImage(UIImage(named: "fillService2.png"), for: .normal)
            num[3] += 1
            
            jCategory[3] = "서비스"
            finBtn.isEnabled = true
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
        }
        else if(num[3] == 1){
            service.setImage(UIImage(named: "service.png"), for: .normal)
            num[3] -= 1
            
            jCategory[3] = ""
            finBtn.isEnabled = false
            finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
    }
    //사무회계 버튼
    @IBAction func clickWrite(_ sender: UIButton) {
        if(num[4] == 0){
            write.setImage(UIImage(named: "fillWrite2.png"), for: .normal)
            num[4] += 1
            
            jCategory[4] = "사무/회계"
            finBtn.isEnabled = true
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
        }
        else if(num[4] == 1){
            write.setImage(UIImage(named: "write.png"), for: .normal)
            num[4] -= 1
            
            jCategory[4] = ""
            finBtn.isEnabled = false
            finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
    }
    //It인터넷 버튼
    @IBAction func clickIt(_ sender: UIButton) {
        if(num[5] == 0){
            it.setImage(UIImage(named: "fillInternet2.png"), for: .normal)
            num[5] += 1
            
            jCategory[5] = "IT/인터넷"
            finBtn.isEnabled = true
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
        }
        else if(num[5] == 1){
            it.setImage(UIImage(named: "internet.png"), for: .normal)
            num[5] -= 1
            
            jCategory[5] = ""
            finBtn.isEnabled = false
            finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
    }
    //문화여가 버튼
    @IBAction func clickCulture(_ sender: UIButton) {
        if(num[6] == 0){
            culture.setImage(UIImage(named: "fillCulture2.png"), for: .normal)
            num[6] += 1
            
            jCategory[6] = "문화/여가"
            finBtn.isEnabled = true
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
        }
        else if(num[6] == 1){
            culture.setImage(UIImage(named: "culture.png"), for: .normal)
            num[6] -= 1
            
            jCategory[6] = ""
            finBtn.isEnabled = false
            finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
    }
    //디자인 버튼
    @IBAction func clickDesign(_ sender: UIButton) {
        if(num[7] == 0){
            design.setImage(UIImage(named: "fillDesign2.png"), for: .normal)
            num[7] += 1
            
            jCategory[7] = "디자인"
            finBtn.isEnabled = true
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
        }
        else if(num[7] == 1){
            design.setImage(UIImage(named: "design.png"), for: .normal)
            num[7] -= 1
            
            jCategory[7] = ""
            finBtn.isEnabled = false
            finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
    }
    //교육
    @IBAction func clickStudy(_ sender: UIButton) {
        if(num[8] == 0){
            edu.setImage(UIImage(named: "fillStudy2.png"), for: .normal)
            num[8] += 1
            
            jCategory[8] = "교육"
            finBtn.isEnabled = true
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
        }
        else if(num[8] == 1){
            edu.setImage(UIImage(named: "study.png"), for: .normal)
            num[8] -= 1
            
            jCategory[8] = ""
            finBtn.isEnabled = false
            finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        let preVC = self.presentingViewController
        guard let vc = preVC as? JobSearchWrite else {
            return
        }
        for num in 0...8{
            if(jCategory[num].count > 1){
                jCJobs += jCategory[num]
                jCJobs += ","
            }
        }
        jobs = "[" + jSelect! + "]" + jCJobs
        
        vc.selectJob = jobs!
        
        //이전화면으로
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func gotoBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
