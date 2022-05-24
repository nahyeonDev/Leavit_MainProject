//
//  HomeSearchMain.swift
//  MainProject
//
//  Created by 김나현 on 2022/01/17.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeSearchMain: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var startView: UIImageView!
    
    var ref: DatabaseReference!
    var mainSearch: DatabaseReference!
    
    let myEmail = Auth.auth().currentUser!.email
    
    @IBOutlet weak var hLine: UIImageView!
    
    @IBOutlet weak var chatBtn: UIButton! //채팅하기
    @IBOutlet weak var startBtn: UIButton! //접수완료
    @IBOutlet weak var goBtn: UIButton! //출발했어요
    @IBOutlet weak var arriveBtn: UIButton! //도착했어요
    @IBOutlet weak var finBtn: UIButton! //퇴근했어요
    @IBOutlet weak var reviewBtn: UIButton! //리뷰쓰기
    @IBOutlet weak var wantLBtn: UIButton! //추천서 발급
    
    @IBOutlet weak var circle1: UIImageView!
    @IBOutlet weak var circle2: UIImageView!
    @IBOutlet weak var circle3: UIImageView!
    @IBOutlet weak var circle4: UIImageView!
    
    @IBOutlet weak var label1: UILabel! //근무지 출발
    @IBOutlet weak var label2: UILabel! //근무지 도착
    @IBOutlet weak var label3: UILabel! //퇴근
    @IBOutlet weak var backColor: UIImageView!
    
    @IBOutlet weak var mainTitle: UILabel! //글 제목
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainView.isHidden = true
        startView.isHidden = false
        mainView.layer.cornerRadius = 5
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 5, height: 5)
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOpacity = 0.1
        
        goBtn.isHidden = true
        arriveBtn.isHidden = true
        finBtn.isHidden = true
        reviewBtn.isHidden = true
        wantLBtn.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let mEmail = myEmail!.components(separatedBy: ["@", "."]).joined()
        mainSearch = Database.database().reference().child("MainIng").child("search").child(mEmail)
        mainSearch.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                for MainIng in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = MainIng.value as? [String: AnyObject]
                    
                    let oksign = itemObjects?["접수완료"] as? String ?? ""
                    let oktitle = itemObjects?["글제목"] as? String ?? ""
                    let okreview = itemObjects?["구직리뷰"] as? String ?? ""
                    self.mainTitle.text = oktitle
                    
                    if(oksign == "yes"){
                        self.mainView.isHidden = false
                        self.mainView.transform = CGAffineTransform(translationX: 0, y: -151)
                        self.startView.isHidden = true
                        
                    }
                    else{
                        self.mainView.isHidden = true
                        self.startView.isHidden = false
                        self.mainView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                    if(okreview == "yes"){
                        self.reviewBtn.isHidden = true
                    }
                    else{
                    }
                }
            }
            
        })
    }
    
    @IBAction func reStartBtn(_ sender: UIButton) {
        startBtn.isHidden = true
        goBtn.isHidden = false
        circle1.image("hokPurple.png")
        circle2.image("hingPurple.png")
        chatBtn.transform = CGAffineTransform(translationX: 0, y: +39)
        backColor.transform = CGAffineTransform(translationX: 0, y: +39)
        circle2.transform = CGAffineTransform(translationX: 0, y: -40)
        label1.transform = CGAffineTransform(translationX: 0, y: -40)
        
        
        let mEmail = myEmail!.components(separatedBy: ["@", "."]).joined()
        
        ref = Database.database().reference().child("MainIng").child("search").child(mEmail).child("post")
        ref.updateChildValues(["접수완료클릭": "yes"])
    }
    
    @IBAction func reGoBtn(_ sender: UIButton) {
        goBtn.isHidden = true
        arriveBtn.isHidden = false
        circle2.image("hokPurple.png")
        circle3.image("hingPurple.png")
        chatBtn.transform = CGAffineTransform(translationX: 0, y: +78)
        backColor.transform = CGAffineTransform(translationX: 0, y: +78)
        circle3.transform = CGAffineTransform(translationX: 0, y: -40)
        label2.transform = CGAffineTransform(translationX: 0, y: -40)
    
        let mEmail = myEmail!.components(separatedBy: ["@", "."]).joined()
        
        ref = Database.database().reference().child("MainIng").child("search").child(mEmail).child("post")
        ref.updateChildValues(["근무지출발": "yes"])
    }
    @IBAction func reArrBtn(_ sender: UIButton) {
        arriveBtn.isHidden = true
        finBtn.isHidden = false
        circle3.image("hokPurple.png")
        circle4.image("hingPurple.png")
        chatBtn.transform = CGAffineTransform(translationX: 0, y: +117)
        backColor.transform = CGAffineTransform(translationX: 0, y: +117)
        circle4.transform = CGAffineTransform(translationX: 0, y: -40)
        label3.transform = CGAffineTransform(translationX: 0, y: -40)
    
        hLine.image("hlinePurple2.png")
        hLine.frame.size.height = 109
        
        let mEmail = myEmail!.components(separatedBy: ["@", "."]).joined()
        
        ref = Database.database().reference().child("MainIng").child("search").child(mEmail).child("post")
        ref.updateChildValues(["근무지도착": "yes"])
    }
    
    @IBAction func reFinBtn(_ sender: UIButton) {
        circle4.image("hokPurple.png")
        finBtn.isHidden = true
        chatBtn.isHidden = true
        reviewBtn.isHidden = false
        wantLBtn.isHidden = false
        
        let mEmail = myEmail!.components(separatedBy: ["@", "."]).joined()
        
        ref = Database.database().reference().child("MainIng").child("search").child(mEmail).child("post")
        ref.updateChildValues(["퇴근": "yes"])
    }
    
    @IBAction func goWriteReview(_ sender: UIButton) {
        //storyboard를 통해 두번쨰 화면의 storyboard ID를 참조하여 뷰 컨트롤러를 가져옵니다.
            guard let svc = self.storyboard?.instantiateViewController(withIdentifier: "HomeReviewSearch") else {
                return
            }
            
            //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
            self.present(svc, animated: true)
    }
}
