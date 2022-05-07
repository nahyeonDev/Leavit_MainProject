//
//  WriteAlterView.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/30.
//

import UIKit

class WriteAlterView: UIViewController {

    @IBOutlet weak var goMapMain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        goMapMain.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func dismissView(){
            dismiss(animated: false, completion: nil)
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
