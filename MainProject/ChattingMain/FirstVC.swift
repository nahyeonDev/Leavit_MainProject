//
//  FirstVC.swift
//  MainProject
//
//  Created by 신예진 on 2021/12/04.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class FirstVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var chatResearch: DatabaseReference!
    
    var chatList = [ChatModel]()
    let email = FirebaseAuth.Auth.auth().currentUser?.email
    
    var yEmail : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FirstVC - viewDidLoad() called")
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.allowsSelection = true
        
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainL = "ResearchMessage" + email1
        
        chatResearch = Database.database().reference().child("ChatSet").child(email1).child(mainL)
        chatResearch.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.chatList.removeAll()
                
                for email1 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = email1.value as? [String: AnyObject]
                    let obName = itemObjects?["상대방이름"]
                    let obTitle = itemObjects?["지원글제목"]
                    let obEmail = itemObjects?["상대방이메일"]
                    
                    let items = ChatModel(name: obName as! String?, title: obTitle as! String?)
                    
                    self.yEmail = obEmail as! String?
                    
                    self.chatList.append(items)
                }
                self.myTableView.reloadData()
              }
        })
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell
        
        let items : ChatModel
        
        items = chatList[indexPath.row]
        cell.nameTitle.text = items.name
        cell.mainTitle.text = items.title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //정보 전달 : indexPath.row
        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatOfferDetail") as? ChatOfferDetail else { return }
        
        homeVC.yEmail = self.yEmail
        
          self.navigationController?.pushViewController(homeVC, animated: true)
    }

}
