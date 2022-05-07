//
//  HomeOfferDetail.swift
//  MainProject
//
//  Created by 김나현 on 2021/12/09.
//

import UIKit

class HomeOfferDetail: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tagTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 대리자 위임
        tagTableView.delegate = self
        tagTableView.dataSource = self
    }
    
    /// 필수 함수 구현
    // 한 섹션(구분)에 몇 개의 셀을 표시할지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2// 한 개의 섹션당 10개의 셀을 표시하겠다
    }
    
    // 특정 row에 표시할 cell 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 내가 정의한 Cell 만들기
        let cell: tagTableViewCell1 = tableView.dequeueReusableCell(withIdentifier: "tagTableViewCell1", for: indexPath) as! tagTableViewCell1
        // Cell Label의 내용 지정
//        cell.myLabel.text = data[indexPath.row]
        
        // 생성한 Cell 리턴
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
