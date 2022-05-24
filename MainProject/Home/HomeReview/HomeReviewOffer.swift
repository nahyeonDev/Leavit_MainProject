//
//  HomeReviewOffer.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/14.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeReviewOffer: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBOutlet weak var reBtn1: UIButton!
    @IBOutlet weak var reBtn2: UIButton!
    @IBOutlet weak var reBtn3: UIButton!
    @IBOutlet weak var reBtn4: UIButton!
    @IBOutlet weak var reBtn5: UIButton!
    @IBOutlet weak var reBtn6: UIButton!
    @IBOutlet weak var reBtn7: UIButton!
    @IBOutlet weak var reBtn8: UIButton!
    
    @IBOutlet weak var finBtn: UIButton!
    
    var starNum : String?
    
    var check = false
    var check2 = [0,0,0,0,0,0,0,0]
    
    var ref : DatabaseReference!
    let mEmail = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        finBtn.isEnabled = false
    }
    
    @IBAction func checkStar1(_ sender: UIButton) {
        if(check == false){
            star1.image("ejredStar.png")
            star2.image("ejgrayStar.png")
            star3.image("ejgrayStar.png")
            star4.image("ejgrayStar.png")
            star5.image("ejgrayStar.png")
            starNum = "1"
            scoreLabel.text = "1.0점 별로에요."
            check = true
            finBtn.image("wj2nextBtn.png")
            finBtn.isEnabled = false
        }
        else{
            star1.image("ejgrayStar.png")
            star2.image("ejgrayStar.png")
            star3.image("ejgrayStar.png")
            star4.image("ejgrayStar.png")
            star5.image("ejgrayStar.png")
            starNum = "0"
            scoreLabel.text = "0.0점 최악이에요."
            check = false
            finBtn.image("reReviewBtn.png")
            finBtn.isEnabled = true
        }
    }
    @IBAction func checkStar2(_ sender: UIButton) {
        star1.image("ejredStar.png")
        star2.image("ejredStar.png")
        star3.image("ejgrayStar.png")
        star4.image("ejgrayStar.png")
        star5.image("ejgrayStar.png")
        scoreLabel.text = "2.0점 그저그래요."
        starNum = "2"
        finBtn.image("wj2nextBtn.png")
        finBtn.isEnabled = true
    }
    @IBAction func checkStar3(_ sender: UIButton) {
        star1.image("ejredStar.png")
        star2.image("ejredStar.png")
        star3.image("ejredStar.png")
        star4.image("ejgrayStar.png")
        star5.image("ejgrayStar.png")
        scoreLabel.text = "3.0점 보통이에요."
        starNum = "3"
        finBtn.image("wj2nextBtn.png")
        finBtn.isEnabled = true
    }
    @IBAction func checkStar4(_ sender: UIButton) {
        star1.image("ejredStar.png")
        star2.image("ejredStar.png")
        star3.image("ejredStar.png")
        star4.image("ejredStar.png")
        star5.image("ejgrayStar.png")
        scoreLabel.text = "4.0점 좋아요!"
        starNum = "4"
        finBtn.image("wj2nextBtn.png")
        finBtn.isEnabled = true
    }
    @IBAction func checkStar5(_ sender: UIButton) {
        star1.image("ejredStar.png")
        star2.image("ejredStar.png")
        star3.image("ejredStar.png")
        star4.image("ejredStar.png")
        star5.image("ejredStar.png")
        scoreLabel.text = "5.0점 정말좋아요!"
        starNum = "5"
        finBtn.image("wj2nextBtn.png")
        finBtn.isEnabled = true
    }
    
    @IBAction func checkBtn1(_ sender: UIButton) {
        if(check2[0] == 0){
            reBtn1.setImage(UIImage(named: "ekjlikeCBtn1.png"), for: .normal)
            check2[0] = 1
            finBtn.image("wj2nextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            reBtn1.setImage(UIImage(named: "ekjlikeBtn1.png"), for: .normal)
            check2[0] = 0
        }
    }
    
    @IBAction func checkBtn2(_ sender: UIButton){
        if(check2[1] == 0){
            reBtn2.setImage(UIImage(named: "ekjlikeCBtn2.png"), for: .normal)
            check2[1] = 1
            finBtn.image("wj2nextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            reBtn2.setImage(UIImage(named: "ekjlikeBtn2.png"), for: .normal)
            check2[1] = 0
        }
        
    }
    @IBAction func checkBtn3(_ sender: UIButton){
        if(check2[2] == 0){
            reBtn3.setImage(UIImage(named: "ekjlikeCBtn3.png"), for: .normal)
            check2[2] = 1
            finBtn.image("wj2nextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            reBtn3.setImage(UIImage(named: "ekjlikeBtn3.png"), for: .normal)
            check2[2] = 0
        }
        
    }
    @IBAction func checkBtn4(_ sender: UIButton){
        if(check2[3] == 0){
            reBtn4.setImage(UIImage(named: "ekjlikeCBtn4.png"), for: .normal)
            check2[3] = 1
            finBtn.image("wj2nextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            reBtn4.setImage(UIImage(named: "ekjlikeBtn4.png"), for: .normal)
            check2[3] = 0
        }
        
    }
    @IBAction func checkBtn5(_ sender: UIButton){
        if(check2[4] == 0){
            reBtn5.setImage(UIImage(named: "ekjlikeCBtn5.png"), for: .normal)
            check2[4] = 1
            finBtn.image("wj2nextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            reBtn5.setImage(UIImage(named: "ekjlikeBtn5.png"), for: .normal)
            check2[4] = 0
        }
        
    }
    @IBAction func checkBtn6(_ sender: UIButton){
        if(check2[5] == 0){
            reBtn6.setImage(UIImage(named: "ekjlikeCBtn6.png"), for: .normal)
            check2[5] = 1
            finBtn.image("wj2nextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            reBtn6.setImage(UIImage(named: "ekjlikeBtn6.png"), for: .normal)
            check2[5] = 0
        }
        
    }
    @IBAction func checkBtn7(_ sender: UIButton){
        if(check2[6] == 0){
            reBtn7.setImage(UIImage(named: "ekjlikeCBtn7.png"), for: .normal)
            check2[6] = 1
            finBtn.image("wj2nextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            reBtn7.setImage(UIImage(named: "ekjlikeBtn7.png"), for: .normal)
            check2[6] = 0
        }
        
    }
    @IBAction func checkBtn8(_ sender: UIButton){
        if(check2[7] == 0){
            reBtn8.setImage(UIImage(named: "ekjlikeCBtn8.png"), for: .normal)
            check2[7] = 1
            finBtn.image("wj2nextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            reBtn8.setImage(UIImage(named: "ekjlikeBtn8.png"), for: .normal)
            check2[7] = 0
        }
    }

    @IBAction func finPage(_ sender: UIButton) {
        let email = mEmail!.components(separatedBy: ["@", "."]).joined()
        
        ref = Database.database().reference().child("MainIng").child("offer").child(email).child("post")
        ref.updateChildValues(["구인리뷰": "yes"])
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }

}
