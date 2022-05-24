//
//  HomeReviewSearch.swift
//  MainProject
//
//  Created by 김나현 on 2022/05/11.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeReviewSearch: UIViewController {

    var check = false
    
    @IBOutlet weak var scoreLabel: UILabel! //별 점수
    
    @IBOutlet weak var star1: UIButton! //별1
    @IBOutlet weak var star2: UIButton! //별2
    @IBOutlet weak var star3: UIButton! //별3
    @IBOutlet weak var star4: UIButton! //별4
    @IBOutlet weak var star5: UIButton! //별5
    var starNum : String?
    
    @IBOutlet weak var reviewTextfield: UITextView! //리뷰작성
    
    @IBOutlet weak var ofBtn1: UIButton!
    @IBOutlet weak var ofBtn2: UIButton!
    @IBOutlet weak var ofBtn3: UIButton!
    @IBOutlet weak var ofBtn4: UIButton!
    @IBOutlet weak var ofBtn5: UIButton!
    @IBOutlet weak var ofBtn6: UIButton!
    @IBOutlet weak var ofBtn7: UIButton!
    @IBOutlet weak var ofBtn8: UIButton!
    @IBOutlet weak var ofBtn9: UIButton!
    @IBOutlet weak var ofBtn10: UIButton!
    var check2 = [0,0,0,0,0,0,0,0,0,0]

    @IBOutlet weak var finBtn: UIButton!
    
    var ref : DatabaseReference!
    let mEmail = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        finBtn.isEnabled = false
    }
    
    @IBAction func clickStar1(_ sender: UIButton) {
        if(check == false){
            star1.image("ejpurpleStar.png")
            star2.image("ejgrayStar.png")
            star3.image("ejgrayStar.png")
            star4.image("ejgrayStar.png")
            star5.image("ejgrayStar.png")
            starNum = "1"
            scoreLabel.text = "1.0점 별로에요."
            check = true
            finBtn.image("wjnextBtn.png")
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
    @IBAction func clickStar2(_ sender: UIButton) {
        star1.image("ejpurpleStar.png")
        star2.image("ejpurpleStar.png")
        star3.image("ejgrayStar.png")
        star4.image("ejgrayStar.png")
        star5.image("ejgrayStar.png")
        scoreLabel.text = "2.0점 그저그래요."
        starNum = "2"
        finBtn.image("wjnextBtn.png")
        finBtn.isEnabled = true
    }
    @IBAction func clickStar3(_ sender: UIButton) {
        star1.image("ejpurpleStar.png")
        star2.image("ejpurpleStar.png")
        star3.image("ejpurpleStar.png")
        star4.image("ejgrayStar.png")
        star5.image("ejgrayStar.png")
        scoreLabel.text = "3.0점 보통이에요."
        starNum = "3"
        finBtn.image("wjnextBtn.png")
        finBtn.isEnabled = true
    }
    @IBAction func clickStar4(_ sender: UIButton) {
        star1.image("ejpurpleStar.png")
        star2.image("ejpurpleStar.png")
        star3.image("ejpurpleStar.png")
        star4.image("ejpurpleStar.png")
        star5.image("ejgrayStar.png")
        scoreLabel.text = "4.0점 좋아요!"
        starNum = "4"
        finBtn.image("wjnextBtn.png")
        finBtn.isEnabled = true
    }
    @IBAction func clickStar5(_ sender: UIButton) {
        star1.image("ejpurpleStar.png")
        star2.image("ejpurpleStar.png")
        star3.image("ejpurpleStar.png")
        star4.image("ejpurpleStar.png")
        star5.image("ejpurpleStar.png")
        scoreLabel.text = "5.0점 정말좋아요!"
        starNum = "5"
        finBtn.image("wjnextBtn.png")
        finBtn.isEnabled = true
    }
    
    @IBAction func clickBtn1(_ sender: UIButton) {
        if(check2[0] == 0){
            ofBtn1.setImage(UIImage(named: "ejlikeCBtn1.png"), for: .normal)
            check2[0] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn1.setImage(UIImage(named: "ejlikeBtn1.png"), for: .normal)
            check2[0] = 0
        }
    }
    
    @IBAction func clickBtn2(_ sender: UIButton){
        if(check2[1] == 0){
            ofBtn2.setImage(UIImage(named: "ejlikeCBtn2.png"), for: .normal)
            check2[1] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn2.setImage(UIImage(named: "ejlikeBtn2.png"), for: .normal)
            check2[1] = 0
        }
        
    }
    @IBAction func clickBtn3(_ sender: UIButton){
        if(check2[2] == 0){
            ofBtn3.setImage(UIImage(named: "ejlikeCBtn3.png"), for: .normal)
            check2[2] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn3.setImage(UIImage(named: "ejlikeBtn3.png"), for: .normal)
            check2[2] = 0
        }
        
    }
    @IBAction func clickBtn4(_ sender: UIButton){
        if(check2[3] == 0){
            ofBtn4.setImage(UIImage(named: "ejlikeCBtn4.png"), for: .normal)
            check2[3] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn4.setImage(UIImage(named: "ejlikeBtn4.png"), for: .normal)
            check2[3] = 0
        }
        
    }
    @IBAction func clickBtn5(_ sender: UIButton){
        if(check2[4] == 0){
            ofBtn5.setImage(UIImage(named: "ejlikeCBtn5.png"), for: .normal)
            check2[4] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn5.setImage(UIImage(named: "ejlikeBtn5.png"), for: .normal)
            check2[4] = 0
        }
        
    }
    @IBAction func clickBtn6(_ sender: UIButton){
        if(check2[5] == 0){
            ofBtn6.setImage(UIImage(named: "ejlikeCBtn6.png"), for: .normal)
            check2[5] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn6.setImage(UIImage(named: "ejlikeBtn6.png"), for: .normal)
            check2[5] = 0
        }
        
    }
    @IBAction func clickBtn7(_ sender: UIButton){
        if(check2[6] == 0){
            ofBtn7.setImage(UIImage(named: "ejlikeCBtn7.png"), for: .normal)
            check2[6] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn7.setImage(UIImage(named: "ejlikeBtn7.png"), for: .normal)
            check2[6] = 0
        }
        
    }
    @IBAction func clickBtn8(_ sender: UIButton){
        if(check2[7] == 0){
            ofBtn8.setImage(UIImage(named: "ejlikeCBtn8.png"), for: .normal)
            check2[7] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn8.setImage(UIImage(named: "ejlikeBtn8.png"), for: .normal)
            check2[7] = 0
        }
    }
    @IBAction func clickBtn9(_ sender: UIButton){
        if(check2[8] == 0){
            ofBtn9.setImage(UIImage(named: "ejlikeCBtn9.png"), for: .normal)
            check2[8] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn9.setImage(UIImage(named: "ejlikeBtn9.png"), for: .normal)
            check2[8] = 0
        }
    }
    @IBAction func clickBtn10(_ sender: UIButton){
        if(check2[9] == 0){
            ofBtn10.setImage(UIImage(named: "ejlikeCBtn10.png"), for: .normal)
            check2[9] = 1
            finBtn.image("wjnextBtn.png")
            finBtn.isEnabled = true
        }
        else{
            ofBtn10.setImage(UIImage(named: "ejlikeBtn10.png"), for: .normal)
            check2[9] = 0
        }
    }
    
    @IBAction func finBtn(_ sender: UIButton) {
        let email = mEmail!.components(separatedBy: ["@", "."]).joined()
        
        ref = Database.database().reference().child("MainIng").child("search").child(email).child("post")
        ref.updateChildValues(["구직리뷰": "yes"])
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func goMainView(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }

}
