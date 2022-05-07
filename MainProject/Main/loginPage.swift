//
//  loginPage.swift
//  MainProject
//
//  Created by 김나현 on 2022/02/14.
//

import UIKit
import Firebase
import FirebaseAuth

class loginPage: UIViewController{

    @IBOutlet weak var idTextfield: UITextField! //아이디 텍스트필드
    @IBOutlet weak var pwdTextfield: UITextField! //비밀번호 텍스트필드
    @IBOutlet weak var errorMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorMessage.isHidden = true
        hideKeyboardlo()
    }
    
    @IBAction func loginFin(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: idTextfield.text!, password: pwdTextfield.text!) { [self] (user, error) in

                    if user != nil{
                        print("login success")
                        // navigation controller 로 화면 전환
                          guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "tabbarcontroller") else { return }
                          self.navigationController?.pushViewController(homeVC, animated: true)

                    }
                    else{
                        print("login fail")
                        self.errorMessage.isHidden = false
                        makeCATransitionLabel(errorMessage)
                        self.idTextfield.text = ""
                        self.pwdTextfield.text = ""
                    }

              }
        
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func makeCATransitionLabel(_ label: UILabel) {
        let transition = CATransition()
        transition.duration = 1
        transition.timingFunction = .init(name: .easeInEaseOut)
        label.layer.add(transition, forKey: CATransitionType.push.rawValue)
        
    }

}

extension UIViewController {
    func hideKeyboardlo() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboardlo() {
        view.endEditing(true)
    }
}

