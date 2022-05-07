//
//  SearchingViewController.swift
//  MainProject
//
//  Created by 박연주 on 2021/11/30.
//

import UIKit

class SearchingViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var contain1: UIView!
    
    @IBOutlet weak var contain2: UIView!
    
    @IBOutlet weak var slideBar: UIButton!
    //리빗메이트, 대타일 구하기
    @IBOutlet weak var libitText: UIButton!
    @IBOutlet weak var offerText: UIButton!
    //키워드뷰
    @IBOutlet weak var keyView: UIView!
    //글 작성 버튼
    @IBOutlet weak var writeBtn: UIButton!
    
    @IBOutlet weak var mapBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contain2.isHidden = true
        
        writeBtn.addTarget(self, action: #selector(goAlert), for: .touchUpInside)
    }
    
    //디폴트로 배치되는 뒤로가기 버튼 삭제
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func clickSearchBtn(_ sender: Any) {
        topView.backgroundColor = UIColor(displayP3Red: 254/255, green: 111/255, blue: 97/255, alpha: 1)
        contain1.isHidden = false
        contain2.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            self.slideBar.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        slideBar.setImage(UIImage(named: "selected.png"), for: .normal)
        libitText.setTitleColor(.black, for: .normal)
        offerText.setTitleColor(.lightGray, for: .normal)
        keyView.backgroundColor = UIColor(displayP3Red: 255/255, green: 90/255, blue: 96/255, alpha: 0.05)
        writeBtn.setImage(UIImage(named: "sWriteRedBtn.png"), for: .normal)
    }
    
    @IBAction func clickOfferBtn(_ sender: Any) {
        topView.backgroundColor = UIColor(displayP3Red: 139/255, green: 66/255, blue: 255/255, alpha: 1)
        contain1.isHidden = true
        contain2.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.slideBar.transform = CGAffineTransform(translationX: 196, y: 0)
        })
        slideBar.setImage(UIImage(named: "selected2.png"), for: .normal)
        libitText.setTitleColor(.lightGray, for: .normal)
        offerText.setTitleColor(.black, for: .normal)
        keyView.backgroundColor = UIColor(displayP3Red: 139/255, green: 64/255, blue: 255/255, alpha: 0.05)
        writeBtn.setImage(UIImage(named: "sWritePurpleBtn.png"), for: .normal)
    }
    @objc func goAlert(){
            let alert = self.storyboard?.instantiateViewController(withIdentifier: "SearchAlterView") as! SearchAlterView
            alert.modalPresentationStyle = .overCurrentContext
            alert.modalTransitionStyle = .crossDissolve
            present(alert, animated: false, completion: nil)
    }
    
    //커밋
    /*
    @IBAction func workTypeBtn(_ sender: UIButton) {
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "jobType")
        vcName?.modalPresentationStyle = .overFullScreen //전체화면으로 보이게 설정
        vcName?.modalTransitionStyle = .coverVertical //전환 애니메이션 설정
                self.present(vcName!, animated: true, completion: nil)
        //커밋
        /*
         if (self.children.count == 0) {
             let modal = self.storyboard?.instantiateViewController(withIdentifier: "jobType")
             self addChildViewControllers
                 [self addChildViewController:self.modal]
                 self.modal.view.frame = CGRectMake(0, 568, 320, 284)
                 [self.view addSubview:self.modal.view];
                 [UIView animateWithDuration:1 animations:^{
                     self.modal.view.frame = CGRectMake(0, 284, 320, 284);;
                 } completion:^(BOOL finished) {
                     [self.modal didMoveToParentViewController:self];
                 }];
             }else{
                 [UIView animateWithDuration:1 animations:^{
                     self.modal.view.frame = CGRectMake(0, 568, 320, 284);
                 } completion:^(BOOL finished) {
                     [self.modal.view removeFromSuperview];
                     [self.modal removeFromParentViewController];
                     self.modal = nil;
                 }];
             }*/
        
    }
    */
    
    @IBAction func goMapView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
