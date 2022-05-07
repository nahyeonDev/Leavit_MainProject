//
//  JobTime_jobsearchwrite.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/16.
//

import UIKit

class JobTime_jobsearchwrite: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var topView_t: UIView!
    //근무요일 버튼(일별)
    @IBOutlet weak var monBtn: UIButton!
    @IBOutlet weak var tuesBtn: UIButton!
    @IBOutlet weak var wedBtn: UIButton!
    @IBOutlet weak var thrBtn: UIButton!
    @IBOutlet weak var friBtn: UIButton!
    @IBOutlet weak var satBtn: UIButton!
    @IBOutlet weak var sunBtn: UIButton!
    //협의가능 체크 버튼
    @IBOutlet weak var possibleBtn: UIButton!
    //시작시간
    @IBOutlet weak var startTime: UITextField!
    //완료시간
    @IBOutlet weak var finTime: UITextField!
    //협의가능 체크 버튼
    @IBOutlet weak var posTBtn: UIButton!
    
    @IBOutlet weak var finBtn: UIButton! //완료버튼
    
    var num: [Int] = [0,0,0,0,0,0,0]
    
    let picker = UIPickerView()
    let picker2 = UIPickerView()
    
    let times = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00",]
    let times2 = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00",]
    //협의 가능
    var isCheck = false
    var isCheck2 = false
    
    //근무 요일 이전 화면으로
    var sWeek : Array<String> = ["","","","","","",""]
    var sDay : String = ""
    //시작 시간
    var sTime : String? = ""
    //완료 시간
    var fTime : String? = ""
    //최종 텍스트
    var finData = ""
    //협의 가능
    var okDay = "" //요일
    var okTime = "" //시간
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configPickerView()
        configToolbar()
        
        finBtn.isEnabled = false
        hideKeyboardt2()
        
    }
    //delegate, datasource 연결, picker를 textField의 inputview로 설정
    func configPickerView() {
        picker.delegate = self
        picker.dataSource = self
        picker2.delegate = self
        picker2.dataSource = self
        startTime.inputView = picker
        finTime.inputView = picker2
    }
    // pickerview는 하나만
    public func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    // pickerview의 선택지는 데이터의 개수만큼
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == picker){
            return times.count
        }
        else{
            return times2.count
        }
    }
    // pickerview 내 선택지의 값들을 원하는 데이터로 채워준다.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == picker){
            return times[row]
        }
        else{
            return times2[row]
        }
    }
    // textfield의 텍스트에 pickerview에서 선택한 값을 넣어준다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == picker){
            self.startTime.text = self.times[row]
        }
        else{
            self.finTime.text = self.times2[row]
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
        
    }
    //시작 시간
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.startTime.text = self.times[row]
        self.startTime.resignFirstResponder()
        
        finBtn.setImage(UIImage(named: "wj2nextBtn"), for: .normal)
        finBtn.isEnabled = true
        //이전 화면으로 데이터 보내기 위함
        sTime = self.times[row]
        
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker() {
        self.startTime.text = nil
        self.startTime.resignFirstResponder()
        
        finBtn.setImage(UIImage(named: "xjnextBtn"), for: .normal)
        finBtn.isEnabled = false
        sTime = ""
        
    }
    //완료 시간
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker2() {
        let row2 = self.picker2.selectedRow(inComponent: 0)
        self.picker2.selectRow(row2, inComponent: 0, animated: false)
        self.finTime.text = self.times2[row2]
        self.finTime.resignFirstResponder()
        
        finBtn.setImage(UIImage(named: "wj2nextBtn"), for: .normal)
        finBtn.isEnabled = true
        //이전 화면으로 데이터 보내기 위함
        fTime = self.times2[row2]
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker2() {
        self.finTime.text = nil
        self.finTime.resignFirstResponder()
        
        finBtn.setImage(UIImage(named: "xjnextBtn"), for: .normal)
        finBtn.isEnabled = false
        //이전 화면으로 데이터 보내기 위함
        fTime = ""
        
    }

    //월
    @IBAction func clickMon(_ sender: UIButton) {
        if(num[0] == 0){
            monBtn.setImage(UIImage(named: "fillmon2.png"), for: .normal)
            num[0] += 1
            
            sWeek[0] = "월"
        }
        else if(num[0] == 1){
            monBtn.setImage(UIImage(named: "mon.png"), for: .normal)
            num[0] -= 1
            
            sWeek[0] = ""
        }
    }
    //화
    @IBAction func clickTues(_ sender: UIButton) {
        if(num[1] == 0){
            tuesBtn.setImage(UIImage(named: "filltues2.png"), for: .normal)
            num[1] += 1
            
            sWeek[1] = "화"
        }
        else if(num[1] == 1){
            tuesBtn.setImage(UIImage(named: "tues.png"), for: .normal)
            num[1] -= 1
            
            sWeek[1] = ""
        }
    }
    //수
    @IBAction func clickWed(_ sender: UIButton) {
        if(num[2] == 0){
            wedBtn.setImage(UIImage(named: "fillwed2.png"), for: .normal)
            num[2] += 1
            
            sWeek[2] = "수"
        }
        else if(num[2] == 1){
            wedBtn.setImage(UIImage(named: "wed.png"), for: .normal)
            num[2] -= 1
            
            sWeek[2] = ""
        }
    }
    //목
    @IBAction func clickThr(_ sender: UIButton) {
        if(num[3] == 0){
            thrBtn.setImage(UIImage(named: "fillthr2.png"), for: .normal)
            num[3] += 1
            
            sWeek[3] = "목"
        }
        else if(num[3] == 1){
            thrBtn.setImage(UIImage(named: "thr.png"), for: .normal)
            num[3] -= 1
            
            sWeek[3] = ""
        }
    }
    //금
    @IBAction func clickFri(_ sender: UIButton) {
        if(num[4] == 0){
            friBtn.setImage(UIImage(named: "fillfri2.png"), for: .normal)
            num[4] += 1
            
            sWeek[4] = "금"
        }
        else if(num[4] == 1){
            friBtn.setImage(UIImage(named: "fri.png"), for: .normal)
            num[4] -= 1
            
            sWeek[4] = ""
        }
    }
    //토
    @IBAction func clickSat(_ sender: UIButton) {
        if(num[5] == 0){
            satBtn.setImage(UIImage(named: "fillsat2.png"), for: .normal)
            num[5] += 1
            
            sWeek[5] = "토"
        }
        else if(num[5] == 1){
            satBtn.setImage(UIImage(named: "sat.png"), for: .normal)
            num[5] -= 1
            
            sWeek[5] = ""
        }
    }
    //일
    @IBAction func clickSun(_ sender: UIButton) {
        if(num[6] == 0){
            sunBtn.setImage(UIImage(named: "fillsun2.png"), for: .normal)
            num[6] += 1
            
            sWeek[6] = "일"
        }
        else if(num[6] == 1){
            sunBtn.setImage(UIImage(named: "sun.png"), for: .normal)
            num[6] -= 1
            
            sWeek[6] = ""
        }
    }
    
    //협의 가능1
    @IBAction func clickOk1(_ sender: UIButton) {
        if(isCheck == false){
            possibleBtn.setImage(UIImage(named: "checkOk.png"), for: .normal)
            isCheck = true
        }
        else {
            possibleBtn.setImage(UIImage(named: "checkBox.png"), for: .normal)
            isCheck = false
        }
    }
    
    //협의 가능2
    @IBAction func clickOk2(_ sender: UIButton) {
        if(isCheck2 == false){
            posTBtn.setImage(UIImage(named: "checkOk.png"), for: .normal)
            isCheck2 = true
        }
        else {
            posTBtn.setImage(UIImage(named: "checkBox.png"), for: .normal)
            isCheck2 = false
        }
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        let preVC = self.presentingViewController
        
        guard let vc = preVC as? JobSearchWrite else {
            return
        }
        for num in 0...6{
            if(sWeek[num] != ""){
                sDay += sWeek[num]
                sDay += " "
            }
        }
        finData = sDay + "," + sTime! + "~" + fTime!
        
        vc.workInfo = self.finData
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func gotoBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }

}

extension UIViewController {
    func hideKeyboardt2() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboardt2() {
        view.endEditing(true)
    }
}
