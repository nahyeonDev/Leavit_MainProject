//
//  CustomPopUp.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/23.
//

import UIKit

class CustomPopUp: UIViewController {

    @IBOutlet weak var goLoginPage: UIButton! //건너뛰기 버튼
    @IBOutlet weak var goDetailPage: UIButton! //이어서 프로필 작성하기
    @IBOutlet weak var customView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.layer.cornerRadius = 10
        customView.layer.masksToBounds = true
        //이어서 프로필 작성
        goDetailPage.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        goLoginPage.addTarget(self, action: #selector(goAlert), for: .touchUpInside)
    }
    
    @objc func goAlert(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginpageController") else { return }
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        present(vc, animated: true, completion: nil)
    }
    
    @objc func dismissView(){
            dismiss(animated: true, completion: nil)
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
