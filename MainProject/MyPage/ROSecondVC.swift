//
//  FirstVC.swift
//  MainProject
//
//  Created by 신예진 on 2021/12/04.
//

import Foundation
import UIKit

class ROSecondVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var roTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CSFirstVC - viewDidLoad() called")
        
        self.roTableView.delegate = self
        self.roTableView.dataSource = self
        self.roTableView.allowsSelection = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ROTableViewCell") as! ROTableViewCell
        
        return cell
    }
}
