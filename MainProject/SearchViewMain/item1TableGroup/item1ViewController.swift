//
//  item1ViewController.swift
//  MainProject
//
//  Created by 김나현 on 2021/12/07.
//

import UIKit
import Firebase
import FirebaseDatabase

class item1ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var itemOffer2: DatabaseReference!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var itemList2 = [ItemModel2]()
    var userList2 = [UserModel2]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 대리자 위임
        myTableView.delegate = self
        myTableView.dataSource = self
        
        itemOffer2 = Database.database().reference().child("구직리스트")
        itemOffer2.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.itemList2.removeAll()
                
                for 구직리스트 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects2 = 구직리스트.value as? [String: AnyObject]
                    let obName = itemObjects2?["이름"]
                    let obGenNum = itemObjects2?["성별나이"]
                    let obTag1 = itemObjects2?["태그1"]
                    let obTag2 = itemObjects2?["태그2"]
                    let obTag3 = itemObjects2?["태그3"]
                    
                    let items = ItemModel2(name: obName as! String?, genNum: obGenNum as! String?, tag1: obTag1 as! String?, tag2: obTag2 as! String?, tag3: obTag3 as! String?)
                    
                    self.itemList2.append(items)
                }
                self.myTableView.reloadData()
            }
            
        })
        itemOffer2.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.userList2.removeAll()
                
                for 구직리스트 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = 구직리스트.value as? [String: AnyObject]

                    let list = itemObjects?["리스트연결"]
                    
                    let items = UserModel2(uid2: list as! String?)
                    
                    self.userList2.append(items)
                }
                //self.myTableView2.reloadData()
            }
            
        })
    
    }
    
    /// 필수 함수 구현
    // 한 섹션(구분)에 몇 개의 셀을 표시할지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList2.count
    }
    
    // 특정 row에 표시할 cell 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 내가 정의한 Cell 만들기
        let cell: item1TableViewCell = tableView.dequeueReusableCell(withIdentifier: "item1TableViewCell", for: indexPath) as! item1TableViewCell
        let items: ItemModel2
        let uitems: UserModel2
        
        items = itemList2[indexPath.row]
        uitems = userList2[indexPath.row]
        cell.nameTxt.text = items.name
        cell.genderTxt.text = items.genNum
        cell.tagTxt1.text = items.tag1
        cell.tagTxt2.text = items.tag2
        cell.tagTxt3.text = items.tag3
        cell.user.text = uitems.uid2

        return cell
        //커밋 확인용
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //정보 전달 : indexPath.row
        performSegue(withIdentifier: "detailView2", sender: indexPath.row)
    }
    
    //segue가 진행되기전에 준비하는 함수
        //DetailViewContorller에게 데이터 넘긴다
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if segue.identifier == "detailView2" {
                let vc = segue.destination as? DetailViewController2
                if let index = sender as? Int{
                    vc?.userId2 = userList2[index].uid2
                }
            }
        }


}
