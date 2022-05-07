//
//  Password_init.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/14.
//

import UIKit
import Firebase
import FirebaseAuth

class Password_init: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtPassword: UITextField!   //비밀번호
    @IBOutlet weak var lblPasswordConfirm: UILabel! //비밀번호확인 레이블
    @IBOutlet weak var txtPasswordConfirm: UITextField! //비밀번호확인
    @IBOutlet weak var passwordErrorLabel: UILabel!//비밀번호 6자리 이하
    @IBOutlet weak var passwordCheckErrorLabel: UILabel! //비밀번호 확인 오류
    var emailTxt : String = ""//이메일 받아옴
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var pwd_checkimg: UIImageView!//비밀번호 입력 ok img
    @IBOutlet weak var pwd_checkimg2: UIImageView!//비밀번호확인 입력 ok img
    @IBOutlet weak var confirmButton: UIButton!//다음버튼
    
    //이메일 보내기
    var currentKey : String? = ""
    
    var isPasswordError = false
    var isPasswordCheckError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtPassword.delegate = self
        self.txtPasswordConfirm.delegate = self
        actionPasswordTextField()
        actionCheckingPasswordTextField()
        
        confirmButton.isEnabled = false
        
        pwd_checkimg.isHidden=true
        pwd_checkimg2.isHidden = true
        
        self.email.text = emailTxt
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
            self.txtPassword.becomeFirstResponder()
        self.txtPasswordConfirm.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.txtPassword.resignFirstResponder()
        self.txtPasswordConfirm.resignFirstResponder()
    }

    @IBAction func backBtn2(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gotoNext2(_ sender: UIButton) {
        // navigation controller 로 화면 전환
        Auth.auth().createUser(withEmail: email.text!, password: txtPasswordConfirm.text!

        ) { [self] (user, error) in

                    if user !=  nil{

                        print("register success")
                        
                        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "signdetailController") as? SignUpDetail else { return }
                        currentKey = email.text
                        detailVC.keyNumber = self.currentKey!
                        self.navigationController?.pushViewController(detailVC, animated: true)

                    }

                    else{
                        print("register failed")
                    }
                }
    }
    
    
    func checkPassword() -> Bool{
        return true
    }
    func checkPasswordCheck() ->Bool{
        let ptxt = txtPassword.text
        let pContxt = txtPasswordConfirm.text
        if ptxt == pContxt{
            passwordCheckErrorLabel.textColor = .white
            pwd_checkimg2.isHidden = false
            return true
        }
        else{
            passwordCheckErrorLabel.textColor = .red
            pwd_checkimg2.isHidden = true
            return false
        }
    }
    
    private func actionPasswordTextField() {
            txtPassword.addTarget(self, action: #selector(Password_init.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
        }
        
        private func actionCheckingPasswordTextField() {
            txtPasswordConfirm.addTarget(self, action: #selector(Password_init.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
        }
        
        // MARK: @objc Function
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            guard let password = txtPassword.text else { return }
            if password.count < 6 {
                passwordErrorLabel.textColor = .red
                lblPasswordConfirm.textColor = .lightGray
                pwd_checkimg.isHidden = true
            }
            else {
                passwordErrorLabel.textColor = .white
                lblPasswordConfirm.textColor = .black
                pwd_checkimg.isHidden = false
                self.isPasswordError = checkPassword()
            }
            if textField == txtPassword || textField == txtPasswordConfirm {
                self.isPasswordCheckError = checkPasswordCheck()
            }
            // 모두 true -> 시작하기
            if isPasswordError && isPasswordCheckError {
                confirmButton.isEnabled = true
                confirmButton.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
                
            } else {
                confirmButton.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
                confirmButton.isEnabled = false
            }
        }
}
