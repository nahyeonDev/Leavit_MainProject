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
    
    
    var userId: String? //유저 uid
    var uTitle: String? //제목
    let db = Firestore.firestore()
    var detailSub2: DatabaseReference!
    var uEmail: String? //유저 이메일
    var detailOffer: DatabaseReference!
    
    let uiEmail = Auth.auth().currentUser!.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        offerWriteInfo()
        userInfo()
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
        self.dismiss(animated: true, completion: nil)
    }
    
    //디폴트로 배치되는 뒤로가기 버튼 삭제
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        if let user = userId {
            self.userId = user
            print(userId! as String)
        }
        if let title = uTitle{
            self.mainTitle.text = title
        }
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
    
    //segue가 진행되기전에 준비하는 함수
        //DetailProposal에게 데이터 넘긴다
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if segue.identifier == "detailFinish2" {
                let vc = segue.destination as? FinishProposal2
                vc?.loc2 = mainTitle.text
                vc?.money2 = moneyTitle.text
                vc?.time2 = timeTitle.text
            }
        }

}
