//
//  FirstVC.swift
//  MainProject
//
//  Created by 신예진 on 2021/12/04.
//

import Foundation
import UIKit

class JSLSecondVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var jslTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CSFirstVC - viewDidLoad() called")
        
        self.jslTableView.delegate = self
        self.jslTableView.dataSource = self
        self.jslTableView.allowsSelection = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JSLTableViewCell") as! JSLTableViewCell
        
        return cell
    }
}
