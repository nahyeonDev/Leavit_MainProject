//
//  ViewController.swift
//  test3
//
//  Created by 신예진 on 2021/11/22.
//

import UIKit
import FSPagerView
import Firebase
import FirebaseDatabase
import FirebaseFirestore


class DetailViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    fileprivate let imageNames = ["1.png", "2.png", "3.png", "4.png"]
    @IBOutlet weak var deletePage: UIButton!
    
    @IBOutlet weak var myPagerView: FSPagerView!{
        didSet{
            // 페이저뷰에 쎌을 등록한다.
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            // 아이템 크기 설정
            self.myPagerView.itemSize = FSPagerView.automaticSize
            // 무한스크롤 설정
            self.myPagerView.isInfinite = true
            // 자동 스크롤
            self.myPagerView.automaticSlidingInterval = 4.0
               }
    }
    
    @IBOutlet weak var myPageControl: FSPageControl!{
        didSet{
            self.myPageControl.numberOfPages = self.imageNames.count  //PageControl 점 갯수를 몇개로 해줄 것이냐
            self.myPageControl.contentHorizontalAlignment = .center
            self.myPageControl.itemSpacing = 10
            self.myPageControl.interitemSpacing = 10
        }
    }
    

    @IBOutlet weak var detailView: UIView!

    
    @IBOutlet weak var hashTag1: UITextField!
    @IBOutlet weak var hashTag2: UITextField!
    @IBOutlet weak var hashTag3: UITextField!
    
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewView2: UIView!

    //글제목
    @IBOutlet weak var mainTitle: UITextField!
    var mTitle: String?
    
    //간단 아이콘 밑의 글
    //시급, 날짜, 시간
    @IBOutlet weak var payTitle: UITextField!
    @IBOutlet weak var dayTitle: UITextField!
    @IBOutlet weak var dayNumTitle: UITextField!//하루,장기
    @IBOutlet weak var timeTitle: UITextField!
    
    //상세글
    @IBOutlet weak var detailTxt: UITextView!
    var dTxt: String?
    //업직종
    @IBOutlet weak var jobTxt: UITextField!
    var jTxt: String?
    //근무정보 종합 받아오는 스트링
    var totalTxt: String?
    var splitArr: Array<String>?
    //급여
    @IBOutlet weak var payTxt: UITextField!
    var ptxt: String = ""
    var mtxt: String = ""
    //근무요일
    @IBOutlet weak var dayTxt: UITextField!
    //근무시간
    @IBOutlet weak var timeTxt: UITextField!
    //근무기간
    @IBOutlet weak var dayNumTxt: UITextField!
    //위치 url
    @IBOutlet weak var urlText: UIButton!
    //자격증
    @IBOutlet weak var certificateTxt: UITextField!
    //경력
    @IBOutlet weak var careerTxt: UITextField!
    //이메일(내)
    @IBOutlet weak var myEmail: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    //태그
    var tagTotal: String?
    var splitArr2: Array<String>?
    
    var detailOffer: DatabaseReference!
    var detailList = [DetailModel]()
    
    var userId: String? //유저 아이디
    
    let db = Firestore.firestore()
    var ref: DatabaseReference!
    var userName1 : String?
    var userLoc1 : String?
    var userName2 : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self

        self.detailView.layer.cornerRadius = 20
        
        self.hashTag1.layer.cornerRadius = 30
        self.hashTag2.layer.cornerRadius = 30
        self.hashTag3.layer.cornerRadius = 30
        
        self.reviewView.layer.cornerRadius = 10
        self.reviewView.layer.shadowOpacity = 0.1
        self.reviewView.layer.shadowColor = UIColor.black.cgColor
        self.reviewView.layer.shadowRadius = 10
        self.reviewView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.reviewView2.layer.cornerRadius = 10
        self.reviewView2.layer.shadowOpacity = 0.1
        self.reviewView2.layer.shadowColor = UIColor.black.cgColor
        self.reviewView2.layer.shadowRadius = 10
        self.reviewView2.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        detailOffer = Database.database().reference().child("구인글작성")
        detailOffer.child(userId!).observe(.value) {
                    snapshot in
            let value = snapshot.value as! [String: AnyObject]
                    let name = value["글제목"] as! String
                    let method = value["지급방법"] as! String
                    let money = value["지급요금"] as! String
                    let day = value["근무요일"] as! String
                    let time = value["근무시간"] as! String
                    let detail = value["상세글"] as! String
                    let url = value["근무지"] as! String
                    let job = value["업직종"] as! String
                    let career = value["자격요건"] as! String
                    let certif = value["자격요건"] as! String
                    let tag1 = value["태그1"] as! String
                    let tag2 = value["태그2"] as! String
                    let tag3 = value["태그3"] as! String
                    let email = value["이메일"] as! String
            
            let items = DetailModel(title: name as String?, method: method as String?, money: money as String?, day: day as String?,  time: time as String?, detail: detail as String?, url:url as String?, job: job as String?, career: career as String?, certif: certif as String?, tag1: tag1 as String?, tag2:tag2 as String?, tag3: tag3 as String?)
            
            self.detailList.append(items)
            
            self.mainTitle.text = items.title
            self.payTitle.text = items.money
            self.dayTitle.text = items.day
            self.timeTitle.text = items.time
            
            self.detailTxt.text = items.detail
            
            self.urlText.setTitle(items.url, for: .normal)
            self.careerTxt.text = items.career
            self.certificateTxt.text = items.certif
            
            self.ptxt = items.money!
            self.mtxt = items.method!
            self.payTxt.text = self.ptxt + self.mtxt
            self.jobTxt.text = items.job
            self.dayTxt.text = items.day
            self.timeTxt.text = items.time
            
            self.hashTag1.text = items.tag1
            self.hashTag2.text = items.tag2
            self.hashTag3.text = items.tag3
            
            self.myEmail.text = email
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        backBtn.addTarget(self, action: #selector(delPage(_:)), for:.touchUpInside)
    }
    @IBAction func delPage(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - FSPagerView Datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    //각 쎌에 대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
    
    // MARK: - FSPagerView delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }

    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    

    @IBAction func mapUrlBtn(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://m.place.naver.com/restaurant/34356181/home")!
                                  as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func offerChatting(_ sender: UIButton) {
        ref = Database.database().reference()
        
        //구직하는 입장(현재 사용자) ResearchMessage+이메일(현재사용자)
        let email = (FirebaseAuth.Auth.auth().currentUser?.email)
        let email1 = email!.components(separatedBy: ["@", "."]).joined()
        let mainL = "ResearchMessage" + email1
        print(mainL)
        let timel = dayTitle.text
        let timer = timeTitle.text
        let time = timel! + " " + timer!
        
        let docRef1 = db.collection("가입개인정보").document(myEmail.text!)
        
        docRef1.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName1 = dataDescription?["이름"] as! String
                self.userName2 = obName1
                
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("상대방이메일").setValue(self.myEmail.text!)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("상대방이름").setValue(self.userName2!)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("지원글제목").setValue(self.mainTitle.text!)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("글uid").setValue(self.userId!)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("지원글시급").setValue(self.payTitle.text!)
                self.ref.child("ChatSet").child(email1).child(mainL).child("chat").child("지원글기간").setValue(time)
 
            } else {
                print("Document does not exist")
            }
        }
        
        //구인하는 입장(글 작성자) OfferMessage+이메일(글 작성자)
        let email2 = myEmail.text!.components(separatedBy: ["@", "."]).joined()
        let mainR = "OfferMessage" + email2
        print(mainR)
        let docRef2 = db.collection("가입개인정보").document(email!)
        
        docRef2.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"] as! String
                let obLoc = dataDescription?["위치"] as! String
                self.userName1 = obName
                self.userLoc1 = obLoc
 
            } else {
                print("Document does not exist")
            }
        }

    }
    
    @IBAction func goSupportMain(_ sender: UIButton) {
        guard let contVC2 = self.storyboard?.instantiateViewController(withIdentifier: "DetailProposal2") as? DetailProposal2 else { return }
        contVC2.userId = userId
        contVC2.uTitle = mainTitle.text
        contVC2.email2 = myEmail.text
        self.navigationController?.pushViewController(contVC2, animated: true)
    }
    
}
