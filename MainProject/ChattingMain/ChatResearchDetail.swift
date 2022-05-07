//
//  ChatResearchDetail.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ChatResearchDetail: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var MessageTableView: UITableView!
    var messages2: [Message] = []
    
    let db = Firestore.firestore()
    @IBOutlet weak var messageTextField: UITextField!
    
    var fCurTextfieldBottom: CGFloat = 0.0
    
    //앨범버튼, 글
    @IBOutlet weak var garlleyBtn: UIButton!
    @IBOutlet weak var garlleryLabel: UILabel!
    //카메라버튼, 글
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var camerLabel: UILabel!
    //송금버튼, 글
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var payLabel: UILabel!
    //계약서버튼, 글
    @IBOutlet weak var contractBtn: UIButton!
    @IBOutlet weak var contractLabel: UILabel!
    
    var check = false
    
    var offerInfo: DatabaseReference!
    let email = FirebaseAuth.Auth.auth().currentUser?.email
    var offerList = [OfChatModel]()
    var yEmail : String?
    var yUid : String?
    
    @IBOutlet weak var bckBtn: UIButton!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var locTitle: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        MessageTableView.register(UINib(nibName: "ResearchChatting", bundle: nil), forCellReuseIdentifier: "MessageCell2")
        
        MessageTableView.delegate = self
        MessageTableView.dataSource = self
        
        messageTextField.delegate = self
        // Register Keyboard notifications
        // addObserver를 통해 옵저버를 설정할 대상을 뷰컨트롤러 객체(self)로 지정
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillHide(_:)),
                                                name: UIResponder.keyboardWillHideNotification,
                                                object: nil)
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillShow(_:)),
                                                name: UIResponder.keyboardWillShowNotification,
                                                object: nil)
        loadMessage()
        
        garlleyBtn.isHidden = true
        garlleryLabel.isHidden = true
        cameraBtn.isHidden = true
        camerLabel.isHidden = true
        payBtn.isHidden = true
        payLabel.isHidden = true
        contractBtn.isHidden = true
        contractLabel.isHidden = true
        
        MessageTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        viewInfo2()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true

        bckBtn.addTarget(self, action: #selector(backBtn(_:)), for:.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: bckBtn)
    }
    
    //키보드 올라갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillShow(_ sender:Notification){
            self.MainView.frame.origin.y = -295
    }
    //키보드 내려갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillHide(_ sender:Notification){
            self.MainView.frame.origin.y = 0
        garlleyBtn.isHidden = true
        garlleryLabel.isHidden = true
        cameraBtn.isHidden = true
        camerLabel.isHidden = true
        payBtn.isHidden = true
        payLabel.isHidden = true
        contractBtn.isHidden = true
        contractLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         messageTextField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages2[indexPath.row]
        let messageCell = MessageTableView.dequeueReusableCell(withIdentifier: "MessageCell2", for: indexPath) as! ResearchChatting
        
        if message.sender == Auth.auth().currentUser?.email{
            messageCell.mMessageView.isHidden = true
            messageCell.mnlabel.isHidden = true
            messageCell.tlabel.isHidden = true
            messageCell.mMessageView2.isHidden = false
            messageCell.mnlabel2.isHidden = false
            messageCell.tlabel2.isHidden = false
            messageCell.mMessageView2.roundCorners2(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner])
            messageCell.mMessageView2.frame.origin.x = 83
            messageCell.mnlabel2.numberOfLines = 2
            
        }else{
            messageCell.mMessageView.isHidden = false
            messageCell.mnlabel.isHidden = false
            messageCell.tlabel.isHidden = false
            messageCell.mMessageView2.isHidden = true
            messageCell.mnlabel2.isHidden = true
            messageCell.tlabel2.isHidden = true
            messageCell.mMessageView.roundCorners2(cornerRadius: 15, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner])
            messageCell.mnlabel2.numberOfLines = 2
        }
        messageCell.mnlabel.text = message.body
        messageCell.tlabel.text = message.time
        messageCell.mnlabel2.text = message.body
        messageCell.tlabel2.text = message.time
        return messageCell
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            
            let formatter_time = DateFormatter()
            formatter_time.dateFormat = "HH:mm"
            let current_time_string = formatter_time.string(from: Date())
            print(current_time_string)
            
            let mainT = "Messages" + yEmail! + email!
            
            db.collection(mainT).addDocument(data: ["sender":messageSender, "body":messageBody,"date":Date().timeIntervalSince1970, "time" : current_time_string ])
            {(error)in
        if let e = error{
            print(e.localizedDescription)
        }else{
            print("Success save data")
            
            DispatchQueue.main.async {
                self.messageTextField.text = ""
            }
        }
                
    }
        }
    }
    
    private func loadMessage(){
        
        let mainT = "Messages" + yEmail! + email!
        
        db.collection(mainT).order(by: "date").addSnapshotListener{(querySnapshot, error) in
            self.messages2 = []
            
            if let e = error{
                print(e.localizedDescription)
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    snapshotDocuments.forEach{(doc)in
                        let data = doc.data()
                        if let sender = data["sender"] as?
                            String, let body = data["body"]as? String, let time = data["time"]as? String{
                            self.messages2.append(Message(sender: sender, body: body, time: time))
                            
                            DispatchQueue.main.async {
                                self.MessageTableView.reloadData()
                                self.MessageTableView.scrollToRow(at: IndexPath(row: self.messages2.count-1, section: 0), at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func viewInfo2(){
        
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainR = "OfferMessage" + email1
        
        offerInfo = Database.database().reference().child("ChatSet").child(email1).child(mainR)
        offerInfo.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.offerList.removeAll()
                
                for email1 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = email1.value as? [String: AnyObject]
                    let obName = itemObjects?["지원자이름"]
                    let obLoc = itemObjects?["지원자지역"]
                    let obTime = itemObjects?["지원자시간"]
                    let obUid = itemObjects?["글uid"]
                    
                    let items = OfChatModel(name: obName as! String?, loc: obLoc as! String?, time: obTime as! String?)
                    
                    self.nameTitle.text = obName as? String
                    self.locTitle.text = obLoc as? String
                    self.timeTitle.text = obTime as? String
                    self.yUid = obUid as? String
                    
                    self.offerList.append(items)
                }
              }
        })
    }
    
    @IBAction func openHiddenMenu(_ sender: UIButton) {
        if(check == false){
            self.MainView.frame.origin.y = -170
            garlleyBtn.isHidden = false
            garlleryLabel.isHidden = false
            cameraBtn.isHidden = false
            camerLabel.isHidden = false
            payBtn.isHidden = false
            payLabel.isHidden = false
            contractBtn.isHidden = false
            contractLabel.isHidden = false
            check = true
        }
        else{
            self.MainView.frame.origin.y = 0
            garlleyBtn.isHidden = true
            garlleryLabel.isHidden = true
            cameraBtn.isHidden = true
            camerLabel.isHidden = true
            payBtn.isHidden = true
            payLabel.isHidden = true
            contractBtn.isHidden = true
            contractLabel.isHidden = true
            check = false
        }
    }
    
    @IBAction func goContract(_ sender: UIButton) {
        // navigation controller 로 화면 전환
        guard let mVC = self.storyboard?.instantiateViewController(withIdentifier: "ContractWriteView") as? ContractWriteView else { return }
        mVC.uEmail = self.yEmail
        mVC.postUid = self.yUid
        self.navigationController?.pushViewController(mVC, animated: true)
    }
    
}

extension UIView {
    func roundCorners2(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}

