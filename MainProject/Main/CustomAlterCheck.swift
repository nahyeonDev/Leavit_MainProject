//
//  CustomAlterCheck.swift
//  MainProject
//
//  Created by κΉλν on 2022/05/14.
//

import UIKit

class CustomAlterCheck: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainView.layer.cornerRadius = 10
        okBtn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    @objc func dismissView(){
            dismiss(animated: true, completion: nil)
    }
    

}
