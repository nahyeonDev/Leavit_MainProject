//
//  ChatOfferDetail.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/19.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth


class ChatOfferDetail: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var messageTableView: UITableView!
    var messages: [Message] = []
    
    let db = Firestore.firestore()
    @IBOutlet weak var messageTextField: UITextField!
    
    var fCurTextfieldBottom: CGFloat = 0.0
    
    //앨범버튼, 글
    @IBOutlet weak var garlleyBtn: UIButton!
    @IBOutlet weak var garlleryLabel: UILabel!
    //카메라버튼, 글
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var camerLabel: UILabel!
    //계약서버튼, 글
    @IBOutlet weak var contractBtn: UIButton!
    @IBOutlet weak var contractLabel: UILabel!
    
    var check = false
    
    var researchInfo: DatabaseReference!
    let email = FirebaseAuth.Auth.auth().currentUser?.email
    var researchList = [ReChatModel]()
    
    var yEmail : String?
    
    //정보
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bckBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        messageTableView.register(UINib(nibName: "OfferChatting", bundle: nil), forCellReuseIdentifier: "MessageCell")
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
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
        contractBtn.isHidden = true
        contractLabel.isHidden = true
        
        messageTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        viewInfo()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        bckBtn.addTarget(self, action: #selector(backBtn(_:)), for:.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: bckBtn)
        
    }
    //키보드 올라갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillShow(_ sender:Notification){
            self.mainView.frame.origin.y = -295
    }
    //키보드 내려갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillHide(_ sender:Notification){
            self.mainView.frame.origin.y = 0
        garlleyBtn.isHidden = true
        garlleryLabel.isHidden = true
        cameraBtn.isHidden = true
        camerLabel.isHidden = true
        contractBtn.isHidden = true
        contractLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         messageTextField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let messageCell = messageTableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! OfferChatting
        
        if message.sender == Auth.auth().currentUser?.email{
            messageCell.messageView.isHidden = true
            messageCell.mlabel.isHidden = true
            messageCell.mtlabel.isHidden = true
            messageCell.messageView2.isHidden = false
            messageCell.mlabel2.isHidden = false
            messageCell.mtlabel2.isHidden = false
            messageCell.messageView2.roundCorners(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner])
            messageCell.mlabel2.numberOfLines = 2
            
        }else{
            messageCell.messageView.isHidden = false
            messageCell.mlabel.isHidden = false
            messageCell.mtlabel.isHidden = false
            messageCell.messageView2.isHidden = true
            messageCell.mlabel2.isHidden = true
            messageCell.mtlabel2.isHidden = true
            messageCell.messageView.roundCorners(cornerRadius: 15, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner])
            messageCell.mlabel.numberOfLines = 2
        }

        messageCell.mlabel.text = message.body
        messageCell.mlabel2.text = message.body
        messageCell.mtlabel.text = message.time
        messageCell.mtlabel2.text = message.time
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
            
            let mainT = "Messages" + email! + yEmail! // Message+내이메일+상대이메일
            
            db.collection(mainT).addDocument(data: ["sender":messageSender, "body":messageBody,"date":Date().timeIntervalSince1970, "time": current_time_string])
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
        let mainT = "Messages" + email! + yEmail! // Message+내이메일+상대이메일
        
        db.collection(mainT).order(by: "date").addSnapshotListener{(querySnapshot, error) in
            self.messages = []
            
            if let e = error{
                print(e.localizedDescription)
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    snapshotDocuments.forEach{(doc)in
                        let data = doc.data()
                        if let sender = data["sender"] as?
                            String, let body = data["body"]as? String, let time = data["time"]as? String{
                            self.messages.append(Message(sender: sender, body: body, time: time))
                            
                            DispatchQueue.main.async {
                                self.messageTableView.reloadData()
                                self.messageTableView.scrollToRow(at: IndexPath(row: self.messages.count-1, section: 0), at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func viewInfo(){
        
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainL = "ResearchMessage" + email1
        
        researchInfo = Database.database().reference().child("ChatSet").child(email1).child(mainL)
        researchInfo.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.researchList.removeAll()
                
                for email1 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = email1.value as? [String: AnyObject]
                    let obTitle = itemObjects?["지원글제목"]
                    let obMoney = itemObjects?["지원글시급"]
                    let obTime = itemObjects?["지원글기간"]
                    
                    let items = ReChatModel(title: obTitle as! String?, money: obMoney as! String?, time: obTime as! String?)
                    
                    self.titleLabel.text = obTitle as? String
                    self.moneyLabel.text = obMoney as? String
                    self.timeLabel.text = obTime as? String
                    
                    self.researchList.append(items)
                }
              }
        })
    }
    
    @IBAction func openHiddenMenu(_ sender: UIButton) {
        if(check == false){
            self.mainView.frame.origin.y = -170
            garlleyBtn.isHidden = false
            garlleryLabel.isHidden = false
            cameraBtn.isHidden = false
            camerLabel.isHidden = false
            contractBtn.isHidden = false
            contractLabel.isHidden = false
            check = true
        }
        else{
            self.mainView.frame.origin.y = 0
            garlleyBtn.isHidden = true
            garlleryLabel.isHidden = true
            cameraBtn.isHidden = true
            camerLabel.isHidden = true
            contractBtn.isHidden = true
            contractLabel.isHidden = true
            check = false
        }
    }
    @IBAction func goContractView(_ sender: UIButton) {
        // navigation controller 로 화면 전환
        guard let mVC = self.storyboard?.instantiateViewController(withIdentifier: "ContractMainView2") as? ContractMainView2 else { return }
        mVC.uEmail = self.yEmail
        mVC.titleN = self.titleLabel.text
        self.navigationController?.pushViewController(mVC, animated: true)
    }
}

extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}


