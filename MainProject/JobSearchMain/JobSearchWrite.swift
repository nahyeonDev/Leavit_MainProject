// collection view 새로 건드려보기 전에 일단 저장! 다중 이미지 선택은 어느정도 구현함
//  JobSearchWrite.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/14.
//
import UIKit
import FirebaseDatabase
import FirebaseAuth
import YPImagePicker

class JobSearchWrite: UIViewController{
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var view1: UIView!
    
    //상단 타이틀 설정
    @IBOutlet weak var mTitle: UILabel!
 
    //글 제목 텍스트필드
    @IBOutlet weak var txtMyTitle: UITextField!
    
    //가능 업무 텍스트 필드
    @IBOutlet weak var okJobTxt: UITextField!
    var selectJob: String?
    
    //위치 텍스트 필드
    @IBOutlet weak var locationTxt: UITextField!
    var locationInfo: String?
    
    //근무정보 텍스트 필드
    @IBOutlet weak var myJobTxt: UITextField!
    var workInfo: String?
    
    //경력
    @IBOutlet weak var careerTxt: UITextField!
    var careerInfo: String?
    //자격증
    @IBOutlet weak var certifiTxt: UITextField!
    var certiInfo: String?
    //태그
    @IBOutlet weak var tagTxt: UITextField!
    var tagInfo: String?
    //자기소개
    @IBOutlet weak var detailTxt: UITextView!
    
    
    //back 버튼(닫기)
    @IBOutlet weak var backBtn: UIButton!
    //finish 버튼(완료)
    @IBOutlet weak var finBtn: UIButton!
    //가능업무 버튼
    @IBOutlet weak var okJobBtn: UIButton!
    //근무가능위치 버튼
    @IBOutlet weak var locOkBtn: UIButton!
    //근무정보 버튼
    @IBOutlet weak var myJobInfor: UIButton!
    //자격증, 경력 버튼
    @IBOutlet weak var myJobHistory: UIButton!
    //태그 버튼
    @IBOutlet weak var tagBtn: UIButton!
    //최종준수사항 버튼
    @IBOutlet weak var finCheck: UIButton!
    
    var check = false //체크
    
    var ref: DatabaseReference!
    var key: String?
    var myTitle: String?
    var jobTxt: String?
    var locTxt: String?
    var wTxt: String?
    var cTxt: String?
    var ceTxt: String?
    var tagMy: String?
    var deTxt: String?
    
