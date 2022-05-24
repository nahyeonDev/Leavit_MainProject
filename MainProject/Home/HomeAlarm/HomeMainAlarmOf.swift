//
//  HomeMainAlarmOf.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/14.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeMainAlarmOf: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var wTitle: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    var itemOffer : DatabaseReference!
    var ref : DatabaseReference!
    
    let email = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
    
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainT = "Offer" + email1
        
        itemOffer = Database.database().reference().child("Support글지원").child(email1).child(mainT)
        
        itemOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                
                for Support글지원 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = Support글지원.value as? [String: AnyObject]
                    
                    let obTitle = itemObjects?["글제목"] as! String
                    let obName = itemObjects?["지원자이름"] as! String
                    
                    self.wTitle.text = obTitle
                    self.nameTitle.text = obName
                }
            }
            
        })
        
        backBtn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        okBtn.addTarget(self, action: #selector(okView), for: .touchUpInside)

    }
    @objc func okView(){
            let email1 = email!.components(separatedBy: ["@", "."]).joined()
            ref = Database.database().reference().child("MainIng").child("offer").child(email1).child("post")
            ref.updateChildValues(["알람완료": "yes"])
            dismiss(animated: false, completion: nil)
    }

    
    @objc func dismissView(){
            dismiss(animated: false, completion: nil)
    }
}
