//
//  SearchingOptionGender.swift
//  MainProject
//
//  Created by 박연주 on 2021/11/30.
//

import UIKit



class SearchingOptionGender: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {

    let ages = ["19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
    var picker = UIPickerView()
    
    @IBOutlet weak var agePicker: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //picker 설정
                agePicker.tintColor = .clear
                configPickerView()
                configToolbar()
    }
    
    //delegate, datasource 연결, picker를 textField의 inputview로 설정
        func configPickerView() {
            picker.delegate = self
            picker.dataSource = self
            agePicker.inputView = picker
        }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ages.count
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ages[row]
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        agePicker.text = ages[row]
    }
    
    func configToolbar() {
            // toolbar를 만들어준다.
            // 시작 시간을 선택,취소를 위한 toolbar
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor.black
            toolBar.sizeToFit()
            
            // 만들어줄 버튼 // 시작 시간 버전
            let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
            // flexibleSpace는 취소~완료 간의 거리를 만들어준다.
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
            // 만든 아이템들을 세팅해주고
            toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
            toolBar.isUserInteractionEnabled = true
            // 악세사리로 추가한다.
        agePicker.inputAccessoryView = toolBar
            
        }
        //시작 시간
        // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
        @objc func donePicker() {
            let row = self.picker.selectedRow(inComponent: 0)
            self.picker.selectRow(row, inComponent: 0, animated: false)
            self.agePicker.text = self.ages[row]
            self.agePicker.resignFirstResponder()
            
        }
        // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
        @objc func cancelPicker() {
            self.agePicker.text = nil
            self.agePicker.resignFirstResponder()
            
        }
    
}
