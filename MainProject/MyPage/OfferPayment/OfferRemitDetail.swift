//
//  OfferRemitDetail.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/15.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

class OfferRemitDetail: UIViewController {

    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var dayTitle: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var workTitle: UILabel!
    @IBOutlet weak var moneyTitle: UILabel!
    @IBOutlet weak var finRemitTitle: UILabel!
    
    var ref : DatabaseReference!
    let db = Firestore.firestore()
    
    let email = Auth.auth().currentUser?.email
    
    var remittance = 0
    var youEmail = ""
    
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainT = "offer" + email1
        ref = Database.database().reference().child("송금리스트").child(mainT)
        ref.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                
                for 송금리스트 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = 송금리스트.value as? [String: AnyObject]
                    let obName = itemObjects?["구직자이름"] as? String ?? ""
                    let obDay = itemObjects?["근무날짜"] as? String ?? ""
                    let obTime1 = itemObjects?["근무시간1"] as? String ?? ""
                    let obTime2 = itemObjects?["근무시간2"] as? Int ?? 0
                    let obWork = itemObjects?["업직종"] as? String ?? ""
                    let obMon = itemObjects?["시급"] as? String ?? ""
                    let obEmail = itemObjects?["구직자이메일"] as? String ?? ""
                    
                    self.nameTitle.text = obName
                    self.dayTitle.text = obDay
                    let t = String(obTime2)
                    let timeText = obTime1 + " 총 " + t + "시간"
                    self.timeTitle.text = timeText
                    
                    self.workTitle.text = obWork
                    self.moneyTitle.text = obMon
                    
                    let money = obMon.components(separatedBy: ["원"]).joined()
                    let finMon = (Int(money) ?? 0) * obTime2
                    self.remittance = finMon
                    
                    self.finRemitTitle.text = String(finMon) + "원"
                    self.youEmail = obEmail
                    
                }
              }
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        backBtn.addTarget(self, action: #selector(backBtn(_:)), for:.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func payOkBtn(_ sender: UIButton) {
        let docRef = db.collection("결제시스템").document(email!)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obMoney = dataDescription?["money"] as? Int ?? 0
                
                let mon = obMoney - self.remittance
                
                docRef.updateData(["money" : mon])
                
                let docRef2 = self.db.collection("결제시스템").document(self.youEmail)
                docRef2.setData(["money" : self.remittance])
                
            } else {
                print("Document does not exist")
            }
        }
        
        guard let contVC2 = self.storyboard?.instantiateViewController(withIdentifier: "OfferRemitFin") else { return }
        self.navigationController?.pushViewController(contVC2, animated: true)
    }
        
}


