//
//  OfferRemitFin.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/15.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore


class OfferRemitFin: UIViewController {
    
    var ref : DatabaseReference!
    let db = Firestore.firestore()
    
    let email = Auth.auth().currentUser?.email

    @IBOutlet weak var myNameTitle: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var moneyTitle1: UILabel!
    @IBOutlet weak var moneyTitle2: UILabel!
    
    var remittance = 0
    
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
                    let obTime2 = itemObjects?["근무시간2"] as? Int ?? 0
                    let obMon = itemObjects?["시급"] as? String ?? ""
                    
                    self.nameTitle.text = obName
                    
                    let money = obMon.components(separatedBy: ["원"]).joined()
                    let finMon = (Int(money) ?? 0) * obTime2
                    self.remittance = finMon
                    
                    self.moneyTitle1.text = String(finMon) + "원"
                    
                    let docRef = self.db.collection("결제시스템").document(self.email!)
                    
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data() as [String: AnyObject]?
                            let obMoney = dataDescription?["money"] as? Int ?? 0
                            
                            let mon2 = obMoney - finMon
                            self.moneyTitle2.text = String(mon2) + "원"
                            
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                }
              }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    

    @IBAction func finishBtn(_ sender: Any) {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        for viewController in viewControllerStack {
          if let bView = viewController as? MyPageMain {
            self.navigationController?.popToViewController(bView, animated: true)
            }
        }

    }
    

}
