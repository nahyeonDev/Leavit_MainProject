//
//  MyPageMain.swift
//  MainProject
//
//  Created by 김나현 on 2022/01/28.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MyPageMain: UIViewController {
    @IBOutlet weak var content1: UIView! //구직뷰
    @IBOutlet weak var content2: UIView! //구인뷰
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var mainMenu: UIButton! //메인메뉴
    
    @IBOutlet weak var nameTitle: UILabel!
    let db = Firestore.firestore()
    let uEmail = Auth.auth().currentUser!.email
    
    //스크랩버튼
    @IBOutlet weak var scrapBtn: UIButton!
    //리뷰버튼
    @IBOutlet weak var reviewBtn: UIButton!
    
    //SearchBtn
    @IBOutlet weak var resumeBtn_Search: UIButton! //이력서 작성 버튼
    @IBOutlet weak var jobSearchListBtn: UIButton!
    @IBOutlet weak var recommendationSearchBtn: UIButton!
    @IBOutlet weak var employContractSearchBtn: UIButton!
    
    //OfferBtn
    @IBOutlet weak var jobOfferInfo: UIButton! //구인정보 버튼
    @IBOutlet weak var jobOfferListBtn: UIButton!
    @IBOutlet weak var recommendationOfferBtn: UIButton!
    @IBOutlet weak var employContractOfferBtn: UIButton!
    
    var click = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yourBackImage = UIImage(named: "custom_backbtn")
        self.navigationController?.navigationBar.tintColor = .black//.blue as you required
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.topItem?.title = ""

        content2?.isHidden = true
        content1?.isHidden = false
        
        //뒤의 판들 코너 둥글게
        mainview?.layer.cornerRadius = 10
        mainview?.layer.masksToBounds = true
        
        //MyPage_MainMenu_Btn
        scrapBtn?.addTarget(self, action: #selector(tapScrapBtn), for: .touchUpInside)
        reviewBtn?.addTarget(self, action: #selector(tapReviewBtn), for: .touchUpInside)
        
        //SearchBtn
        resumeBtn_Search?.addTarget(self, action: #selector(tapResumeSearchBtn), for: .touchUpInside)
        jobSearchListBtn?.addTarget(self, action: #selector(tapSearchListBtn), for: .touchUpInside)
        recommendationSearchBtn?.addTarget(self, action: #selector(tapRecommendationSearchBtn), for: .touchUpInside)
        employContractSearchBtn?.addTarget(self, action: #selector(tapEmployContractSearchBtn), for: .touchUpInside)
        //OfferBtn
        jobOfferInfo?.addTarget(self, action: #selector(tapJobOfferInfoBtn), for: .touchUpInside)
        jobOfferListBtn?.addTarget(self, action: #selector(tapJobOfferListBtn), for: .touchUpInside)
        recommendationOfferBtn?.addTarget(self, action: #selector(tapRecommendationOfferBtn), for: .touchUpInside)
        employContractOfferBtn?.addTarget(self, action: #selector(tapEmployContractOfferBtn), for: .touchUpInside)
    }
    
    //MyPage_MainMenu_Btn
    @objc func tapScrapBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "ScrapVC") {
             self.navigationController?.pushViewController(controller, animated: true)
             print("Go to Scrap screen!")
        }
    }
    @objc func tapReviewBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "ReviewVC") {
             self.navigationController?.pushViewController(controller, animated: true)
             print("Go to Review screen!")
        }
    }
    
    //SearchMenu
    @objc func tapResumeSearchBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "ResumeSearch") {
             self.navigationController?.pushViewController(controller, animated: true)
             //self.view.addSubview(controller.view)
             print("Go to Resume screen!")
        }
    }
    @objc func tapSearchListBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "JobSearchList") {
             self.navigationController?.pushViewController(controller, animated: true)
             //self.view.addSubview(controller.view)
             print("Go to Resume screen!")
        }
    }
    @objc func tapRecommendationSearchBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "Recommendation_Search") {
             self.navigationController?.pushViewController(controller, animated: true)
             //self.view.addSubview(controller.view)
             print("Go to Resume screen!")
        }
    }
    @objc func tapEmployContractSearchBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "EmployContract_Search") {
             self.navigationController?.pushViewController(controller, animated: true)
             //self.view.addSubview(controller.view)
             print("Go to Resume screen!")
        }
    }
    
    //OfferMenu
    @objc func tapJobOfferInfoBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "JobOfferInfo") {
             self.navigationController?.pushViewController(controller, animated: true)
             //self.view.addSubview(controller.view)
             print("Go to JobOfferInfo screen!")
        }
    }
    @objc func tapJobOfferListBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "JobOfferList") {
             self.navigationController?.pushViewController(controller, animated: true)
             //self.view.addSubview(controller.view)
             print("Go to JobOfferInfo screen!")
        }
    }
    @objc func tapRecommendationOfferBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "Recommendation_Offer") {
             self.navigationController?.pushViewController(controller, animated: true)
             //self.view.addSubview(controller.view)
             print("Go to JobOfferInfo screen!")
        }
    }
    @objc func tapEmployContractOfferBtn(){
        if let controller = self.storyboard?.instantiateViewController(identifier: "EmployContract_Offer") {
             self.navigationController?.pushViewController(controller, animated: true)
             //self.view.addSubview(controller.view)
             print("Go to JobOfferInfo screen!")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserNameSetting()
    }
    
    //구인 클릭
    @IBAction func clickBtn2(_ sender: Any) {
        if(click == false){
            UIView.animate(withDuration: 0.5, animations: {
                self.mainMenu.transform = CGAffineTransform(translationX: 155, y: 0)
            })
            mainMenu.setImage(UIImage(named: "mselectBtn2.png"), for: .normal)
            content1.isHidden = true
            content2.isHidden = false
            click = true
        }
    }
    @IBAction func clickBtn1(_ sender: Any) {
        if(click == true){
            UIView.animate(withDuration: 0.5, animations: {
                self.mainMenu.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            mainMenu.setImage(UIImage(named: "mselectBtn1.png"), for: .normal)
            content1.isHidden = false
            content2.isHidden = true
            click = false
        }
    }
    //현재 사용자 이름 세팅
    func UserNameSetting(){
        let docRef = db.collection("가입개인정보").document(uEmail!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"]
                self.nameTitle?.text = (obName as! String)
 
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
