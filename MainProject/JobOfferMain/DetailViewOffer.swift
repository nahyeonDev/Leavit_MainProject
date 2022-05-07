//
//  DetailViewOffer.swift
//  MainProject
//
//  Created by 김나현 on 2021/12/15.
//

import UIKit

import UIKit
import FSPagerView



class DetailViewOffer: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    fileprivate let imageNames = ["1.png", "2.png", "3.png", "4.png"]
    
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
    @IBOutlet weak var hashTag4: UITextField!
    
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewView2: UIView!

    //글제목
    @IBOutlet weak var mainTitle: UITextField!
    var mTitle: String?
    
    //간단 아이콘 밑의 글
    //시급, 날짜, 시간
    @IBOutlet weak var payTitle: UITextField!
    @IBOutlet weak var dayTitle: UITextField!
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
    //근무요일
    @IBOutlet weak var dayTxt: UITextField!
    //근무시간
    @IBOutlet weak var timeTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self

        self.detailView.layer.cornerRadius = 20
        
        self.hashTag1.layer.cornerRadius = 30
        self.hashTag2.layer.cornerRadius = 30
        self.hashTag3.layer.cornerRadius = 30
        self.hashTag4.layer.cornerRadius = 30
        
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
        
        mainTitle.text = title
        detailTxt.text = dTxt
        jobTxt.text = jTxt
        
        let str = totalTxt
        splitArr = str!.components(separatedBy: ",")
        
        dayTxt.text = splitArr?[0]
        timeTxt.text = splitArr?[1]
        payTxt.text = splitArr?[3]
        
        payTitle.text = splitArr?[3]
        timeTitle.text = splitArr?[1]
        dayTitle.text = splitArr?[0]

        
    }
    

    @IBAction func clickFin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
}
