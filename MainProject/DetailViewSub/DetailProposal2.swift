//
//  DetailProposal2.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/04.
//

import UIKit
import FirebaseDatabase //데베 테스트용
import FirebaseFirestore
import FirebaseAuth


class DetailProposal2: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var finBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    var isChecked = false
    
    //글 정보
    @IBOutlet weak var mainTitle: UILabel! //글제목
    @IBOutlet weak var howMoney: UILabel!  //지급방법
    @IBOutlet weak var moneyTitle: UILabel!  //지급요금
    @IBOutlet weak var timeTitle: UILabel!  //기간
    
    //지원자 정보
    @IBOutlet weak var nameTitle: UILabel! //이름
    @IBOutlet weak var uInfoTitle: UILabel!  //나이성별지역
    @IBOutlet weak var emailTitle: UILabel!  //이메일
    @IBOutlet weak var backBtn: UIButton!
    
    
    var userId: String? //유저 uid
    var uTitle: String? //제목
    let db = Firestore.firestore()
    var detailSub2: DatabaseReference!
    var uEmail: String? //유저 이메일
    var detailOffer: DatabaseReference!
    
    let uiEmail = Auth.auth().currentUser!.email
    
    var email2 : String? //상대이메일
    var ref: DatabaseReference!
    
    var userName1 : String?
    var userName2 : String?
    var userLoc1 : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        offerWriteInfo()
        userInfo()
        
        mainTitle.text = uTitle
    }
    @IBAction func clickFinal(_ sender: UIButton) {
        
        if(isChecked == false){
            checkBtn.setImage(UIImage(named: "rec203.png"), for: .normal)
            isChecked = true
        }
        else if(isChecked == true){
            checkBtn.setImage(UIImage(named: "checkBox.png"), for: .normal)
            isChecked = false
        }
    }
    
    //닫기 기능
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //디폴트로 배치되는 뒤로가기 버튼 삭제
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.navigationItem.hidesBackButton = true
       backBtn.addTarget(self, action: #selector(goBack(_:)), for:.touchUpInside)
    }
    
    func offerWriteInfo(){
        detailOffer = Database.database().reference().child("구인글작성")
        detailOffer.child(userId!).observe(.value) {
                    snapshot in
            let value = snapshot.value as! [String: AnyObject]
                    let money = value["지급요금"] as! String
                    let how = value["지급방법"] as! String
                    let day = value["근무요일"] as! String
                    let time = value["근무시간"] as! String
            
            self.howMoney.text = how.trimmingCharacters(in: ["[","]"])
            self.moneyTitle.text = money
            let dtime = day + " " + time
            self.timeTitle.text = dtime

        }
    }
    func userInfo(){
        let docRef = self.db.collection("가입개인정보").document(uiEmail!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"]
                let obAge = dataDescription?["나이"]
                let obGen = dataDescription?["성별"]
                let obLoc = dataDescription?["위치"]
                let obEmail = dataDescription?["이메일"]
                
                let userI = "(" + (obAge as! String) + ", " + (obGen as! String) + "/" + (obLoc as! String) + ")"
                self.nameTitle.text = (obName as! String)
                self.uInfoTitle.text = userI
                self.emailTitle.text = (obEmail as! String)
 
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func goSupport(_ sender: Any) {
        ref = Database.database().reference()
        
        //구직하는 입장(현재 사용자) ResearchMessage+이메일(현재사용자)
        let email = (FirebaseAuth.Auth.auth().currentUser?.email)
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainL = "ResearchMessage" + email1
        let mainL2 = "Support" + email1
        
        let docRef1 = db.collection("가입개인정보").document(email2!)
        
        docRef1.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName1 = dataDescription?["이름"] as! String
                self.userName2 = obName1
                
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("상대방이메일").setValue(self.email2)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("상대방이름").setValue(self.userName2!)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("지원글제목").setValue(self.mainTitle.text!)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("글uid").setValue(self.userId!)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("지원글시급").setValue(self.moneyTitle.text!)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("지원글기간").setValue(self.timeTitle.text!)
                
                self.ref.child("Support글지원").child(email1).child(mainL2).child("post").child("상대방이메일").setValue(self.email2!)
                self.ref.child("Support글지원").child(email1).child(mainL2).child("post").child("글uid").setValue(self.userId!)
                self.ref.child("Support글지원").child(email1).child(mainL2).child("post").child("글제목").setValue(self.mainTitle.text!)
 
            } else {
                print("Document does not exist")
            }
        }
        
        //구인하는 입장(글 작성자) OfferMessage+이메일(글 작성자)
        let email2 = email2!.components(separatedBy: ["@", "."]).joined()
        let mainR = "OfferMessage" + email2
        print(mainR)
        let docRef2 = db.collection("가입개인정보").document(email!)
        let mainR2 = "Support" + email2
        
        docRef2.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"] as! String
                let obLoc = dataDescription?["위치"] as! String
                self.userName1 = obName
                self.userLoc1 = obLoc
                
                self.ref.child("ChatSet").child(email2).child(mainR).child("chat").child("상대방이메일").setValue(email)
                self.ref.child("ChatSet").child(email2).child(mainR).child("chat").child("지원자이름").setValue(self.userName1!)
                self.ref.child("ChatSet").child(email2).child(mainR).child("chat").child("글uid").setValue(self.userId!)
                self.ref.child("ChatSet").child(email2).child(mainR).child("chat").child("지원자시간").setValue("시간")
                self.ref.child("ChatSet").child(email2).child(mainR).child("chat").child("지원자지역").setValue(self.userLoc1)
                self.ref.child("ChatSet").child(email2).child(mainR).child("chat").child("글제목").setValue(self.mainTitle.text!)
 
                self.ref.child("Support글지원").child(email2).child(mainR2).child("post").child("상대방이메일").setValue(email)
                self.ref.child("Support글지원").child(email2).child(mainR2).child("post").child("글uid").setValue(self.userId!)
                self.ref.child("Support글지원").child(email2).child(mainR2).child("post").child("지원자이름").setValue(self.userName1!)
                self.ref.child("Support글지원").child(email2).child(mainR2).child("post").child("글제목").setValue(self.mainTitle.text!)
                
            } else {
                print("Document does not exist")
            }
        }
        
        guard let contVC2 = self.storyboard?.instantiateViewController(withIdentifier: "FinishProposal2") as? FinishProposal2 else { return }
        contVC2.loc2 = mainTitle.text
        contVC2.money2 = moneyTitle.text
        contVC2.time2 = timeTitle.text
        self.navigationController?.pushViewController(contVC2, animated: true)
        
    }

}
