//
//  MyPageMainRe.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/16.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MyPageMainRe: UIViewController {
    
    @IBOutlet weak var nameTitle: UILabel!
    //SearchBtn
    @IBOutlet weak var resumeBtn_Search: UIButton! //이력서 작성 버튼
    @IBOutlet weak var jobSearchListBtn: UIButton!
    @IBOutlet weak var recommendationSearchBtn: UIButton!
    @IBOutlet weak var employContractSearchBtn: UIButton!

    @IBOutlet weak var moneyTitle: UILabel!
    let db = Firestore.firestore()
    let uEmail = Auth.auth().currentUser!.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //SearchBtn
        resumeBtn_Search?.addTarget(self, action: #selector(tapResumeSearchBtn), for: .touchUpInside)
        jobSearchListBtn?.addTarget(self, action: #selector(tapSearchListBtn), for: .touchUpInside)
        recommendationSearchBtn?.addTarget(self, action: #selector(tapRecommendationSearchBtn), for: .touchUpInside)
        employContractSearchBtn?.addTarget(self, action: #selector(tapEmployContractSearchBtn), for: .touchUpInside)
        
        let docRef = self.db.collection("결제시스템").document(self.uEmail!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obMoney = dataDescription?["money"] as? Int ?? 0
                
                self.moneyTitle.text = String(obMoney) + "원"
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserNameSetting()
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
