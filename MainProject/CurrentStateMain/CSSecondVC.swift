//
//  SecondVC.swift
//  MainProject
//
//  Created by 신예진 on 2021/12/04.
//

import Foundation
import UIKit

class CSSecondVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var csTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CSSecondVC - viewDidLoad() called")
        
        self.csTableView.delegate = self
        self.csTableView.dataSource = self
        self.csTableView.allowsSelection = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CSMyTableViewCell") as! CSMyTableViewCell
        
        return cell
    }
}
