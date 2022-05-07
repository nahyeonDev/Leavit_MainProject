//
//  ContractWriteView.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/02.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ContractWriteView: UIViewController {

    //구인자 정보
    @IBOutlet weak var nameTitle1: UITextField!
    @IBOutlet weak var birthTitle1: UITextField!
    @IBOutlet weak var phoneTitle1: UITextField!
    @IBOutlet weak var locationTitle1: UITextField!
    var bMyBirth : String?
    var currentLength = 0
    
    //구직자 정보
    @IBOutlet weak var nameTitle2: UITextField!
    @IBOutlet weak var birthTitle2: UITextField!
    @IBOutlet weak var phoneTitle2: UITextField!
    @IBOutlet weak var locationTitle2: UITextField!
    
    //근로 정보
    @IBOutlet weak var timeTitle: UITextField!
    @IBOutlet weak var locTitle: UITextField!
    @IBOutlet weak var contentTitle: UITextField!
    @IBOutlet weak var detailTimeTitle: UITextField!
    @IBOutlet weak var moneyTitle: UITextField!
    var postUid : String?
    
    let email = FirebaseAuth.Auth.auth().currentUser?.email
    let db = Firestore.firestore()
    
    var uEmail : String?
    
    var offerInfo: DatabaseReference!
    @IBOutlet weak var bckBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myInfo()
        yourInfo()
        workInfo()
        
        cwhideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        bckBtn.addTarget(self, action: #selector(backBtn(_:)), for:.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: bckBtn)
    }
    
    func myInfo(){
        let docRef = db.collection("가입개인정보").document(email!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"] as! String
                let obBirth = dataDescription?["주민등록번호(앞)"] as! String
                let obLoc = dataDescription?["위치"] as! String
                
                let birthString = obBirth.dropLast(5)
                if(birthString == "1" || birthString == "0" ){
                    self.bMyBirth = "20" + obBirth
                }
                else{
                    self.bMyBirth = "19" + obBirth
                }
                
                self.nameTitle1.text = obName
                self.birthTitle1.text = self.bMyBirth
                self.locationTitle1.text = obLoc
 
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func yourInfo(){
  
        let docRef = db.collection("가입개인정보").document(uEmail!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"] as! String
                let obBirth = dataDescription?["주민등록번호(앞)"] as! String
                let obLoc = dataDescription?["위치"] as! String
                
                let birthString = obBirth.dropLast(5)
                if(birthString == "1" || birthString == "0" ){
                    self.bMyBirth = "20" + obBirth
                }
                else{
                    self.bMyBirth = "19" + obBirth
                }
                
                self.nameTitle2.text = obName
                self.birthTitle2.text = self.bMyBirth
                self.locationTitle2.text = obLoc
 
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func workInfo(){
        
        offerInfo = Database.database().reference().child("구인글연결(근로)").child(postUid!)
        offerInfo.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                for 구인글연결 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = 구인글연결.value as? [String: AnyObject]
                    let obTime = itemObjects?["근무요일시간"] as! String
                    let obLoc = itemObjects?["근무지"] as! String
                    let obMoney = itemObjects?["지급요금"] as! String

                    let time =  obTime.components(separatedBy: " ")
                    let cLoc = obLoc.replacingOccurrences(of: "/", with: " ")

                    self.timeTitle.text = time[0]
                    self.detailTimeTitle.text = time[1]
                    self.locTitle.text = cLoc
                    self.moneyTitle.text = obMoney

                }
              }
        })
        
    }
    
    //전화번호 입력(빈칸 만들기)- 구인자버전
    @IBAction func phoneTitleEdit(_ sender: UITextField) {
        guard let text = phoneTitle1.text else {return}
            let length = text.count

            if (length > currentLength) {
                // when add text.
                if (length == 4 || length == 9) {
                    let content = NSMutableString(string: text)
                    content.insert("-", at: length - 1)
                    phoneTitle1.text = content as String
                }
            } else {
                // when delete text.
                if (length == 4 || length == 9) {
                    phoneTitle1.text = (text as NSString).substring(to: length - 1)
                }
            }

            currentLength = length
    }
    
    @IBAction func phoneTitleEdit2(_ sender: UITextField) {
        guard let text = phoneTitle2.text else {return}
            let length = text.count

            if (length > currentLength) {
                // when add text.
                if (length == 4 || length == 9) {
                    let content = NSMutableString(string: text)
                    content.insert("-", at: length - 1)
                    phoneTitle2.text = content as String
                }
            } else {
                // when delete text.
                if (length == 4 || length == 9) {
                    phoneTitle2.text = (text as NSString).substring(to: length - 1)
                }
            }

            currentLength = length
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goMainView(_ sender: UIButton) {
        // navigation controller 로 화면 전환
        guard let contVC1 = self.storyboard?.instantiateViewController(withIdentifier: "ContractMainView") as? ContractMainView else { return }
        contVC1.name1 = nameTitle1.text
        contVC1.name2 = nameTitle2.text
        contVC1.loc1 = locationTitle1.text
        contVC1.loc2 = locationTitle2.text
        contVC1.phone1 = phoneTitle1.text
        contVC1.phone2 = phoneTitle2.text
        contVC1.dayT = timeTitle.text
        contVC1.location = locTitle.text
        contVC1.timeT = detailTimeTitle.text
        contVC1.money = moneyTitle.text
        contVC1.cont = contentTitle.text
        contVC1.uEmail = self.uEmail
        self.navigationController?.pushViewController(contVC1, animated: true)
    }
}

extension UIViewController {
    func cwhideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.cwdismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func cwdismissKeyboard() {
        view.endEditing(true)
    }
}
