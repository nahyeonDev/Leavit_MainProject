//
//  TutorialView.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/05.
//

import UIKit

class TutorialView: UIViewController{
  
    var images = ["tutorialConPic1.png","tutorialConPic2.png","tutorialConPic3.png","tutorialConPic4.png"]
    var subText = ["내게 딱 맞는 일자리, 태그 검색으로","내게 딱 맞는 대타, 키워드 검색으로","일자리 또는 대타 모두 원클릭 지원으로","학생증 인증을 통해 신뢰성 확보"]
    
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var titleImgView: UIImageView!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var pageCnt: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var startBtn: UIButton!
    var cnt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //페이지 컨트롤의 전체 페이지를 images 배열의 전체 개수 값으로 설정
        pageControl.numberOfPages = images.count
        // 페이지 컨트롤의 현재 페이지를 0으로 설정
        pageControl.currentPage = 0
        // 페이지 표시 색상을 밝은 회색 설정
        pageControl.pageIndicatorTintColor = UIColor.lightGray

        mainImgView.image = UIImage(named: images[0])
        
        startBtn.isHidden = true
    }
    // 페이지가 변하면 호출됨
    @IBAction func pageChanged(_ sender: UIPageControl) {
        
        // images라는 배열에서 pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imgView에 할당
        mainImgView.image = UIImage(named: images[pageControl.currentPage])
        
        ChangePage(num: pageControl.currentPage)
    }
    @IBAction func touchSkip(_ sender: UIButton) {
        ChangePage(num: 4)
    }
    @IBAction func touchNext(_ sender: UIButton) {
        if(cnt == 0){
            ChangePage(num: 0)
            cnt += 1
        }
        else if(cnt == 1){
            ChangePage(num: 1)
            cnt += 1
        }
        else if(cnt == 2){
            ChangePage(num: 2)
            cnt += 1
        }
        else{
            ChangePage(num: 3)
            cnt += 1
        }
    }
    
    func ChangePage(num:Int){
        if(num == 0){
            titleImgView.image("tutorialMainText1.png")
            mainImgView.image = UIImage(named: images[0])
            subTitle.text = subText[0]
            pageCnt.text = "1/4"
            pageControl.currentPage = 0
            startBtn.isHidden = true
        }
        else if(num == 1){
            titleImgView.image("tutorialMainText2.png")
            mainImgView.image = UIImage(named: images[1])
            subTitle.text = subText[1]
            pageCnt.text = "2/4"
            pageControl.currentPage = 1
            startBtn.isHidden = true
        }
        else if(num == 2){
            titleImgView.image("tutorialMainText3.png")
            mainImgView.image = UIImage(named: images[2])
            subTitle.text = subText[2]
            pageCnt.text = "3/4"
            pageControl.currentPage = 2
            startBtn.isHidden = true
        }
        else{
            titleImgView.image("tutorialMainText4.png")
            mainImgView.image = UIImage(named: images[3])
            subTitle.text = subText[3]
            pageCnt.text = "4/4"
            pageControl.currentPage = 3
            startBtn.isHidden = false
        }
    }
    

}
