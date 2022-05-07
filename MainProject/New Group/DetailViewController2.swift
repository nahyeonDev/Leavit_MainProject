//
//  ViewController2.swift
//  test3
//
//  Created by 신예진 on 2021/11/30.
//

import UIKit
import Firebase
import FirebaseDatabase

class DetailViewController2: UIViewController {

    @IBOutlet weak var fixedBar_top: UIView!
    @IBOutlet weak var fixedBar_bottom: UIView!
    
    @IBOutlet weak var careerView1: UIView!
    @IBOutlet weak var careerView2: UIView!
    @IBOutlet weak var careerView3: UIView!
    
    
    @IBOutlet weak var reviewView1: UIView!
    @IBOutlet weak var reviewView2: UIView!
    
    @IBOutlet weak var nameTitle: UITextField!
    @IBOutlet weak var genNumTitle: UILabel!
    @IBOutlet weak var hashTag1: UITextField!
    @IBOutlet weak var hashTag2: UITextField!
    @IBOutlet weak var hashTag3: UITextField!
    
    @IBOutlet weak var locTxt: UITextField!
    @IBOutlet weak var dayTxt: UITextField!
    @IBOutlet weak var timeTxt: UITextField!
    
    @IBOutlet weak var detailTxt: UITextView!
    @IBOutlet weak var locationTxt: UITextField!
    
    @IBOutlet weak var jobTxt: UITextField!
    @IBOutlet weak var dayNumText: UITextField!
    @IBOutlet weak var dayText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    
    @IBOutlet weak var careerTitle1: UITextField!
    @IBOutlet weak var carTimeTitle: UITextField!
    @IBOutlet weak var carWorkTitle: UITextField!
    
    @IBOutlet weak var careerTitle2: UITextField!
    @IBOutlet weak var carTimeTitle2: UITextField!
    @IBOutlet weak var carWorkTitle2: UITextField!
    
    var userId2: String? //유저 아이디
    var detailSearch: DatabaseReference!
    var detailList2 = [DetailModel2]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fixedBar_top.layer.shadowOpacity = 0.1
        self.fixedBar_top.layer.shadowColor = UIColor.black.cgColor
        self.fixedBar_top.layer.shadowRadius = 10
        self.fixedBar_top.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.fixedBar_bottom.layer.shadowOpacity = 0.1
        self.fixedBar_bottom.layer.shadowColor = UIColor.black.cgColor
        self.fixedBar_bottom.layer.shadowRadius = 10
        self.fixedBar_bottom.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.careerView1.layer.cornerRadius = 10
        self.careerView1.layer.shadowOpacity = 0.1
        self.careerView1.layer.shadowColor = UIColor.black.cgColor
        self.careerView1.layer.shadowRadius = 10
        self.careerView1.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.careerView2.layer.cornerRadius = 10
        self.careerView2.layer.shadowOpacity = 0.1
        self.careerView2.layer.shadowColor = UIColor.black.cgColor
        self.careerView2.layer.shadowRadius = 10
        self.careerView2.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.careerView3.layer.cornerRadius = 10
        self.careerView3.layer.shadowOpacity = 0.1
        self.careerView3.layer.shadowColor = UIColor.black.cgColor
        self.careerView3.layer.shadowRadius = 10
        self.careerView3.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        self.reviewView1.layer.cornerRadius = 10
        self.reviewView1.layer.shadowOpacity = 0.1
        self.reviewView1.layer.shadowColor = UIColor.black.cgColor
        self.reviewView1.layer.shadowRadius = 10
        self.reviewView1.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.reviewView2.layer.cornerRadius = 10
        self.reviewView2.layer.shadowOpacity = 0.1
        self.reviewView2.layer.shadowColor = UIColor.black.cgColor
        self.reviewView2.layer.shadowRadius = 10
        self.reviewView2.layer.shadowOffset = CGSize(width: 0, height: 0)
        // Do any additional setup after loading the view.
        
        detailSearch = Database.database().reference().child("구직글작성")
        detailSearch.child(userId2!).observe(.value) {
                    snapshot in
            let value = snapshot.value as! [String: AnyObject]
                    let name = value["이름"] as! String
                    let job = value["가능업무"] as! String
                    let gen = value["성별나이"] as! String
                    let loc = value["근무가능위치"] as! String
                    let day = value["근무요일"] as! String
                    let time = value["근무시간"] as! String
                    let detail = value["자기소개"] as! String
                    let career = value["경력"] as! String
                    let certif = value["자격증"] as! String
                    let tag1 = value["태그1"] as! String
                    let tag2 = value["태그2"] as! String
                    let tag3 = value["태그3"] as! String
            
            let items = DetailModel2(name: name as String?, job: job as String?, gen: gen as String?, loc: loc as String?, day: day as String?,  time: time as String?, detail: detail as String?, career: career as String?, certif: certif as String?, tag1: tag1 as String?, tag2:tag2 as String?, tag3: tag3 as String?)
            
            self.detailList2.append(items)
            
            self.nameTitle.text = items.name
            self.genNumTitle.text = items.gen
            self.locTxt.text = items.loc
            self.dayTxt.text = items.day
            self.timeTxt.text = items.time
            
            self.detailTxt.text = items.detail
            
            self.locationTxt.text = items.loc
            
            self.hashTag1.text = items.tag1
            self.hashTag2.text = items.tag2
            self.hashTag3.text = items.tag3
            
            self.jobTxt.text = items.job
            self.dayText.text = items.day
            
            if(self.dayText.text!.count > 1){
                self.dayNumText.text = "하루이상"
            }else{
                self.dayNumText.text = "하루"
            }
            self.timeText.text = items.time
            
            if(items.career!.contains("+")){
                let CareerArr = items.career!.split(separator: "+")
                let fullCareerArr1 = CareerArr[0].split(separator: ",")
                let fullCareerArr2 = CareerArr[1].split(separator: ",")
                
                self.careerTitle1.text = String(fullCareerArr1[0])
                self.carTimeTitle.text = String(fullCareerArr1[1])
                self.carWorkTitle.text = String(fullCareerArr1[2])
                self.careerTitle2.text = String(fullCareerArr2[0])
                self.carTimeTitle2.text = String(fullCareerArr2[1])
                self.carWorkTitle2.text = String(fullCareerArr2[2])
            }
            else{
                let fullCareerArr1 = items.career!.split(separator: ",")
                self.careerTitle1.text = String(fullCareerArr1[0])
                self.carTimeTitle.text = String(fullCareerArr1[1])
                self.carWorkTitle.text = String(fullCareerArr1[2])
            }
            
        }
    }

    @IBAction func delPage(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        if let user = userId2 {
            self.userId2 = user
        }
    }
    
    //segue가 진행되기전에 준비하는 함수
        //DetailProposal에게 데이터 넘긴다
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if segue.identifier == "detailSub" {
                let vc = segue.destination as? DetailProposal
                vc?.userId = userId2
            }
        }

}
