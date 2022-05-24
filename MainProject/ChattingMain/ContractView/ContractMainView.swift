//
//  ContractMainView.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/02.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ContractMainView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var ofNameTitle: UITextField!
    @IBOutlet weak var reNameTitle: UITextField!
    var name1 : String?
    var name2 : String?
    var loc1 : String?
    var loc2 : String?
    var dayT : String?
    var location : String?
    var timeT : String?
    var money : String?
    var phone1 : String?
    var phone2 : String?
    var cont : String?
    
    @IBOutlet weak var nameTitle1: UILabel!
    @IBOutlet weak var locationTitle1: UILabel!
    @IBOutlet weak var phoneTitle1: UILabel!
    
    @IBOutlet weak var nameTitle2: UILabel!
    @IBOutlet weak var locationTitle2: UILabel!
    @IBOutlet weak var phoneTitle2: UILabel!
    
    @IBOutlet weak var detailLocTitle: UILabel!
    @IBOutlet weak var monTitle: UITextField!
    
    @IBOutlet weak var leTime: UITextField!
    @IBOutlet weak var riTime: UITextField!
    @IBOutlet weak var contTitle: UILabel!
    
    @IBOutlet weak var bckBtn: UIButton!
    
    @IBOutlet weak var finName1: UILabel!
    @IBOutlet weak var finName2: UILabel!
    
    @IBOutlet weak var offerSign: UITextField!
    @IBOutlet weak var researchSign: UITextField!
    
    @IBOutlet weak var year1: UITextField!
    @IBOutlet weak var month1: UITextField!
    @IBOutlet weak var day1: UITextField!
    
    @IBOutlet weak var year2: UITextField!
    @IBOutlet weak var month2: UITextField!
    @IBOutlet weak var day2: UITextField!
    
    @IBOutlet weak var year3: UITextField!
    @IBOutlet weak var month3: UITextField!
    @IBOutlet weak var day3: UITextField!
    
    
    let email = FirebaseAuth.Auth.auth().currentUser?.email
    var uEmail : String?
    
    var contractInfo: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailLocTitle.text = location
        monTitle.text = money
        
        let ti =  timeT!.components(separatedBy: "~")
        leTime.text = ti[0]
        riTime.text = ti[1]
        
        monTitle.text = money
        
        ofNameTitle.text = name1
        nameTitle1.text = name1
        finName1.text = name1
        
        reNameTitle.text = name2
        nameTitle2.text = name2
        finName2.text = name2
        
        locationTitle1.text = loc1
        locationTitle2.text = loc2
        
        phoneTitle1.text = phone1
        phoneTitle2.text = phone2
        
        contTitle.text = cont
        // Register Keyboard notifications
        // addObserver를 통해 옵저버를 설정할 대상을 뷰컨트롤러 객체(self)로 지정
        offerSign.delegate = self
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillHide(_:)),
                                                name: UIResponder.keyboardWillHideNotification,
                                                object: nil)
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillShow(_:)),
                                                name: UIResponder.keyboardWillShowNotification,
                                                object: nil)
        cmhideKeyboard()
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
//        self.year3.resignFirstResponder()
//        self.month3.resignFirstResponder()
//        self.day3.resignFirstResponder()
//        self.offerSign.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        bckBtn.addTarget(self, action: #selector(backBtn(_:)), for:.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: bckBtn)
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func goNext(_ sender: Any) {
        if(offerSign.text!.count > 0){
            
            let email1 = email!.components(separatedBy: ["@", "."]).joined()
            let email2 = uEmail!.components(separatedBy: ["@", "."]).joined()
            let mainT = "Cont" + email1 + email2
            
            let t1 = year1.text! + "년 " + month1.text! + "월 " + day1.text! + "일 ~ " + year2.text! + "년 " + month2.text! + "월 " + day2.text! + "일"
            let t2 = leTime.text! + "~" + riTime.text!
            let t3 = year3.text! + "년 " + month3.text! + "월 " + day3.text! + "일"
            
            contractInfo = Database.database().reference()
            self.contractInfo.child("Contract").child(mainT).child("post").child("구인자이름").setValue(ofNameTitle.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("구직자이름").setValue(reNameTitle.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("구인자주소").setValue(locationTitle1.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("구직자주소").setValue(locationTitle2.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("구인자연락처").setValue(phoneTitle1.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("구직자연락처").setValue(phoneTitle2.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("근로계약기간").setValue(t1)
            self.contractInfo.child("Contract").child(mainT).child("post").child("근무장소").setValue(detailLocTitle.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("업무내용").setValue(contTitle.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("근로시간").setValue(t2)
            self.contractInfo.child("Contract").child(mainT).child("post").child("입금").setValue(monTitle.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("작성날짜").setValue(t3)
            self.contractInfo.child("Contract").child(mainT).child("post").child("구인자서명").setValue(offerSign.text)
            self.contractInfo.child("Contract").child(mainT).child("post").child("구직자서명").setValue("")
            
            // navigation controller 로 화면 전환
            guard let contVC2 = self.storyboard?.instantiateViewController(withIdentifier: "ContractFinView") as? ContractFinView else { return }
            
            contVC2.uEmail = self.uEmail
            contVC2.myName = self.ofNameTitle.text
            contVC2.uName = self.reNameTitle.text
            self.navigationController?.pushViewController(contVC2, animated: true)
        }
        else{
            
        }
    }
    
}
extension UIViewController {
    func cmhideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.cmdismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func cmdismissKeyboard() {
        view.endEditing(true)
    }
}
