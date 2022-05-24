//
//  HomeViewDetail.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/26.
//
import UIKit
import FirebaseDatabase //데베 테스트용
import FirebaseFirestore
import FirebaseAuth
import UserNotifications

class HomeViewDetail: UIViewController{
    
    private let database = Database.database().reference() //데베 테스트용
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var topMenu: UIImageView!
    @IBOutlet weak var topBtn: UIImageView!
    @IBOutlet weak var backColorImg: UIImageView!
    @IBOutlet weak var homeLogoImg: UIImageView!
    
    @IBOutlet weak var alLabelView: UIView!
    
    @IBOutlet weak var nameTitle: UILabel! //사용자 이름
    
    var check = false
    let uEmail = Auth.auth().currentUser!.email
    let db = Firestore.firestore()
    
    var mainSearch : DatabaseReference!
    var mainOffer : DatabaseReference!
    var ref : DatabaseReference!
    @IBOutlet weak var mainIngView: UIView!
    @IBOutlet weak var subMainView: UIView!
    
    var startOf : String? = ""
    var startRe : String? = ""
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //뒤의 판들 코너 둥글게
        viewMain.layer.cornerRadius = 15
        viewMain.layer.masksToBounds = true
        
        //뒤의 판들 코너 둥글게
        view1.layer.cornerRadius = 10
        view1.layer.masksToBounds = true
        
        alLabelView.layer.cornerRadius = 10
        alLabelView.layer.masksToBounds = true
        alLabelView.isHidden = true
        
        subView2.isHidden = false
        subView1.isHidden = true
        
        CurrentUser()
    }
    //근무지원 알림(구인자)
    private func generateUserNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if let error = error {
            print(error)
            
        } else {
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "근무 제안 알림"
                content.body = "김나현님이 근무를 제안하셨습니다."
                content.badge = 1
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                let request = UNNotificationRequest(identifier: "Sample Notification", content: content, trigger: trigger)
                self.notificationCenter.add(request, withCompletionHandler: nil)
            } else {
                print("Not Granted")
                
               }
            
            }
         
        }
    }
    //근무지원성공 알림(구직자)
    private func generateUserNotification2() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if let error = error {
            print(error)
            
        } else {
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "근무 제안 성공"
                content.body = "구인자님이 근무 제안을 승낙하셨습니다."
                content.badge = 1
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                let request = UNNotificationRequest(identifier: "Sample Notification", content: content, trigger: trigger)
                self.notificationCenter.add(request, withCompletionHandler: nil)
            } else {
                print("Not Granted")
                
               }
            
            }
         
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        let mEmail = uEmail!.components(separatedBy: ["@", "."]).joined()
        
        ref = Database.database().reference().child("메인화면세팅").child(mEmail)
        
        ref.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                for 메인화면세팅 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = 메인화면세팅.value as? [String: AnyObject]
                    let okRe = itemObjects?["구직"] as? String ?? ""
                    let okOf = itemObjects?["구인"] as? String ?? ""
                    
                    if(okRe == "O"){
                        UIView.animate(withDuration: 0.5, animations: {
                            self.topMenu.transform = CGAffineTransform(translationX: 162.0, y: 0)
                        })
                        self.topBtn.image("hoptionSearch2.png")
                        self.backColorImg.image("image425.png")
                        self.homeLogoImg.image("homelogoRed.png")
                        self.subView1.isHidden = false
                        self.subView2.isHidden = true
                        self.check = true;
                    }
                    if(okOf == "O"){
                        UIView.animate(withDuration: 0.5, animations: {
                            self.topMenu.transform = CGAffineTransform(translationX: 0, y: 0)
                        })
                        self.topBtn.image("optionSearch.png")
                        self.backColorImg.image("image424.png")
                        self.homeLogoImg.image("homelogoPurple.png")
                        self.subView1.isHidden = true
                        self.subView2.isHidden = false
                        self.check = false;
                    }
                }
            }
            
        })
        
        mainSearch = Database.database().reference().child("MainIng").child("search").child(mEmail)
        
        mainSearch.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                for MainIng in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = MainIng.value as? [String: AnyObject]
                    let oksign = itemObjects?["접수완료"] as? String ?? ""
                    let alsign = itemObjects?["지원성공"] as? String ?? ""
                    
                    
                    if(oksign == "yes"){
                        self.subMainView.transform = CGAffineTransform(translationX: 0, y: 159)
                        
                    }
                    else{
                        self.subMainView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                    if(alsign == "o"){
                        self.generateUserNotification2()
                        let email2 = self.uEmail!.components(separatedBy: ["@", "."]).joined()
                        self.mainSearch = Database.database().reference().child("MainIng").child("search").child(email2).child("post")
                        
                        self.mainSearch.updateChildValues(["지원성공": "yes"])
                    }
                    else{
                        
                    }
                }
            }
            
        })
   
        mainOffer = Database.database().reference().child("MainIng").child("offer").child(mEmail)
        
        mainOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                for MainIng in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = MainIng.value as? [String: AnyObject]
                    
                    let oksign = itemObjects?["접수완료"] as! String
                    let alsign = itemObjects?["알람완료"] as! String
                    if(oksign == "yes"){
                        self.subMainView.transform = CGAffineTransform(translationX: 0, y: 159)
                        
                    }
                    else{
                        self.subMainView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                    
                    if(alsign == "x"){
                        self.alLabelView.isHidden = false
                        self.generateUserNotification()
//                        let alert = self.storyboard?.instantiateViewController(withIdentifier: "HomeMainAlarmOf") as! HomeMainAlarmOf
//                        alert.modalPresentationStyle = .overCurrentContext
//                        alert.modalTransitionStyle = .crossDissolve
//                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        self.alLabelView.isHidden = true
                    }
                }
            }
            
        })        
    }
    @IBAction func clickBtn(_ sender: UIButton) {
        if(check==true){
            UIView.animate(withDuration: 0.5, animations: {
                self.topMenu.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            topBtn.image("optionSearch.png")
            backColorImg.image("image424.png")
            homeLogoImg.image("homelogoPurple.png")
            subView1.isHidden = true
            subView2.isHidden = false
            check = false;
        }
    }
    @IBAction func clickBtn2(_ sender: UIButton) {
        if(check==false){
            UIView.animate(withDuration: 0.5, animations: {
                self.topMenu.transform = CGAffineTransform(translationX: 162.0, y: 0)
            })
            topBtn.image("hoptionSearch2.png")
            backColorImg.image("image425.png")
            homeLogoImg.image("homelogoRed.png")
            subView1.isHidden = false
            subView2.isHidden = true
            check = true;
        }
    }
    
    func CurrentUser(){
        
        let docRef = db.collection("가입개인정보").document(uEmail!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"]
                let name = obName as! String + "님"
                self.nameTitle.text = name
 
            } else {
                print("Document does not exist")
            }
        }

    }
    
    @IBAction func goAlarmPage(_ sender: UIButton) {
        guard let contVC2 = self.storyboard?.instantiateViewController(withIdentifier: "HomeAlarmViewController") as? HomeAlarmViewController else { return }
        self.navigationController?.pushViewController(contVC2, animated: true)
    }
}

