//
//  JopTime_jobofferwrite.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/14.
//

import UIKit

class CellClass: UITableViewCell{
    
}

class JopTime_jobofferwrite: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var topView_job: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    //근무정보 타이틀
    @IBOutlet weak var mainTitle: UILabel!
    //근무요일
    @IBOutlet weak var weekLabel: UILabel!
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
    @IBOutlet weak var possibleTxt: UILabel!
    //시작시간
    @IBOutlet weak var startTime: UITextField!
    //종료시간
    @IBOutlet weak var finTime: UITextField!
    //시간 협의가능
    @IBOutlet weak var tPosBtn: UIButton!
    //시급, 일급 선택
    @IBOutlet weak var howMoney: UIButton!
    //월급(돈)
    @IBOutlet weak var moneyText: UITextField!
    //완료버튼
    @IBOutlet weak var finalBtn: UIButton!
    
    var num: [Int] = [0,0,0,0,0,0,0]
    
    //협의 가능
    var isCheck = false
    var isCheck2 = false
    
    let picker = UIPickerView()
    let picker2 = UIPickerView()
    
    let times = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00",]
    let times2 = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00",]
    
    //입금에 사용
    let transparentView = UIView()
    let tableView = UITableView()
    //var selectedButton = UIButton()
    var dataSource = [String]()
    
    //근무 요일 이전 화면으로
    var sWeek : Array<String> = ["","","","","","",""]
    var sDay : String = ""
    //시작 시간
    var sTime : String? = ""
    //완료 시간
    var fTime : String? = ""
    //입금
    var deposit : String? = ""
    var money : String? = ""
    //최종 텍스트
    var fin = ""
    var finData1 = ""
    var finData2 = ""
    //협의 가능
    var okDay = "" //요일
    var okTime = "" //시간
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //picker 설정
        startTime.tintColor = .clear
        finTime.tintColor = .clear
        configPickerView()
        configToolbar()
        
        //입금 드롭 다운 설정
        configTableView()
        
        finalBtn.isEnabled = false
        hideKeyboardt1()

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
        
        finalBtn.isEnabled = true
        finalBtn.setImage(UIImage(named: "wj3nextBtn.png"), for: .normal)
        //이전 화면으로 데이터 보내기 위함
        sTime = self.times[row]
        
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker() {
        self.startTime.text = nil
        self.startTime.resignFirstResponder()
        
        finalBtn.isEnabled = false
        finalBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        //이전 화면으로 데이터 보내기 위함
        sTime = ""
        
    }
    //완료 시간
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker2() {
        let row2 = self.picker2.selectedRow(inComponent: 0)
        self.picker2.selectRow(row2, inComponent: 0, animated: false)
        self.finTime.text = self.times2[row2]
        self.finTime.resignFirstResponder()
        
        finalBtn.isEnabled = true
        finalBtn.setImage(UIImage(named: "wj3nextBtn.png"), for: .normal)
        //이전 화면으로 데이터 보내기 위함
        fTime = self.times2[row2]
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker2() {
        self.finTime.text = nil
        self.finTime.resignFirstResponder()
        
        finalBtn.isEnabled = false
        finalBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
        fTime = ""
        
    }
    
    //입금 설정
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
        finalBtn.setImage(UIImage(named: "wj3nextBtn.png"), for: .normal)
        finalBtn.isEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        howMoney.setTitle(dataSource[indexPath.row], for: .normal)
        deposit = dataSource[indexPath.row]
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
            self.tableView.frame = CGRect(x:frames.origin.x, y: frames.origin.y + 280, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    @objc func removeTransparentView(){
        let frames = howMoney.frame
        UIView.animate(withDuration: 0.4, delay: 0.0,usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0
             self.tableView.frame = CGRect(x:frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    //입금 방법
    @IBAction func selectDeposit(_ sender: Any) {
        dataSource = ["시급", "일급"]
        addTransparentView(frames: howMoney.frame)
    }
    
    //월
    @IBAction func clickMon(_ sender: UIButton) {
        if(num[0] == 0){
            monBtn.setImage(UIImage(named: "fillmon.png"), for: .normal)
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
            tuesBtn.setImage(UIImage(named: "filltues.png"), for: .normal)
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
            wedBtn.setImage(UIImage(named: "fillwed.png"), for: .normal)
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
            thrBtn.setImage(UIImage(named: "fillthr.png"), for: .normal)
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
            friBtn.setImage(UIImage(named: "fillfri.png"), for: .normal)
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
            satBtn.setImage(UIImage(named: "fillsat.png"), for: .normal)
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
            sunBtn.setImage(UIImage(named: "fillsun.png"), for: .normal)
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
            tPosBtn.setImage(UIImage(named: "checkOk.png"), for: .normal)
            isCheck2 = true
        }
        else {
            tPosBtn.setImage(UIImage(named: "checkBox.png"), for: .normal)
            isCheck2 = false
        }
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        let preVC = self.presentingViewController
        
        guard let vc = preVC as? JobOfferWrite else {
            return
        }
        for num in 0...6{
            if(sWeek[num] != ""){
                sDay += sWeek[num]
                sDay += " "
            }
        }
        finData1 = moneyText.text! + "원"
        finData2 = "[" + deposit! + "]"
        
        fin = sDay + "," + sTime! + "~" + fTime! + "," + finData2 + "," + finData1
        //요일,시간~시간,[시급],돈(원)
        
        vc.workInfo = self.fin
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func gotoBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }


}
extension UIViewController {
    func hideKeyboardt1() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboardt1() {
        view.endEditing(true)
    }
}
