//
//  EmployContract_Search.swift
//  MainProject
//
//  Created by 신예진 on 2022/04/27.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class EmployContract_Search: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView2: UITableView!
    var itemResearch = [OfContModel2]()
    
    let email = Auth.auth().currentUser?.email
    var itemReContract: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 대리자 위임
        myTableView2.delegate = self
        myTableView2.dataSource = self
        
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainT = "research" + email1
        
        itemReContract = Database.database().reference().child("근로계약리스트").child(mainT)
        itemReContract.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.itemResearch.removeAll()
                
                for mainT in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects2 = mainT.value as? [String: AnyObject]
                    let obTitle = itemObjects2?["글제목"]
                    let obOfName = itemObjects2?["구인자이름"]
                    let obReName = itemObjects2?["구직자이름"]
                    let obOfPho = itemObjects2?["구인자연락처"]
                    let obRePho = itemObjects2?["구직자연락처"]
                    
                    let items = OfContModel2(title: obTitle as! String?, ofname: obOfName as! String?, rename: obReName as! String?, ofphone: obOfPho as! String?, rephone: obRePho as! String?)
                    
                    self.itemResearch.append(items)
                }
                self.myTableView2.reloadData()
            }
            
        })
    }
    
    /// 필수 함수 구현
    // 한 섹션(구분)에 몇 개의 셀을 표시할지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemResearch.count
    }
    
    // 특정 row에 표시할 cell 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 내가 정의한 Cell 만들기
        let cell: EmployContractTableViewCell2 = tableView.dequeueReusableCell(withIdentifier: "EmployContractTableViewCell2", for: indexPath) as! EmployContractTableViewCell2
        let items: OfContModel2
        
        items = itemResearch[indexPath.row]
        cell.mainTitle2.text = items.title
        cell.ofNameTitle2.text = items.ofname
        cell.reNameTitle2.text = items.rename
        cell.ofPhone2.text = items.ofphone
        cell.rePhone2.text = items.rephone

        return cell
        //커밋 확인용
    }


}