    let userID = Auth.auth().currentUser!.uid
    let uEmail = Auth.auth().currentUser!.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        hideKeyboard3()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationItem.hidesBackButton = true
        if let job = selectJob {
            okJobTxt.text = job
        }
        if let work = workInfo{
            myJobTxt.text = work
        }
        if let loc = locationInfo{
            locationTxt.text = loc
        }
        if let tag = tagInfo{
            tagTxt.text = tag
        }
        if let car = careerInfo{
            careerTxt.text = car
        }
        if let cer = certiInfo{
            certifiTxt.text = cer
        }
    }
    
    @objc private func addNewEntry() {
        myTitle = txtMyTitle.text
        jobTxt = okJobTxt.text
        locTxt = locationTxt.text
        wTxt = myJobTxt.text
        cTxt = careerTxt.text
        ceTxt = certifiTxt.text
        tagMy = tagTxt.text
        deTxt = detailTxt.text
        //파이어베이스에 정보 올리기
        ref = Database.database().reference()
        
        let fullNameArr = myTitle!.split(separator: ",")
        let fulltagArr = tagMy!.split(separator: ",")
        let fullTimeArr = wTxt!.split(separator: ",")
        
        let genNum = "(" + fullNameArr[1] + ", " + fullNameArr[2] + ")"
        
        //구직글작성 파이어베이스
        self.ref.child("구직글작성").child(userID).child("이름").setValue(fullNameArr[0])
        self.ref.child("구직글작성").child(userID).child("성별나이").setValue(genNum)
        self.ref.child("구직글작성").child(userID).child("가능업무").setValue(jobTxt)
        self.ref.child("구직글작성").child(userID).child("근무가능위치").setValue(locTxt)
        self.ref.child("구직글작성").child(userID).child("근무요일").setValue(fullTimeArr[0])
        self.ref.child("구직글작성").child(userID).child("근무시간").setValue(fullTimeArr[1])
        self.ref.child("구직글작성").child(userID).child("경력").setValue(cTxt)
        self.ref.child("구직글작성").child(userID).child("자격증").setValue(ceTxt)
        self.ref.child("구직글작성").child(userID).child("태그1").setValue(fulltagArr[0])
        self.ref.child("구직글작성").child(userID).child("태그2").setValue(fulltagArr[1])
        self.ref.child("구직글작성").child(userID).child("태그3").setValue(fulltagArr[2])
        self.ref.child("구직글작성").child(userID).child("자기소개").setValue(deTxt)
        
        //구직리스트 파이어베이스
        self.ref.child("구직리스트").child(userID).child("이름").setValue(fullNameArr[0])
        self.ref.child("구직리스트").child(userID).child("성별나이").setValue(genNum)
        self.ref.child("구직리스트").child(userID).child("근무가능위치").setValue(locTxt)
        self.ref.child("구직리스트").child(userID).child("근무요일").setValue(fullTimeArr[0])
        self.ref.child("구직리스트").child(userID).child("근무시간").setValue(fullTimeArr[1])
        self.ref.child("구직리스트").child(userID).child("태그1").setValue(fulltagArr[0])
        self.ref.child("구직리스트").child(userID).child("태그2").setValue(fulltagArr[1])
        self.ref.child("구직리스트").child(userID).child("태그3").setValue(fulltagArr[2])
        self.ref.child("구직리스트").child(userID).child("리스트연결").setValue(userID)
        
        //구직글연결(근로) 파이어베이스
        self.ref.child("구직글연결(근로)").child(userID).child("post").child("이름").setValue(fullNameArr[0])
        self.ref.child("구직글연결(근로)").child(userID).child("post").child("성별나이").setValue(genNum)
        self.ref.child("구직글연결(근로)").child(userID).child("post").child("근무가능위치").setValue(locTxt)
        self.ref.child("구직글연결(근로)").child(userID).child("post").child("근무요일").setValue(fullTimeArr[0])
        self.ref.child("구직글연결(근로)").child(userID).child("post").child("근무시간").setValue(fullTimeArr[1])
        self.ref.child("구직글연결(근로)").child(userID).child("post").child("태그1").setValue(fulltagArr[0])
        self.ref.child("구직글연결(근로)").child(userID).child("post").child("태그2").setValue(fulltagArr[1])
        self.ref.child("구직글연결(근로)").child(userID).child("post").child("태그3").setValue(fulltagArr[2])
        self.ref.child("구직글연결(근로)").child(userID).child("post").child("리스트연결").setValue(userID)
        
        //지도 마커
        self.ref.child("채팅구직마커").child(userID).child("근무가능위치").setValue(locTxt)
        self.ref.child("채팅구직마커").child(userID).child("리스트연결").setValue(userID)
        
    }
    
    @IBAction func clickThisLine(_ sender: UIButton) {
        if((txtMyTitle.text!.count > 1) && (okJobTxt.text!.count > 1) && (locationTxt.text!.count > 1) && (myJobTxt.text!.count > 1) && (careerTxt.text!.count > 1) && (certifiTxt.text!.count > 1) && (tagTxt.text!.count > 1) && (detailTxt.text!.count > 1)){
            if(check == false){
                finCheck.setImage(UIImage(named: "sCheckoneRed.png"), for: .normal)
                finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
                check = true
            }
            else if(check == true){
                finCheck.setImage(UIImage(named: "sCheckone.png"), for: .normal)
                finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
                check = false
            }
        }
        else{
            self.showToast(message: "내용 입력을 완료해주세요.")
        }
    }
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 16.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 85, y: self.view.frame.size.height-100, width: 170, height: 35))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.red
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: { toastLabel.alpha = 0.0
            
        }, completion: {(isCompleted) in toastLabel.removeFromSuperview() })
        
    }

    @IBAction func thisFinish(_ sender: Any) {
        addNewEntry()
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func thisBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)

    }
    
}

extension UIViewController {
    func hideKeyboard3() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard3() {
        view.endEditing(true)
    }
}
