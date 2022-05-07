//
//  FirstVC.swift
//  MainProject
//
//  Created by 신예진 on 2021/12/04.
//

import Foundation
import UIKit

class ScrapSecondVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var scrapTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CSFirstVC - viewDidLoad() called")
        
        self.scrapTableView?.delegate = self
        self.scrapTableView.dataSource = self
        self.scrapTableView.allowsSelection = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        106.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrapTableViewCell") as! ScrapTableViewCell
        
        return cell
    }
}
