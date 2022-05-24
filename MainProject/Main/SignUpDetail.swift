//
//  SignUpDetail.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/14.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import MLKitTextRecognitionKorean
import MLKitVision

class SignUpDetail: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameTextfield: UITextField! //이름 텍스트필드
    @IBOutlet weak var resTextfield1: UITextField!
    @IBOutlet weak var resTextfield2: UITextField!
    @IBOutlet weak var locTextfield: UITextField!
    @IBOutlet weak var schoolName: UITextField! //학교명
    @IBOutlet weak var majorName: UITextField! //학과명
    @IBOutlet weak var schoolNum: UITextField! //학번
    
    let picker = UIPickerView()
    let picker2 = UIPickerView()
    
    let school = ["서울여자대학교",]
    let major = ["디지털미디어학과", "경영학과", "패션산업학과", "정보보호학과", "소프트웨어융합학과", "데이터사이언스학과", "산업디자인학과",]
    
    var keyNumber : String? //사용자 키 값 받아오기
    var cusKeyNum : String?
    var name : String? //이름
    var resNum : String? //주민등록번호(앞)
    var resNum2 : String? //주민등록번호(뒤)
    var sch : String? //학교
    var maj : String? //학과(전공)
    var schNum : String? //학번
    var loc : String? //위치
    var gen : String? //성별
    var age : String? //나이
    var num4 : Int? //나이계산
    
    let db = Firestore.firestore()
    let pickerImage = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView! //학생증 사진
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //picker 설정
        schoolName.tintColor = .clear
        majorName.tintColor = .clear
        configPickerView()
        configToolbar()
        
        self.cusKeyNum = keyNumber
        
        resTextfield1.delegate = self
        resTextfield2.delegate = self
        pickerImage.delegate = self
        
        locTextfield.delegate = self
        // Register Keyboard notifications
        // addObserver를 통해 옵저버를 설정할 대상을 뷰컨트롤러 객체(self)로 지정
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillHide(_:)),
                                                name: UIResponder.keyboardWillHideNotification,
                                                object: nil)
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(keyboardWillShow(_:)),
                                                name: UIResponder.keyboardWillShowNotification,
                                                object: nil)
        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    //키보드 올라갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillShow(_ sender:Notification){
            self.mainView.frame.origin.y = -200
    }
    //키보드 내려갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillHide(_ sender:Notification){
            self.mainView.frame.origin.y = 0
    }
    override func viewWillAppear(_ animated: Bool) {

        if let loc = loc {
            locTextfield.text = loc
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameTextfield.resignFirstResponder()
        self.resTextfield1.resignFirstResponder()
        self.resTextfield2.resignFirstResponder()
        self.schoolNum.resignFirstResponder()
        self.locTextfield.resignFirstResponder()
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//            self.emailTextfield.resignFirstResponder()
//            return true
//    }
    
    //delegate, datasource 연결, picker를 textField의 inputview로 설정
    func configPickerView() {
        picker.delegate = self
        picker.dataSource = self
        picker2.delegate = self
        picker2.dataSource = self
        schoolName.inputView = picker
        majorName.inputView = picker2
    }
    // pickerview는 하나만
    public func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    // pickerview의 선택지는 데이터의 개수만큼
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == picker){
            return school.count
        }
        else{
            return major.count
        }
    }
    // pickerview 내 선택지의 값들을 원하는 데이터로 채워준다.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == picker){
            return school[row]
        }
        else{
            return major[row]
        }
    }
    // textfield의 텍스트에 pickerview에서 선택한 값을 넣어준다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == picker){
            self.schoolName.text = self.school[row]
        }
        else{
            self.majorName.text = self.major[row]
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
        
        // 만들어줄 버튼 //학교명 버전
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        // flexibleSpace는 취소~완료 간의 거리를 만들어준다.
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        // 만든 아이템들을 세팅해주고
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        toolBar.isUserInteractionEnabled = true
        // 악세사리로 추가한다.
        schoolName.inputAccessoryView = toolBar
        
        // 만들어줄 버튼 // 완료 시간 버전
        let doneBT2 = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker2))
        // flexibleSpace는 취소~완료 간의 거리를 만들어준다.
        let flexibleSpace2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT2 = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker2))
        // 만든 아이템들을 세팅해주고
        toolBar2.setItems([cancelBT2,flexibleSpace2,doneBT2], animated: false)
        toolBar2.isUserInteractionEnabled = true
        // 악세사리로 추가한다.
        majorName.inputAccessoryView = toolBar2
    }
    //학교명
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.schoolName.text = self.school[row]
        self.schoolName.resignFirstResponder()
        
        sch = self.school[row]
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker() {
        self.schoolName.text = nil
        self.schoolName.resignFirstResponder()
        
        sch = ""
    }
    //학과(전공)명
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker2() {
        let row2 = self.picker2.selectedRow(inComponent: 0)
        self.picker2.selectRow(row2, inComponent: 0, animated: false)
        self.majorName.text = self.major[row2]
        self.majorName.resignFirstResponder()
        
        maj = self.major[row2]
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker2() {
        self.majorName.text = nil
        self.majorName.resignFirstResponder()
        
        maj = ""
    }
    
    @IBAction func backBtn3(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func goNextView(_ sender: UIButton) {
        name = nameTextfield.text
        resNum = resTextfield1.text
        resNum2 = resTextfield2.text
        let num2 = resNum2![resNum2!.startIndex] //성별
        let num3 = resNum!.dropLast(4) //나이
        schNum = schoolNum.text
        loc = locTextfield.text
        
        if(num2 == "2" || num2 == "4"){
            gen = "여"
            if(num2 == "2"){
                num4 = Int("19" + num3)
                let ageNum = 2022 - num4!  //나이계산(만 나이로 계산)
                age = "만 " + String(ageNum) + "세"
            }
            else if(num2 == "4"){
                num4 = Int("20" + num3)
                let ageNum2 = 2022 - num4!  //나이계산(만 나이로 계산)
                age = "만 " + String(ageNum2) + "세"
            }
        }else{
            gen = "남"
            if(num2 == "1"){
                num4 = Int("19" + num3)
                let ageNum3 = 2022 - num4!  //나이계산(만 나이로 계산)
                age = "만 " + String(ageNum3) + "세"
            }
            else if(num2 == "3"){
                num4 = Int("20" + num3)
                let ageNum4 = 2022 - num4!  //나이계산(만 나이로 계산)
                age = "만 " + String(ageNum4) + "세"
            }
        }
        
        // navigation controller 로 화면 전환
        db.collection("가입개인정보").document(cusKeyNum!).setData(["이름" : name!, "주민등록번호(앞)" : resNum!, "학교" : sch!, "학과" : maj!, "학번" : schNum!, "학생증" : "0", "위치" : loc!, "이메일" : cusKeyNum!, "성별" : gen!, "나이" : age!])
          guard let hopeVC = self.storyboard?.instantiateViewController(withIdentifier: "hopeWorkController")as? HopeWorkView else { return }
        
          hopeVC.keyNumber2 = self.cusKeyNum!
          self.navigationController?.pushViewController(hopeVC, animated: true)
    }
    
    @IBAction func golocationSet(_ sender: Any) {
        guard let locVC = self.storyboard?.instantiateViewController(withIdentifier: "locationView") else { return }
        
        self.navigationController?.pushViewController(locVC, animated: true)
    }
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    @IBAction func regisNumSet1(_ sender: UITextField) {
        checkMaxLength(textField: resTextfield1, maxLength: 6)
    }
    
    @IBAction func regisNumSet2(_ sender: UITextField) {
        checkMaxLength(textField: resTextfield2, maxLength: 7)
    }
    
    //사진인식 - 학생증
    func getText(image: UIImage) {
        let koreanOptions = KoreanTextRecognizerOptions()
        let textRecognizer = TextRecognizer.textRecognizer(options: koreanOptions)
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        textRecognizer.process(visionImage) { result, error in
            guard error == nil, let result = result else {
                //error handling
                return

            }
            //결과값 출력
            let resText = result.text
            print(result.text)
            let arr1 = self.majorName.text!
            let maj = arr1.replacingOccurrences(of: "학과", with: "")
            let arr2 = self.schoolName.text!
            let sch = arr2.replacingOccurrences(of: "학교", with: "")
            
            //실제 작성 내용과 학생증이 같은지 확인
            if(resText.contains(self.nameTextfield.text!)){
                print("이름일치O")
            }
            else{
                print("이름일치X")
            }
            if(resText.contains(maj)){
                print("학과일치O")
            }
            else{
                print("학과일치X")
            }
            if(resText.contains(sch)){
                print("학교일치O")
            }
            else{
                print("학교일치X")
            }
            if(resText.contains(self.schoolNum.text!)){
                print("학번일치O")
            }
            else{
                print("학번일치X")
            }
            
            if(resText.contains(self.nameTextfield.text!)&&resText.contains(maj)&&resText.contains(sch)&&resText.contains(self.schoolNum.text!)){
                
                let alert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlterCheck") as! CustomAlterCheck
                alert.modalPresentationStyle = .overCurrentContext
                alert.modalTransitionStyle = .crossDissolve
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                
            }
    
        }

    }

    @IBAction func getImageFile(_ sender: UIButton) {
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()

        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
        self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)

        }
    func openLibrary(){
      pickerImage.sourceType = .photoLibrary
      present(pickerImage, animated: false, completion: nil)
    }

    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            pickerImage.sourceType = .camera
            present(pickerImage, animated: false, completion: nil)
        }
        else{
            print("Camera not available")

        }
    }

}
extension SignUpDetail : UIImagePickerControllerDelegate,

UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                imageView.image = image
                getText(image: imageView.image!) //사진인식
            }
            dismiss(animated: true, completion: nil)
    }


}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
