//
//  CertificateMainView.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/14.
//

import UIKit

class CertificateMainView: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    //1
    @IBOutlet weak var workTextfield: UITextField! //자격증명 텍스트필드
    @IBOutlet weak var startTime: UITextField! //시작시간
    @IBOutlet weak var finTime: UITextField!  //완료시간
    @IBOutlet weak var finishBtn: UIButton! //등록하기버튼
    
    @IBOutlet weak var writeView1: UIView! //글작성페이지
    @IBOutlet weak var finView1: UIView!  //완성페이지
    
    @IBOutlet weak var titleText: UILabel! //제목
    @IBOutlet weak var timeTitle: UILabel! //근무 기간
    
    //2
    @IBOutlet weak var workTextfield2: UITextField! //자격증명 텍스트필드
    @IBOutlet weak var startTime2: UITextField! //시작시간
    @IBOutlet weak var finTime2: UITextField!  //완료시간
    
    @IBOutlet weak var titleText2: UILabel! //제목
    @IBOutlet weak var timeTitle2: UILabel! //근무 기간
    
    @IBOutlet weak var writeView2: UIView!
    @IBOutlet weak var finView2: UIView!
    @IBOutlet weak var finishBtn2: UIButton!
    @IBOutlet weak var line: UIImageView!
    
    @IBOutlet weak var btnView: UIView!
    
    let picker = UIPickerView()
    let picker2 = UIPickerView()
    let picker3 = UIPickerView()
    let picker4 = UIPickerView()
    let times = ["2017","2018","2019","2020","2021","2022"]
    let times2 = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    let times3 = ["2017","2018","2019","2020","2021","2022"]
    let times4 = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    var sTime: String?
    var fTime: String?
    var sTime2: String?
    var fTime2: String?
    var check = false

    @IBOutlet weak var finBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configPickerView()
        configToolbar()
        finishBtn.isEnabled = false
        finView1.isHidden = true
        
        finView2.isHidden = true
        writeView2.isHidden = true
        finishBtn2.isEnabled = false
        finishBtn2.isHidden = true
        
        btnView.isHidden = true
        finBtn.isEnabled = false
        hideKeyboardc2()
    }
    
    //delegate, datasource 연결, picker를 textField의 inputview로 설정
    func configPickerView() {
        picker.delegate = self
        picker.dataSource = self
        picker2.delegate = self
        picker2.dataSource = self
        picker3.delegate = self
        picker3.dataSource = self
        picker4.delegate = self
        picker4.dataSource = self
        startTime.inputView = picker
        finTime.inputView = picker2
        startTime2.inputView = picker3
        finTime2.inputView = picker4
        
    }
    // pickerview는 하나만
    public func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    // pickerview의 선택지는 데이터의 개수만큼
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == picker){
            return times.count
        }
        else if(pickerView == picker2){
            return times2.count
        }
        else if(pickerView == picker3){
            return times3.count
        }
        else{
            return times4.count
        }
    }
    // pickerview 내 선택지의 값들을 원하는 데이터로 채워준다.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == picker){
            return times[row]
        }
        else if(pickerView == picker2){
            return times2[row]
        }
        else if(pickerView == picker3){
            return times3[row]
        }
        else {
            return times4[row]
        }
    }
    // textfield의 텍스트에 pickerview에서 선택한 값을 넣어준다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == picker){
            self.startTime.text = self.times[row]
        }
        else if(pickerView == picker2){
            self.finTime.text = self.times2[row]
        }
        else if(pickerView == picker3){
            self.startTime2.text = self.times3[row]
        }
        else {
            self.finTime2.text = self.times4[row]
        }
        
    }
    func configToolbar() {
        // toolbar를 만들어준다.
        // 시작 시간을 선택,취소를 위한 toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        // 완료 시간을 선택,취소를 위한 toolbar
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = UIBarStyle.default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = UIColor.black
        toolBar2.sizeToFit()
        // 시작 시간2을 선택,취소를 위한 toolbar
        let toolBar3 = UIToolbar()
        toolBar3.barStyle = UIBarStyle.default
        toolBar3.isTranslucent = true
        toolBar3.tintColor = UIColor.black
        toolBar3.sizeToFit()
        // 완료 시간2을 선택,취소를 위한 toolbar
        let toolBar4 = UIToolbar()
        toolBar4.barStyle = UIBarStyle.default
        toolBar4.isTranslucent = true
        toolBar4.tintColor = UIColor.black
        toolBar4.sizeToFit()
        
        // 만들어줄 버튼 // 시작 시간 버전
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        // flexibleSpace는 취소~완료 간의 거리를 만들어준다.
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        // 만든 아이템들을 세팅해주고
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        toolBar.isUserInteractionEnabled = true
        // 악세사리로 추가한다.
        startTime.inputAccessoryView = toolBar
        
        // 만들어줄 버튼 // 완료 시간 버전
        let doneBT2 = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker2))
        // flexibleSpace는 취소~완료 간의 거리를 만들어준다.
        let flexibleSpace2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT2 = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker2))
        // 만든 아이템들을 세팅해주고
        toolBar2.setItems([cancelBT2,flexibleSpace2,doneBT2], animated: false)
        toolBar2.isUserInteractionEnabled = true
        // 악세사리로 추가한다.
        finTime.inputAccessoryView = toolBar2
        
        // 만들어줄 버튼 // 시작 시간2 버전
        let doneBT3 = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker3))
        // flexibleSpace는 취소~완료 간의 거리를 만들어준다.
        let flexibleSpace3 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT3 = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker3))
        // 만든 아이템들을 세팅해주고
        toolBar3.setItems([cancelBT3,flexibleSpace3,doneBT3], animated: false)
        toolBar3.isUserInteractionEnabled = true
        // 악세사리로 추가한다.
        startTime2.inputAccessoryView = toolBar3
        
        // 만들어줄 버튼 // 완료 시간2 버전
        let doneBT4 = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker4))
        // flexibleSpace는 취소~완료 간의 거리를 만들어준다.
        let flexibleSpace4 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT4 = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker4))
        // 만든 아이템들을 세팅해주고
        toolBar4.setItems([cancelBT4,flexibleSpace4,doneBT4], animated: false)
        toolBar4.isUserInteractionEnabled = true
        // 악세사리로 추가한다.
        finTime2.inputAccessoryView = toolBar4
        
    }
    //시작 시간
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.startTime.text = self.times[row]
        self.startTime.resignFirstResponder()
        
        finishBtn.isEnabled = true
        sTime = self.times[row]
        
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker() {
        self.startTime.text = nil
        self.startTime.resignFirstResponder()
        
        finishBtn.isEnabled = false
        sTime = ""
        
    }
    //완료 시간
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker2() {
        let row2 = self.picker2.selectedRow(inComponent: 0)
        self.picker2.selectRow(row2, inComponent: 0, animated: false)
        self.finTime.text = self.times2[row2]
        self.finTime.resignFirstResponder()
        
        finishBtn.isEnabled = true
        finishBtn.setImage(UIImage(named: "cokCheckBtn.png"), for: .normal)
        //이전 화면으로 데이터 보내기 위함
        fTime = self.times2[row2]
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker2() {
        self.finTime.text = nil
        self.finTime.resignFirstResponder()
        
        finishBtn.isEnabled = false
        //이전 화면으로 데이터 보내기 위함
        fTime = ""
        
    }
    //시작 시간2
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker3() {
        let row = self.picker3.selectedRow(inComponent: 0)
        self.picker3.selectRow(row, inComponent: 0, animated: false)
        self.startTime2.text = self.times3[row]
        self.startTime2.resignFirstResponder()
        
        finishBtn2.isEnabled = true
        sTime2 = self.times3[row]
        
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker3() {
        self.startTime2.text = nil
        self.startTime2.resignFirstResponder()
        
        finishBtn2.isEnabled = false
        sTime2 = ""
        
    }
    //완료 시간2
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker4() {
        let row2 = self.picker4.selectedRow(inComponent: 0)
        self.picker4.selectRow(row2, inComponent: 0, animated: false)
        self.finTime2.text = self.times4[row2]
        self.finTime2.resignFirstResponder()
        
        finishBtn2.isEnabled = true
        finishBtn2.setImage(UIImage(named: "cokCheckBtn.png"), for: .normal)
        //이전 화면으로 데이터 보내기 위함
        fTime2 = self.times4[row2]
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker4() {
        self.finTime2.text = nil
        self.finTime2.resignFirstResponder()
        
        finishBtn2.isEnabled = false
        //이전 화면으로 데이터 보내기 위함
        fTime2 = ""
        
    }
    
    @IBAction func clickOneBtn(_ sender: UIButton) {
        titleText.text = workTextfield.text
        timeTitle.text = sTime! + "/" + fTime!
        
        writeView1.isHidden = true
        finView1.isHidden = false
        finishBtn.isHidden = true
        line.isHidden = true
        finishBtn2.isHidden = false
        finishBtn2.isEnabled = true
        self.finishBtn2.transform = CGAffineTransform(translationX: 0, y: -272)
        
        btnView.isHidden = false
        finBtn.isEnabled = true
    }
    
    @IBAction func clickTwoBtn(_ sender: UIButton) {
        if(check == false){
            check = true
            finishBtn2.setImage(UIImage(named: "XcokCheckBtn.png"), for: .normal)
            writeView2.isHidden = false
            finishBtn2.isEnabled = false
            writeView2.transform = CGAffineTransform(translationX: 0, y: -347)
            finView2.transform = CGAffineTransform(translationX: 0, y: -347)
            finishBtn2.transform = CGAffineTransform(translationX: 0, y: -15)
            btnView.isHidden = true
            finBtn.isEnabled = false
        }
        else{
            titleText2.text = workTextfield2.text
            timeTitle2.text = sTime2! + "/" + fTime2!
            finView2.isHidden = false
            writeView2.isHidden = true
            finishBtn2.isHidden = true
            line.isHidden = false
            line.transform = CGAffineTransform(translationX: 0, y: -250)
            btnView.isHidden = false
            finBtn.isEnabled = true
            
        }

    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        let preVC = self.presentingViewController
        
//        guard let vc = preVC as? JobSearchWrite else {
//            return
//        }
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func clickFinBtn(_ sender: Any) {
        let preVC = self.presentingViewController
        
        guard let vc = preVC as? JobSearchWrite else {
            return
        }
        
        var certifi1 = titleText.text! + "," + timeTitle.text!
        
        if(titleText2.text!.count > 1){
            let certifi2 = " + " + titleText2.text! + "," + timeTitle2.text!
            
            certifi1 += certifi2
        }
        vc.certiInfo = certifi1
        
        self.presentingViewController?.dismiss(animated: true)
    }
}
extension UIViewController {
    func hideKeyboardc2() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboardc2() {
        view.endEditing(true)
    }
}
