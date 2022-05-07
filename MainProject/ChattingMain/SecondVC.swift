//
//  SecondVC.swift
//  MainProject
//
//  Created by 신예진 on 2021/12/04.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class SecondVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var chatOffer: DatabaseReference!
    
    var chatList2 = [ChatModel2]()
    let email = FirebaseAuth.Auth.auth().currentUser?.email
    var yEmail : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.allowsSelection = true
        
        let email2 = email!.components(separatedBy: ["@", "."]).joined()
        let mainR = "OfferMessage" + email2
        
        chatOffer = Database.database().reference().child("ChatSet").child(email2).child(mainR)
        chatOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.chatList2.removeAll()
                
                for email2 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = email2.value as? [String: AnyObject]
                    let obName = itemObjects?["지원자이름"]
                    let obTitle = itemObjects?["글제목"]
                    let obEmail = itemObjects?["상대방이메일"]
                    
                    let items = ChatModel2(name: obName as! String?, title: obTitle as! String?)
                    
                    self.yEmail = obEmail as! String?
                    self.chatList2.append(items)
                }
                self.myTableView.reloadData()
              }
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCCell") as! MyTableViewCCell
        
        let items : ChatModel2
        
        items = chatList2[indexPath.row]
        cell.nameTitle2.text = items.name
        cell.mainTitle2.text = items.title
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //정보 전달 : indexPath.row
        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatResearchDetail") as? ChatResearchDetail else { return }
        
        homeVC.yEmail = self.yEmail
        
          self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
