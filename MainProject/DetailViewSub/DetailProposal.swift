//
//  DetailProposal.swift
//  MainProject
//
//  Created by 김나현 on 2021/12/14.
//

import UIKit
import FirebaseDatabase //데베 테스트용
import FirebaseFirestore
import FirebaseAuth

class DetailProposal: UIViewController {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var finBtn: UIButton!
    
    @IBOutlet weak var fCheckBtn: UIButton!
    var isChecked = false
    
    @IBOutlet weak var writeChecked: UIButton!
    var ch = false
    
    //제안받는 사용자 정보
    @IBOutlet weak var nameTitle: UILabel! //이름
    @IBOutlet weak var locTitle: UILabel!  //지역
    @IBOutlet weak var timeTitle: UILabel!  //가능날
    
    //채용자 정보
    @IBOutlet weak var nameTitle2: UILabel! //이름
    @IBOutlet weak var userInfo: UILabel!  //나이성별지역
    @IBOutlet weak var userEmailTxt: UILabel!  //이메일
    
    //구인글 선택
    @IBOutlet weak var mainTitle: UILabel! //제목
    @IBOutlet weak var mainTimeTitle: UILabel! //최근 수정일
    
    let db = Firestore.firestore()
    var userId: String? //유저 uid
    var detailSub: DatabaseReference!
    var uEmail: String? //유저 이메일
    var detailSearch: DatabaseReference!
    var detailOffer: DatabaseReference!
    
    let yEmail = Auth.auth().currentUser?.email //현재 제안하는 사용자 이메일
    let yuId = Auth.auth().currentUser?.uid //현재 사용자 uid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yUserInformation()
        currentUserInformation()
        yUserOfferWrite()
        
        finBtn.isEnabled = false
    }
    
    @IBAction func clickFinal(_ sender: UIButton) {
        
        if(isChecked == false){
            fCheckBtn.setImage(UIImage(named: "rec203.png"), for: .normal)
            isChecked = true
            finBtn.isEnabled = true
        }
        else if(isChecked == true){
            fCheckBtn.setImage(UIImage(named: "checkBox.png"), for: .normal)
            isChecked = false
            finBtn.isEnabled = false
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
        }
    }
    @IBAction func checkOne(_ sender: UIButton) {
        if(ch == false){
            writeChecked.setImage(UIImage(named: "wrCheckRed.png"), for: .normal)
            ch = true
        }
        else if(ch == true){
            writeChecked.setImage(UIImage(named: "wrCheck1.png"), for: .normal)
            ch = false
        }
    }
    
    
    //채용자 정보 받아오기
    func yUserInformation(){
        let docRef = self.db.collection("가입개인정보").document(yEmail!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"]
                let obAge = dataDescription?["나이"]
                let obGen = dataDescription?["성별"]
                let obLoc = dataDescription?["위치"]
                let obEmail = dataDescription?["이메일"]
                
                let userI = "(" + (obAge as! String) + ", " + (obGen as! String) + "/" + (obLoc as! String) + ")"
                self.nameTitle2.text = (obName as! String)
                self.userInfo.text = userI
                self.userEmailTxt.text = self.yEmail!
                self.uEmail = (obEmail as! String)
 
            } else {
                print("Document does not exist")
            }
        }
    }
    //제안받을 사용자 정보
    func currentUserInformation(){
        detailSearch = Database.database().reference().child("구직글작성")
        detailSearch.child(userId!).observe(.value) {
                    snapshot in
            let value = snapshot.value as! [String: AnyObject]
                    let name = value["이름"] as! String
                    let loc = value["근무가능위치"] as! String
                    let day = value["근무요일"] as! String
                    let time = value["근무시간"] as! String
            
            self.nameTitle.text = name
            self.locTitle.text = loc
            self.timeTitle.text = day + time
        }
    }
    //구인글 선택
    func yUserOfferWrite(){
        detailSearch = Database.database().reference().child("구인글작성")
        detailSearch.child(yuId!).observe(.value) {
                    snapshot in
            let value = snapshot.value as! [String: AnyObject]
                    let title = value["글제목"] as! String
            
            self.mainTitle.text = title
            
        }
    }
    
    //segue가 진행되기전에 준비하는 함수
        //DetailProposal에게 데이터 넘긴다
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if segue.identifier == "detailFinish" {
                let vc = segue.destination as? FinishProposal
                vc?.name = nameTitle.text
                vc?.loc = locTitle.text
                vc?.time = timeTitle.text
            }
        }
 
}

