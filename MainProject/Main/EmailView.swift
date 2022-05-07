//
//  EmailView.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/22.
//

import UIKit

class EmailView: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextfield: UITextField! //이메일 입력
    @IBOutlet weak var emailBtn: UIButton! //이메일 버튼
    @IBOutlet weak var nextBtn: UIButton! //다음 버튼
    var ebackTxt : String? = "" //뒤 이메일
    var efrontTxt : String? = "" //앞 이메일
    var eTxt : String? = "" //전달 이메일
    
    var isEmailError = false
    
    //버튼에 사용
    let transparentView = UIView()
    let tableView = UITableView()
    //var selectedButton = UIButton()
    var dataSource = [String]()
    
    //이메일 텍스트필드
    let border1 = CALayer()
    let bWidth = CGFloat(1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이메일 드롭 다운 설정
        configTableView()
        
        nextBtn.isEnabled = false
        actionEmailTextField()

    }
    override func viewWillAppear(_ animated: Bool) {
            self.emailTextfield.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.emailTextfield.resignFirstResponder()
    }
    
    //이메일 입력해야 버튼 등장
    private func actionEmailTextField() {
            emailTextfield.addTarget(self, action: #selector(EmailView.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    func checkEmail() -> Bool {
        return true
    }
    func nonCheckEmail() -> Bool {
        return false
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let email = emailTextfield.text else { return }
        if email.count > 0 {
            isEmailError = checkEmail()
        }else{
            isEmailError = nonCheckEmail()
        }
        if isEmailError {
            nextBtn.isEnabled = true
            nextBtn.setImage(UIImage(named: "jnextBtn.png"), for: .normal)
        } else {
            nextBtn.isEnabled = false
            nextBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        }
        
    }
    //이메일 설정
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        emailBtn.setTitle(dataSource[indexPath.row], for: .normal)
        ebackTxt = dataSource[indexPath.row]
        removeTransparentView()
    }
    
    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0,usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { [self] in self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x:frames.origin.x, y: frames.origin.y + 50, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    @objc func removeTransparentView(){
        let frames = emailBtn.frame
        UIView.animate(withDuration: 0.4, delay: 0.0,usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0
             self.tableView.frame = CGRect(x:frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    //이메일 종류
    @IBAction func selectEmail(_ sender: UIButton) {
        dataSource = ["@naver.com", "@gmail.com", "@hanmail.net", "@swu.ac.kr"]
        addTransparentView(frames: emailBtn.frame)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtn(_ sender: UIButton) {
        // navigation controller 로 화면 전환
          guard let pwVC = self.storyboard?.instantiateViewController(withIdentifier: "passwordController") as? Password_init else { return }
        
        efrontTxt = emailTextfield.text
        eTxt = efrontTxt! + ebackTxt!
        pwVC.emailTxt = self.eTxt!
        
          self.navigationController?.pushViewController(pwVC, animated: true)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
