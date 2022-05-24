//
//  HomeReAla.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/08.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class HomeReAla: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var itemOffer: DatabaseReference!
    var itemSearch: DatabaseReference!
    var ref: DatabaseReference!
    @IBOutlet weak var myTableView: UITableView!
    
    var itemList = [AlarmModel1]()
    
    let email = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
        
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainT = "Offer" + email1
        
        itemOffer = Database.database().reference().child("Support글지원").child(email1).child(mainT)
        
        itemOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.itemList.removeAll()
                
                for Support글지원 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = Support글지원.value as? [String: AnyObject]
                    
                    let obTitle = itemObjects?["글제목"]
                    let obName = itemObjects?["지원자이름"]
                    
                    let items = AlarmModel1(title: obTitle as! String?, name: obName as! String?)
                    
                    self.itemList.append(items)
                }
                self.myTableView.reloadData()
            }
            
        })
    }
    /// 필수 함수 구현
    // 한 섹션(구분)에 몇 개의 셀을 표시할지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    // 특정 row에 표시할 cell 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 내가 정의한 Cell 만들기
        let cell: ReAlaCell = tableView.dequeueReusableCell(withIdentifier: "ReAlaCell", for: indexPath) as! ReAlaCell
        let items: AlarmModel1
        
        items = itemList[indexPath.row]

        cell.mainTitle.text = items.title
        cell.nameTitle.text = items.name
        
        // 생성한 Cell 리턴
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //정보 전달 : indexPath.row
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        ref = Database.database().reference().child("MainIng").child("offer").child(email1).child("post")
        ref.updateChildValues(["알람완료": "yes"])
        
        itemOffer = Database.database().reference().child("MainIng").child("offer").child(email1)
        
        itemOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                for MainIng in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = MainIng.value as? [String: AnyObject]
                    
                    let obuser = itemObjects?["지원자이메일"] as! String
                    
                    let email2 = obuser.components(separatedBy: ["@", "."]).joined()
                    
                    print(email2)
                    
                    self.itemSearch = Database.database().reference().child("MainIng").child("search").child(email2).child("post")
                    
                    self.itemSearch.updateChildValues(["지원성공": "o"])
                }
            }
            
        })
    }
}
