//
//  ContractMainView2.swift
//  MainProject
//
//  Created by κΉλν on 2022/05/03.
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
    var ref: DatabaseReference!
    
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
    //ν€λ³΄λ μ¬λΌκ°λ€λ μλ¦Όμ λ°μΌλ©΄ μ€νλλ λ©μλ
    @objc func keyboardWillShow(_ sender:Notification){
            self.mainView.frame.origin.y = -100
    }
    //ν€λ³΄λ λ΄λ €κ°λ€λ μλ¦Όμ λ°μΌλ©΄ μ€νλλ λ©μλ
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
                    let obName1 = itemObjects?["κ΅¬μΈμμ΄λ¦"]
                    let obName2 = itemObjects?["κ΅¬μ§μμ΄λ¦"]
                    let obLoc1 = itemObjects?["κ΅¬μΈμμ£Όμ"]
                    let obLoc2 = itemObjects?["κ΅¬μ§μμ£Όμ"]
                    let obPho1 = itemObjects?["κ΅¬μΈμμ°λ½μ²"]
                    let obPho2 = itemObjects?["κ΅¬μ§μμ°λ½μ²"]
                    let obConTime = itemObjects?["κ·Όλ‘κ³μ½κΈ°κ°"]
                    let obLoc3 = itemObjects?["κ·Όλ¬΄μ₯μ"]
                    let obCont = itemObjects?["μλ¬΄λ΄μ©"]
                    let obWLoc = itemObjects?["κ·Όλ‘μκ°"]
                    let obPay = itemObjects?["μκΈ"]
                    let obSign = itemObjects?["κ΅¬μΈμμλͺ"]
                    
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
                    self.timeTitle.text = obWLoc as? String
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
            self.contractInfo.child("Contract").child(mainT).child("post").child("κ΅¬μ§μμλͺ").setValue(signTextfield.text)
            
            //κ΅¬μΈμ μμ₯ λ§μ΄νμ΄μ§ μ°κ²°
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainOf).child("post").child("κ΅¬μΈμμ΄λ¦").setValue(ofNameTitle.text)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainOf).child("post").child("κ΅¬μ§μμ΄λ¦").setValue(reNameTitle.text)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainOf).child("post").child("κ·Όλ‘κ³μ½κΈuid").setValue(mainT)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainOf).child("post").child("κΈμ λͺ©").setValue(titleN)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainOf).child("post").child("κ΅¬μΈμμ°λ½μ²").setValue(phoneTitle1.text)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainOf).child("post").child("κ΅¬μ§μμ°λ½μ²").setValue(phoneTitle2.text)
            //κ΅¬μΈμ μ‘κΈ λ°μ΄ν°λ² μ΄μ€
            let fullTimeArr = timeTitle.text!.split(separator: "~")
            let time1 = fullTimeArr[0].split(separator: ":")
            let time2 = fullTimeArr[1].split(separator: ":")
            let timeM2 = String(time2[0])
            let timeM1 = String(time1[0])
            let timeM = (Int(timeM2) ?? 0)  - (Int(timeM1) ?? 0)
            print(timeM)
            self.contractInfo.child("μ‘κΈλ¦¬μ€νΈ").child(mainOf).child("post").child("κ΅¬μ§μμ΄λ¦").setValue(reNameTitle.text)
            self.contractInfo.child("μ‘κΈλ¦¬μ€νΈ").child(mainOf).child("post").child("κ·Όλ‘κ³μ½κΈuid").setValue(mainT)
            self.contractInfo.child("μ‘κΈλ¦¬μ€νΈ").child(mainOf).child("post").child("κΈμ λͺ©").setValue(titleN)
            self.contractInfo.child("μ‘κΈλ¦¬μ€νΈ").child(mainOf).child("post").child("μκΈ").setValue(moneyTitle.text)
            self.contractInfo.child("μ‘κΈλ¦¬μ€νΈ").child(mainOf).child("post").child("κ·Όλ¬΄μκ°1").setValue(timeTitle.text)
            self.contractInfo.child("μ‘κΈλ¦¬μ€νΈ").child(mainOf).child("post").child("κ·Όλ¬΄μκ°2").setValue(timeM)
            self.contractInfo.child("μ‘κΈλ¦¬μ€νΈ").child(mainOf).child("post").child("κ·Όλ¬΄λ μ§").setValue(dayTimeTitle.text)
            self.contractInfo.child("μ‘κΈλ¦¬μ€νΈ").child(mainOf).child("post").child("μμ§μ’").setValue(conTitle.text)
            self.contractInfo.child("μ‘κΈλ¦¬μ€νΈ").child(mainOf).child("post").child("κ΅¬μ§μμ΄λ©μΌ").setValue(email)

            //κ΅¬μ§μ μμ₯ λ§μ΄νμ΄μ§ μ°κ²°
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainRe).child("post").child("κ΅¬μΈμμ΄λ¦").setValue(ofNameTitle.text)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainRe).child("post").child("κ΅¬μ§μμ΄λ¦").setValue(reNameTitle.text)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainRe).child("post").child("κ·Όλ‘κ³μ½κΈuid").setValue(mainT)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainRe).child("post").child("κΈμ λͺ©").setValue(titleN)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainRe).child("post").child("κ΅¬μΈμμ°λ½μ²").setValue(phoneTitle1.text)
            self.contractInfo.child("κ·Όλ‘κ³μ½λ¦¬μ€νΈ").child(mainRe).child("post").child("κ΅¬μ§μμ°λ½μ²").setValue(phoneTitle2.text)
            
            self.ref = Database.database().reference().child("MainIng").child("offer").child(email2).child("post")
            self.ref.updateChildValues(["μ μμλ£": "yes"])
            
            self.ref = Database.database().reference().child("MainIng").child("search").child(email1).child("post")
            self.ref.updateChildValues(["μ μμλ£": "yes"])

            
            // navigation controller λ‘ νλ©΄ μ ν
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
