//
//  HomeOfferMain.swift
//  MainProject
//
//  Created by 김나현 on 2022/01/17.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeOfferMain: UIViewController {
    
    @IBOutlet weak var AllView: UIView! //전체 뷰
    @IBOutlet weak var startView2: UIImageView!
    
    
    @IBOutlet weak var backColor: UIImageView!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var reviewBtn: UIButton!
    
    @IBOutlet weak var circle1: UIImageView!
    @IBOutlet weak var circle2: UIImageView!
    @IBOutlet weak var circle3: UIImageView!
    @IBOutlet weak var circle4: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var lineImg: UIImageView!
    @IBOutlet weak var mainName: UILabel!
    
    var ref: DatabaseReference!
    var mainOffer: DatabaseReference!
    var subOffer: DatabaseReference!
    
    let myEmail = Auth.auth().currentUser!.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AllView.isHidden = true
        startView2.isHidden = false
        
        AllView.layer.cornerRadius = 5
        AllView.layer.shadowColor = UIColor.black.cgColor
        AllView.layer.shadowOffset = CGSize(width: 5, height: 5)
        AllView.layer.shadowRadius = 5
        AllView.layer.shadowOpacity = 0.1
        
        reviewBtn.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let mEmail = myEmail!.components(separatedBy: ["@", "."]).joined()
        mainOffer = Database.database().reference().child("MainIng").child("offer")
            .child(mEmail)
        
        mainOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                for MainIng in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = MainIng.value as? [String: AnyObject]
                    
                    let oksign = itemObjects?["접수완료"] as! String
                    let yemail = itemObjects?["지원자이메일"] as! String
                    let yname = itemObjects?["지원자이름"] as! String
                    
                    self.mainName.text = yname
                    
                    if(oksign == "yes"){
                        print("ok")
                        self.AllView.isHidden = false
                        self.startView2.isHidden = true
                        self.AllView.transform = CGAffineTransform(translationX: 0, y: -151)
                        
                    }
                    else{
                        self.AllView.isHidden = true
                        self.startView2.isHidden = false
                        self.AllView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                    
                    let email1 = yemail.components(separatedBy: ["@", "."]).joined()
                    self.subOffer = Database.database().reference().child("MainIng").child("search").child(email1)
                    self.subOffer.observe(DataEventType.value, with:{(snapshot) in
                        if snapshot.childrenCount>0{
                            for MainIng in snapshot.children.allObjects as![DataSnapshot]{
                                let itemObjects = MainIng.value as? [String: AnyObject]
                                let oksign2 = itemObjects?["접수완료클릭"] as! String
                                let okgo = itemObjects?["근무지출발"] as! String
                                let okarr = itemObjects?["근무지도착"] as! String
                                let okFin = itemObjects?["퇴근"] as! String
                                if(oksign2 == "yes"){
                                    self.circle1.image("hokRed.png")
                                    self.circle2.image("hingRed.png")
                                    
                                    self.chatBtn.transform = CGAffineTransform(translationX: 0, y: +39)
                                    self.backColor.transform = CGAffineTransform(translationX: 0, y: +39)
                                    self.circle2.transform = CGAffineTransform(translationX: 0, y: -40)
                                    self.label1.transform = CGAffineTransform(translationX: 0, y: -40)
                                }
                                if(okgo == "yes"){
                                    self.circle2.image("hokRed.png")
                                    self.circle3.image("hingRed.png")
                                    
                                    self.chatBtn.transform = CGAffineTransform(translationX: 0, y: +78)
                                    self.backColor.transform = CGAffineTransform(translationX: 0, y: +78)
                                    self.circle3.transform = CGAffineTransform(translationX: 0, y: -40)
                                    self.label2.transform = CGAffineTransform(translationX: 0, y: -40)
                                }
                                
                                if(okarr == "yes"){
                                    self.circle3.image("hokRed.png")
                                    self.circle4.image("hingRed.png")
                                    self.chatBtn.transform = CGAffineTransform(translationX: 0, y: +117)
                                    self.backColor.transform = CGAffineTransform(translationX: 0, y: +117)
                                    self.circle4.transform = CGAffineTransform(translationX: 0, y: -40)
                                    self.label3.transform = CGAffineTransform(translationX: 0, y: -40)
                                    self.lineImg.image("hlineRed2.png")
                                    self.lineImg.frame.size.height = 109
                                }
                                if(okFin == "yes"){
                                    self.circle4.image("hokRed.png")
                                    self.reviewBtn.isHidden = false
                                }
                            }
                        }
                    })
                }
            }
            
        })
        
    }


}
