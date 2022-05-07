//
//  ContractMainView2.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/03.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ContractMainView2: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ofNameTitle: UITextField!
    @IBOutlet weak var reNameTitle: UITextField!
    
    @IBOutlet weak var nameTitle1: UILabel!
    @IBOutlet weak var locationTitle1: UILabel!
    @IBOutlet weak var phoneTitle1: UILabel!
    
    @IBOutlet weak var nameTitle2: UILabel!
    @IBOutlet weak var locationTitle2: UILabel!
    @IBOutlet weak var phoneTitle2: UILabel!
    
    @IBOutlet weak var dayTimeTitle: UILabel!
    @IBOutlet weak var detailLocTitle: UILabel!
    @IBOutlet weak var conTitle: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var moneyTitle: UITextField!
    
    @IBOutlet weak var todayTitle: UILabel!
    @IBOutlet weak var finNTitle: UILabel!
    @IBOutlet weak var finSTitle: UILabel!
    
    @IBOutlet weak var signOffer: UILabel!
    @IBOutlet weak var signTextfield: UITextField!
    
    var uEmail : String?
    let email = FirebaseAuth.Auth.auth().currentUser?.email
    var titleN : String?
    
    var contractInfo: DatabaseReference!
    
    @IBOutlet weak var bckBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ContractInfor()
        
        cmhideKeyboard2()
        
        signTextfield.delegate = self
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillHide(_:)),
                                                name: UIResponder.keyboardWillHideNotification,
                                                object: nil)
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillShow(_:)),
                                                name: UIResponder.keyboardWillShowNotification,
                                                object: nil)
    }
    //키보드 올라갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillShow(_ sender:Notification){
            self.mainView.frame.origin.y = -100
    }
    //키보드 내려갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillHide(_ sender:Notification){
        self.mainView.frame.origin.y = 0
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.mainView.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        bckBtn.addTarget(self, action: #selector(backBtn(_:)), for:.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: bckBtn)
    }
    
    func ContractInfor(){
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let email2 = uEmail!.components(separatedBy: ["@", "."]).joined()
        let mainT = "Cont" + email2 + email1
        
        contractInfo = Database.database().reference().child("Contract").child(mainT)
        contractInfo.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                
                for mainT in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = mainT.value as? [String: AnyObject]
                    let obName1 = itemObjects?["구인자이름"]
                    let obName2 = itemObjects?["구직자이름"]
                    let obLoc1 = itemObjects?["구인자주소"]
                    let obLoc2 = itemObjects?["구직자주소"]
                    let obPho1 = itemObjects?["구인자연락처"]
                    let obPho2 = itemObjects?["구직자연락처"]
                    let obConTime = itemObjects?["근로계약기간"]
                    let obLoc3 = itemObjects?["근무장소"]
                    let obCont = itemObjects?["업무내용"]
                    let obWLoc = itemObjects?["근로시간"]
                    let obPay = itemObjects?["입금"]
                    let obSign = itemObjects?["구인자서명"]
                    
                    self.ofNameTitle.text = obName1 as? String
                    self.reNameTitle.text = obName2 as? String
                    self.nameTitle1.text = obName1 as? String
                    self.nameTitle2.text = obName2 as? String
                    self.finNTitle.text = obName1 as? String
                    self.finSTitle.text = obName2 as? String
                    
                    self.locationTitle1.text = obLoc1 as? String
                    self.locationTitle2.text = obLoc2 as? String
                    self.detailLocTitle.text = obLoc3 as? String
                    
                    self.phoneTitle1.text = obPho1 as? String
                    self.phoneTitle2.text = obPho2 as? String
                    
                    self.dayTimeTitle.text = obConTime as? String
                    self.conTitle.text = obCont as? String
                    self.detailLocTitle.text = obWLoc as? String
                    self.moneyTitle.text = obPay as? String
                    self.signOffer.text = obSign as? String
                }
              }
        })
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func finNextBtn(_ sender: UIButton) {
        if(signTextfield.text!.count > 0){
            let email1 = email!.components(separatedBy: ["@", "."]).joined()
            let email2 = uEmail!.components(separatedBy: ["@", "."]).joined()
            let mainT = "Cont" + email2 + email1
            let mainOf = "offer" + email2
            let mainRe = "research" + email1
            
            contractInfo = Database.database().reference()
            self.contractInfo.child("Contract").child(mainT).child("post").child("구직자서명").setValue(signTextfield.text)
            
            //구인자 입장 마이페이지 연결
            self.contractInfo.child("근로계약리스트").child(mainOf).child("post").child("구인자이름").setValue(ofNameTitle.text)
            self.contractInfo.child("근로계약리스트").child(mainOf).child("post").child("구직자이름").setValue(reNameTitle.text)
            self.contractInfo.child("근로계약리스트").child(mainOf).child("post").child("근로계약글uid").setValue(mainT)
            self.contractInfo.child("근로계약리스트").child(mainOf).child("post").child("글제목").setValue(titleN)
            self.contractInfo.child("근로계약리스트").child(mainOf).child("post").child("구인자연락처").setValue(phoneTitle1.text)
            self.contractInfo.child("근로계약리스트").child(mainOf).child("post").child("구직자연락처").setValue(phoneTitle2.text)

            //구직자 입장 마이페이지 연결
            self.contractInfo.child("근로계약리스트").child(mainRe).child("post").child("구인자이름").setValue(ofNameTitle.text)
            self.contractInfo.child("근로계약리스트").child(mainRe).child("post").child("구직자이름").setValue(reNameTitle.text)
            self.contractInfo.child("근로계약리스트").child(mainRe).child("post").child("근로계약글uid").setValue(mainT)
            self.contractInfo.child("근로계약리스트").child(mainRe).child("post").child("글제목").setValue(titleN)
            self.contractInfo.child("근로계약리스트").child(mainRe).child("post").child("구인자연락처").setValue(phoneTitle1.text)
            self.contractInfo.child("근로계약리스트").child(mainRe).child("post").child("구직자연락처").setValue(phoneTitle2.text)

            
            // navigation controller 로 화면 전환
            guard let contVC2 = self.storyboard?.instantiateViewController(withIdentifier: "ContractFinView2") as? ContractFinView2 else { return }
            
            contVC2.uEmail = self.uEmail
            contVC2.uName = self.ofNameTitle.text
            contVC2.myName = self.reNameTitle.text
            
            self.navigationController?.pushViewController(contVC2, animated: true)
        }else{
            
        }
    }
}

extension UIViewController {
    func cmhideKeyboard2() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.cmdismissKeyboard2))
        view.addGestureRecognizer(tap)
    }
    @objc func cmdismissKeyboard2() {
        view.endEditing(true)
    }
}
