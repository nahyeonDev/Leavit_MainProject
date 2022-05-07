//
//  MarkerInfoWindow2.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/19.
//

import UIKit
import Firebase
import FirebaseDatabase

class MarkerInfoWindow2: UIViewController {

    var userID: String?
    var offerView: DatabaseReference!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var downBtn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        downBtn2.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        mainView.layer.cornerRadius = 10

    }
    override func viewDidAppear(_ animated: Bool) {
        if let uid = userID{
            userID = uid
            print("유저아이디", userID!)
        }
    }
    @objc func dismissView(){
            dismiss(animated: false, completion: nil)
    }
    
//    func settingInfo(){
//        offerView = Database.database().reference().child("구인글작성")
//       offerView.child(userID!).observe(.value) {
//                    snapshot in
//            let value = snapshot.value as! [String: AnyObject]
//                    let name = value["이름"] as! String
//                    let loc = value["근무가능위치"] as! String
//                    let day = value["근무요일"] as! String
//                    let time = value["근무시간"] as! String
//                    let tag1 = value["태그1"] as! String
//                    let tag2 = value["태그2"] as! String
//                    let tag3 = value["태그3"] as! String
//
//            self.nameTitle.text = name
//            self.locTitle.text = loc
//            self.timeTitle.text = day + time
//            self.tag1Title.text = tag1
//            self.tag2Title.text = tag2
//            self.tag3Title.text = tag3
//       }
//    }
        
}




