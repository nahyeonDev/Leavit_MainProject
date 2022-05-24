//
//  MyMainCheckView.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/14.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class MyMainCheckView: UIViewController {

    let email = Auth.auth().currentUser?.email
    let db = Firestore.firestore()
    
    var ref : DatabaseReference!
    var name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let docRef = db.collection("가입개인정보").document(email!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"] as? String ?? ""
                self.name = obName
                let messageText = self.name! + "님 환영합니다!"
                self.showToast(message: messageText)
 
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func goOfferMain(_ sender: UIButton) {
        //navigation controller 로 화면 전환
          guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "tabbarcontroller") else { return }
        
        let mEmail = email!.components(separatedBy: ["@", "."]).joined()
        ref = Database.database().reference()
        ref.child("메인화면세팅").child(mEmail).child("post").child("구인").setValue("O")
        ref.child("메인화면세팅").child(mEmail).child("post").child("구직").setValue("X")
        
          self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    @IBAction func goSearchMain(_ sender: UIButton) {
        //navigation controller 로 화면 전환
          guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "tabbarcontroller") else { return }
        
        let mEmail = email!.components(separatedBy: ["@", "."]).joined()
        ref = Database.database().reference()
        ref.child("메인화면세팅").child(mEmail).child("post").child("구인").setValue("X")
        ref.child("메인화면세팅").child(mEmail).child("post").child("구직").setValue("O")
        
          self.navigationController?.pushViewController(homeVC, animated: true)
    }
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 16.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 85, y: self.view.frame.size.height-100, width: 170, height: 35))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.blue
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
}
