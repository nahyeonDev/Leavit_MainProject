//
//  KeywordCheck.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/15.
//

import UIKit
import FirebaseFirestore

class KeywordCheck: UIViewController {

    @IBOutlet weak var key1: UIButton! //편의점
    @IBOutlet weak var key2: UIButton! //카페,커피
    @IBOutlet weak var key3: UIButton! //치킨
    @IBOutlet weak var key4: UIButton! //피자
    @IBOutlet weak var key5: UIButton! //베이커리,빵
    @IBOutlet weak var key6: UIButton! //사무, 회계
    @IBOutlet weak var key7: UIButton! //식당, 음식점
    @IBOutlet weak var key8: UIButton! //피시방
    @IBOutlet weak var key9: UIButton! //서비스
    @IBOutlet weak var key10: UIButton! //디자인
    @IBOutlet weak var key11: UIButton! //문화, 여가
    @IBOutlet weak var key12: UIButton! //교육
    var num1: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0]
    //-//
    @IBOutlet weak var keyy1: UIButton! //gs25
    @IBOutlet weak var keyy2: UIButton! //이디야커피
    @IBOutlet weak var keyy3: UIButton! //스타벅스
    @IBOutlet weak var keyy4: UIButton! //이마트24
    @IBOutlet weak var keyy5: UIButton! //이삭토스트
    @IBOutlet weak var keyy6: UIButton! //롯데리아
    @IBOutlet weak var keyy7: UIButton! //파리바게트
    var num2: [Int] = [0,0,0,0,0,0,0]
    //-//
    @IBOutlet weak var kkey1: UIButton! //디자이너
    @IBOutlet weak var kkey2: UIButton! //교사
    @IBOutlet weak var kkey3: UIButton! //사무직
    @IBOutlet weak var kkey4: UIButton! //영업직
    @IBOutlet weak var kkey5: UIButton! //번역
    @IBOutlet weak var kkey6: UIButton! //청소
    @IBOutlet weak var kkey7: UIButton! //개발자
    var num3: [Int] = [0,0,0,0,0,0,0]
    var name1: [String] = ["","","","","","","","","","","",""]
    var name2: [String] = ["","","","","","",""]
    var name3: [String] = ["","","","","","",""]
    var checkN : String = ""
    
    var keyNumber4: String? //사용자 키 값 받아오기
    var cusKeyNum4: String?
    
    @IBOutlet weak var subTextField: UITextField! //직접 입력
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cusKeyNum4 = keyNumber4
        // Do any additional setup after loading the view.
        hideKeyboard4()
    }

    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func goNext(_ sender: UIButton) {
        for nm in 0...11{
            if(name1[nm].count > 1){
                checkN += name1[nm]
                checkN += ", "
                
            }
        }
        for nm in 0...6{
            if(name2[nm].count > 1){
                checkN += name2[nm]
                checkN += ", "
                
            }
            else if(name3[nm].count > 1){
                checkN += name3[nm]
                checkN += ", "
            }
        }
        db.collection("가입세부정보").document(cusKeyNum4!).updateData(["키워드" : checkN])
        guard let expVC = self.storyboard?.instantiateViewController(withIdentifier: "profileViewController")as? profileView else { return }
      expVC.keyNumbers = self.cusKeyNum4!
        self.navigationController?.pushViewController(expVC, animated: true)
    }
    @IBAction func plusBtn(_ sender: UIButton) {
        if(subTextField.text != nil){
            checkN += subTextField.text!
            checkN += ", "
        }
        subTextField.text = "키워드로 추가되었습니다"
    }
    
    //편의점
    @IBAction func clickKey1(_ sender: Any) {
        if(num1[0] == 0){
            key1.setImage(UIImage(named: "jkey1.png"), for: .normal)
            num1[0] += 1
            name1[0] = "편의점"
        }
        else if(num1[0] == 1){
            key1.setImage(UIImage(named: "w1.png"), for: .normal)
            num1[0] -= 1
            name1[0] = ""
        }
    }
    //카페,커피
    @IBAction func clickKey2(_ sender: Any) {
        if(num1[1] == 0){
            key2.setImage(UIImage(named: "jkey2.png"), for: .normal)
            num1[1] += 1
            name1[1] = "카페/커피"
        }
        else if(num1[1] == 1){
            key2.setImage(UIImage(named: "w2.png"), for: .normal)
            num1[1] -= 1
            name1[1] = ""
        }
    }
    //치킨
    @IBAction func clickKey3(_ sender: Any) {
        if(num1[2] == 0){
            key3.setImage(UIImage(named: "jkey3.png"), for: .normal)
            num1[2] += 1
            name1[2] = "치킨"
        }
        else if(num1[2] == 1){
            key3.setImage(UIImage(named: "w3.png"), for: .normal)
            num1[2] -= 1
            name1[2] = ""
        }
    }
    //피자
    @IBAction func clickKey4(_ sender: Any) {
        if(num1[3] == 0){
            key4.setImage(UIImage(named: "jkey4.png"), for: .normal)
            num1[3] += 1
            name1[3] = "피자"
        }
        else if(num1[3] == 1){
            key4.setImage(UIImage(named: "w4.png"), for: .normal)
            num1[3] -= 1
            name1[3] = ""
        }
    }
    //베이커리
    @IBAction func clickKey5(_ sender: Any) {
        if(num1[4] == 0){
            key5.setImage(UIImage(named: "jkey5.png"), for: .normal)
            num1[4] += 1
            name1[4] = "베이커리"
        }
        else if(num1[4] == 1){
            key5.setImage(UIImage(named: "w5.png"), for: .normal)
            num1[4] -= 1
            name1[4] = ""
        }
    }
    //사무회계
    @IBAction func clickKey6(_ sender: Any) {
        if(num1[5] == 0){
            key6.setImage(UIImage(named: "jkey6.png"), for: .normal)
            num1[5] += 1
            name1[5] = "사무/회계"
        }
        else if(num1[5] == 1){
            key6.setImage(UIImage(named: "w6.png"), for: .normal)
            num1[5] -= 1
            name1[5] = ""
        }
    }
    //식당음식점
    @IBAction func clickKey7(_ sender: Any) {
        if(num1[6] == 0){
            key7.setImage(UIImage(named: "jkey7.png"), for: .normal)
            num1[6] += 1
            name1[6] = "식당/음식점"
        }
        else if(num1[6] == 1){
            key7.setImage(UIImage(named: "w7.png"), for: .normal)
            num1[6] -= 1
            name1[6] = ""
        }
    }
    //피씨방
    @IBAction func clickKey8(_ sender: Any) {
        if(num1[7] == 0){
            key8.setImage(UIImage(named: "jkey8.png"), for: .normal)
            num1[7] += 1
            name1[6] = "피씨방"
        }
        else if(num1[7] == 1){
            key8.setImage(UIImage(named: "w8.png"), for: .normal)
            num1[7] -= 1
            name1[7] = ""
        }
    }
    //서비스
    @IBAction func clickKey9(_ sender: Any) {
        if(num1[8] == 0){
            key9.setImage(UIImage(named: "jkey9.png"), for: .normal)
            num1[8] += 1
            name1[8] = "서비스"
        }
        else if(num1[8] == 1){
            key9.setImage(UIImage(named: "w9.png"), for: .normal)
            num1[8] -= 1
            name1[8] = ""
        }
    }
    //디자인
    @IBAction func clickKey10(_ sender: Any) {
        if(num1[9] == 0){
            key10.setImage(UIImage(named: "jkey10.png"), for: .normal)
            num1[9] += 1
            name1[9] = "디자인"
        }
        else if(num1[9] == 1){
            key10.setImage(UIImage(named: "w10.png"), for: .normal)
            num1[9] -= 1
            name1[9] = ""
        }
    }
    //문화여가
    @IBAction func clickKey11(_ sender: Any) {
        if(num1[10] == 0){
            key11.setImage(UIImage(named: "jkey11.png"), for: .normal)
            num1[10] += 1
            name1[10] = "문화/디자인"
        }
        else if(num1[10] == 1){
            key11.setImage(UIImage(named: "w11.png"), for: .normal)
            num1[10] -= 1
            name1[10] = ""
        }
    }
    //교육
    @IBAction func clickKey12(_ sender: Any) {
        if(num1[11] == 0){
            key12.setImage(UIImage(named: "jkey12.png"), for: .normal)
            num1[11] += 1
            name1[11] = "교육"
        }
        else if(num1[11] == 1){
            key12.setImage(UIImage(named: "w12.png"), for: .normal)
            num1[11] -= 1
            name1[11] = ""
        }
    }
    
    
    //--//
    //gs25
    @IBAction func clickKeyy1(_ sender: Any) {
        if(num2[0] == 0){
            keyy1.setImage(UIImage(named: "jkeyy1.png"), for: .normal)
            num2[0] += 1
            name2[0] = "gs25"
        }
        else if(num2[0] == 1){
            keyy1.setImage(UIImage(named: "fn1.png"), for: .normal)
            num2[0] -= 1
            name2[0] = ""
        }
    }
    //이디야커피
    @IBAction func clickKeyy2(_ sender: Any) {
        if(num2[1] == 0){
            keyy2.setImage(UIImage(named: "jkeyy2.png"), for: .normal)
            num2[1] += 1
            name2[1] = "이디야커피"
        }
        else if(num2[1] == 1){
            keyy2.setImage(UIImage(named: "fn2.png"), for: .normal)
            num2[1] -= 1
            name2[1] = ""
        }
    }
    //스타벅스
    @IBAction func clickKeyy3(_ sender: Any) {
        if(num2[2] == 0){
            keyy3.setImage(UIImage(named: "jkeyy3.png"), for: .normal)
            num2[2] += 1
            name2[2] = "스타벅스"
        }
        else if(num2[2] == 1){
            keyy3.setImage(UIImage(named: "fn3.png"), for: .normal)
            num2[2] -= 1
            name2[2] = ""
        }
    }
    //이마트24
    @IBAction func clickKeyy4(_ sender: Any) {
        if(num2[3] == 0){
            keyy4.setImage(UIImage(named: "jkeyy4.png"), for: .normal)
            num2[3] += 1
            name2[3] = "이마트24"
        }
        else if(num2[3] == 1){
            keyy4.setImage(UIImage(named: "fn4.png"), for: .normal)
            num2[3] -= 1
            name2[3] = ""
        }
    }
    //이삭토스트
    @IBAction func clickKeyy5(_ sender: Any) {
        if(num2[4] == 0){
            keyy5.setImage(UIImage(named: "jkeyy5.png"), for: .normal)
            num2[4] += 1
            name2[4] = "이삭토스트"
        }
        else if(num2[4] == 1){
            keyy5.setImage(UIImage(named: "fn5.png"), for: .normal)
            num2[4] -= 1
            name2[4] = ""
        }
    }
    //롯데리아
    @IBAction func clickKeyy6(_ sender: Any) {
        if(num2[5] == 0){
            keyy6.setImage(UIImage(named: "jkeyy6.png"), for: .normal)
            num2[5] += 1
            name2[5] = "롯데리아"
        }
        else if(num2[5] == 1){
            keyy6.setImage(UIImage(named: "fn6.png"), for: .normal)
            num2[5] -= 1
            name2[5] = ""
        }
    }
    //파리바게트
    @IBAction func clickKeyy7(_ sender: Any) {
        if(num2[6] == 0){
            keyy7.setImage(UIImage(named: "jkeyy7.png"), for: .normal)
            num2[6] += 1
            name2[6] = "파리바게트"
        }
        else if(num2[6] == 1){
            keyy7.setImage(UIImage(named: "fn7.png"), for: .normal)
            num2[6] -= 1
            name2[6] = ""
        }
    }
    
    //--//
    //디자이너
    @IBAction func clickKkey1(_ sender: Any) {
        if(num3[0] == 0){
            kkey1.setImage(UIImage(named: "jkkey1.png"), for: .normal)
            num3[0] += 1
            name3[0] = "디자이너"
        }
        else if(num3[0] == 1){
            kkey1.setImage(UIImage(named: "g1.png"), for: .normal)
            num3[0] -= 1
            name3[0] = ""
        }
    }
    //교사선생님
    @IBAction func clickKkey2(_ sender: Any) {
        if(num3[1] == 0){
            kkey2.setImage(UIImage(named: "jkkey2.png"), for: .normal)
            num3[1] += 1
            name3[1] = "교사/선생님"
        }
        else if(num3[1] == 1){
            kkey2.setImage(UIImage(named: "g2.png"), for: .normal)
            num3[1] -= 1
            name3[1] = ""
        }
    }
    //사무직
    @IBAction func clickKkey3(_ sender: Any) {
        if(num3[2] == 0){
            kkey3.setImage(UIImage(named: "jkkey3.png"), for: .normal)
            num3[2] += 1
            name3[2] = "사무직"
        }
        else if(num3[2] == 1){
            kkey3.setImage(UIImage(named: "g3.png"), for: .normal)
            num3[2] -= 1
            name3[2] = ""
        }
    }
    //영업직
    @IBAction func clickKkey4(_ sender: Any) {
        if(num3[3] == 0){
            kkey4.setImage(UIImage(named: "jkkey4.png"), for: .normal)
            num3[3] += 1
            name3[3] = "영업직"
        }
        else if(num3[3] == 1){
            kkey4.setImage(UIImage(named: "g4.png"), for: .normal)
            num3[3] -= 1
            name3[3] = ""
        }
    }
    //번역통역
    @IBAction func clickKkey5(_ sender: Any) {
        if(num3[4] == 0){
            kkey5.setImage(UIImage(named: "jkkey5.png"), for: .normal)
            num3[4] += 1
            name3[4] = "번역/통역"
        }
        else if(num3[4] == 1){
            kkey5.setImage(UIImage(named: "g5.png"), for: .normal)
            num3[4] -= 1
            name3[4] = ""
        }
    }
    //청소
    @IBAction func clickKkey6(_ sender: Any) {
        if(num3[5] == 0){
            kkey6.setImage(UIImage(named: "jkkey6.png"), for: .normal)
            num3[5] += 1
            name3[5] = "청소"
        }
        else if(num3[5] == 1){
            kkey6.setImage(UIImage(named: "g6.png"), for: .normal)
            num3[5] -= 1
            name3[5] = ""
        }
    }
    //개발자
    @IBAction func clickKkey7(_ sender: Any) {
        if(num3[6] == 0){
            kkey7.setImage(UIImage(named: "jkkey7.png"), for: .normal)
            num3[6] += 1
            name3[6] = "개발자"
        }
        else if(num3[6] == 1){
            kkey7.setImage(UIImage(named: "g7.png"), for: .normal)
            num3[6] -= 1
            name3[6] = ""
        }
    }
    
    
}
extension UIViewController {
    func hideKeyboard4() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard4() {
        view.endEditing(true)
    }
}
