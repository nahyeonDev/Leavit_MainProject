//
//  JobLocation_jobsearchwrite.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/16.
//

import UIKit

class JobLocation_jobsearchwrite: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var topView_l: UIView!
    
    //뒤로 가기
    @IBOutlet weak var backBtn: UIButton!
    //완료 버튼
    @IBOutlet weak var finBtn: UIButton!
    
    let arr: [String] = ["서울"]
    let arr2: [String] = ["전체","노원구"]
    let arr3: [String] = ["월계1동","월계2동","월계3동","공릉1동","공릉2동","하계1동","하계2동","중계본동","중계1동","중계4동","중계2,3동","상계1동","상계2동","상계3,4동","상계5동","상계6,7동","상계8동","상계9동","상계10동"]
    
    var locTxt1 : String = "" //시도
    var locTxt2 : String = "" //구군
    var locTxt3 : String = "" //동읍면
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableView3: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView2.isHidden = true
        
        tableView3.delegate = self
        tableView3.dataSource = self
        tableView3.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView3.isHidden = true
        
        finBtn.isEnabled = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1{
            return arr.count
        }
        if tableView == tableView2{
            return arr2.count
        }
        if tableView == tableView3{
            return arr3.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if tableView == tableView1{
            cell.textLabel?.text = arr[indexPath.row]
        }
        else if tableView == tableView2{
            cell.textLabel?.text = arr2[indexPath.row]
            
        }
        else if tableView == tableView3{
            cell.textLabel?.text = arr3[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if tableView == tableView1{
            locTxt1 = arr[indexPath.row]
            tableView2.isHidden = false
        }
        if tableView == tableView2{
            locTxt2 = arr2[indexPath.row]
            tableView3.isHidden = false
        }
        if tableView == tableView3{
            locTxt3 = arr3[indexPath.row]
            finBtn.setImage(UIImage(named: "wj2nextBtn.png"), for: .normal)
            finBtn.isEnabled = true
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func finAction(_ sender: Any) {
        let preVC = self.presentingViewController
        var location = ""
        guard let vc = preVC as? JobSearchWrite else {
            return
        }
        location = locTxt1 + "/" + locTxt2 + "/" + locTxt3
        vc.locationInfo = location
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
