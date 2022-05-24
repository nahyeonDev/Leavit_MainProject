//
//  OfferRemitPay.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/15.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class OfferRemitPay: UIViewController {

    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var timeTitle1: UILabel!
    @IBOutlet weak var timeTitle2: UILabel!
    @IBOutlet weak var workTitle: UILabel!
    
    
    var isCheck = false
    var ref : DatabaseReference!
    
    let email = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        okBtn.isHidden = true
        
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainT = "offer" + email1
        ref = Database.database().reference().child("송금리스트").child(mainT)
        ref.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                
                for 송금리스트 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = 송금리스트.value as? [String: AnyObject]
                    let obName = itemObjects?["구직자이름"] as? String ?? ""
                    let obTime1 = itemObjects?["근무시간1"] as? String ?? ""
                    let obTime2 = itemObjects?["근무시간2"] as? Int ?? 0
                    let obWork = itemObjects?["업직종"] as? String ?? ""
                    
                    self.nameTitle.text = obName
                    self.timeTitle1.text = obTime1
                    
                    let t = String(obTime2)
                    let timeText = t + "시간"
                    self.timeTitle2.text = timeText
                    
                    self.workTitle.text = obWork
                    
                }
              }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        backBtn.addTarget(self, action: #selector(backBtn(_:)), for:.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        okBtn.addTarget(self, action: #selector(goNext(_:)), for:.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: okBtn)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func isCheckBtn(_ sender: UIButton) {
        if(isCheck == false){
            checkBtn.setImage(UIImage(named: "pCheck.png"), for: .normal)
            okBtn.isHidden = false
            isCheck = true
        }else{
            checkBtn.setImage(UIImage(named: "pUnCheck.png"), for: .normal)
            okBtn.isHidden = true
            isCheck = false
        }
    }

    @IBAction func goNext(_ sender: UIButton) {
        guard let contVC2 = self.storyboard?.instantiateViewController(withIdentifier: "MyPagePayment") else { return }
        self.navigationController?.pushViewController(contVC2, animated: true)
    }
    
}
