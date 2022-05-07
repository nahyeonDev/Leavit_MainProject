//
//  SearchAlterView.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/01.
//

import UIKit

class SearchAlterView: UIViewController {

    @IBOutlet weak var goListView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        goListView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    @objc func dismissView(){
            dismiss(animated: false, completion: nil)
        }

}
