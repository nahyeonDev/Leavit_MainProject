//
//  item2ViewController.swift
//  MainProject
//
//  Created by 김나현 on 2021/12/07.
//

import UIKit
import Firebase
import FirebaseDatabase

class item2ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var itemOffer: DatabaseReference!
    
    @IBOutlet weak var myTableView2: UITableView!
    
    var itemList = [ItemModel]()
    var userList = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 대리자 위임
        myTableView2.delegate = self
        myTableView2.dataSource = self
        
        itemOffer = Database.database().reference().child("구인리스트")
        
        itemOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.itemList.removeAll()
                
                for 구인리스트 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = 구인리스트.value as? [String: AnyObject]
                    
                    let obTitle = itemObjects?["글제목"]
                    let obTime = itemObjects?["근무요일시간"]
                    let obMoney = itemObjects?["지급요금"]
                    let obTag1 = itemObjects?["태그1"]
                    let obTag2 = itemObjects?["태그2"]
                    let obTag3 = itemObjects?["태그3"]
                    
                    let items = ItemModel(title: obTitle as! String?, time: obTime as! String?, money: obMoney as! String?, tag1: obTag1 as! String?, tag2: obTag2 as! String?, tag3: obTag3 as! String?)
                    
                    self.itemList.append(items)
                }
                self.myTableView2.reloadData()
            }
            
        })
        itemOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.userList.removeAll()
                
                for 구인리스트 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = 구인리스트.value as? [String: AnyObject]

                    let list = itemObjects?["리스트연결"]
                    
                    let items = UserModel(uid: list as! String?)
                    
                    self.userList.append(items)
                }
                //self.myTableView2.reloadData()
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
        let cell: item2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "item2TableViewCell", for: indexPath) as! item2TableViewCell
        let items: ItemModel
        let uitems: UserModel
        
        items = itemList[indexPath.row]
        uitems = userList[indexPath.row]
        cell.title.text = items.title
        cell.time.text = items.time
        cell.money.text = items.money
        cell.tagTxt1.text = items.tag1
        cell.tagTxt2.text = items.tag2
        cell.tagTxt3.text = items.tag3
        cell.user.text = uitems.uid
        
        // 생성한 Cell 리턴
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //정보 전달 : indexPath.row
        guard let contVC2 = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        contVC2.userId = userList[indexPath.row].uid
        self.navigationController?.pushViewController(contVC2, animated: true)
    }
}
