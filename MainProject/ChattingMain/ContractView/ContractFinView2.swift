//
//  ContractFinView2.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/03.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ContractFinView2: UIViewController {

    var uEmail : String?
    @IBOutlet weak var backBtn: UIButton!
    let email = FirebaseAuth.Auth.auth().currentUser?.email
    
    @IBOutlet weak var finBtn: UIButton!
    
    var myName : String?
    var uName : String?
    
    var contentChat : String?
    
    @IBOutlet weak var nameTitle2: UILabel!
    @IBOutlet weak var nameTitle1: UILabel!
    
    var messages2: [Message] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let name1 = uName! + "(" + uEmail! + ")"
        let name2 = myName! + "(" + email! + ")"
        
        nameTitle1.text = name1
        nameTitle2.text = name2
        
        contentChat = "[알림] " + myName! + "이 계약서 사인을 완료했습니다."
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        backBtn.addTarget(self, action: #selector(goBack(_:)), for:.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finConBtn(_ sender: UIButton) {
        if let messageBody = contentChat, let messageSender = Auth.auth().currentUser?.email{
            
            let formatter_time = DateFormatter()
            formatter_time.dateFormat = "HH:mm"
            let current_time_string = formatter_time.string(from: Date())
            print(current_time_string)
            
            let mainT = "Messages" + email! + uEmail!
            
            db.collection(mainT).addDocument(data: ["sender":messageSender, "body":messageBody,"date":Date().timeIntervalSince1970, "time" : current_time_string ])
            {(error)in
        if let e = error{
            print(e.localizedDescription)
        }else{
            print("Success save data")
        }
                
    }
        }
        
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        for viewController in viewControllerStack {
          if let bView = viewController as? ChatOfferDetail {
            self.navigationController?.popToViewController(bView, animated: true)
            }
        }
    }
    

}
