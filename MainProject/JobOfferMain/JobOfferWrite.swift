//
//  JobOfferWrite.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/14.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import YPImagePicker

class JobOfferWrite: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    //상단 타이틀 설정
    @IBOutlet weak var mTitle: UILabel!
    
    //정보 불러오기 타이틀
    @IBOutlet weak var loadTitle: UILabel!
    
    //글 제목 텍스트필드
    @IBOutlet weak var txtMyTitle: UITextField!
    
    //업직종 텍스트필드
    @IBOutlet weak var selectJobTxt: UITextField!
    var selectJob: String?
    
    //위치 텍스트 필드
    @IBOutlet weak var locationTxt: UITextField!
    var locationInfo : String?
    //주소 url 텍스트 필드
    @IBOutlet weak var locUrlTxt: UITextField!
    
    //자격요건 텍스트 필드
    @IBOutlet weak var wantTxt: UITextField!
    
    //근무정보 텍스트 필드
    @IBOutlet weak var howWork: UITextField!
    var workInfo: String?
    
    //태그 텍스트 필드
    @IBOutlet weak var tagTxt: UITextField!
    var tagInfo: String?
    
    //상세 글 텍스트
    @IBOutlet weak var detailTxt: UITextView!
    
    //앨범 이미지 불러오기 버튼
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet private var collectionView: UICollectionView!
    private var selectedImages: [UIImage] = []
    private let imgIdentifier: String = "imgIdentifier"
    private let btnIdentifier: String = "btnIdentifier"
    
    //back 버튼(닫기)
    @IBOutlet weak var backBtn: UIButton!
    //finish 버튼(완료)
    @IBOutlet weak var finBtn: UIButton!
    
    //업직종 버튼
    @IBOutlet weak var sJobBtn: UIButton!
    //근무정보 버튼
    @IBOutlet weak var howWorkBtn: UIButton!
    //태그 이동 버튼
    @IBOutlet weak var tagBtn: UIButton!
    //최종 준수사항 버튼
    @IBOutlet weak var fCheckBtn: UIButton!
    var isChecked = false
    
    var ref: DatabaseReference!
    var key: String?
    var myTitle: String?
    var jobTxt: String?
    var locTxt: String?
    var locUrl: String?
    var wTxt: String?
    var howTxt: String?
    var tagMy: String?
    var deTxt: String?
    
    let userID = Auth.auth().currentUser!.uid
    let uEmail = Auth.auth().currentUser!.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 5 //cell 간의 간격
        //flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: 68, height: 68)

        collectionView = UICollectionView(frame: CGRect(x: 20, y: 70, width: 500, height: 90), collectionViewLayout: flowLayout) //collectionView 위치, 크기
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(1)
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(ImageCell2.self, forCellWithReuseIdentifier: imgIdentifier)
        collectionView.register(ButtonCell2.self, forCellWithReuseIdentifier: btnIdentifier)
        collectionView.contentInset.top = max((collectionView.frame.height - collectionView.contentSize.height)/15, 0)
        collectionView.contentInset.left = max((collectionView.frame.height - collectionView.contentSize.height)/15, 0)
        view1.addSubview(collectionView)

        //이미지버튼(loadBtn) 클릭 액션 설정
        loadBtn.addTarget(self, action: #selector(onLoadBtnClicked), for: .touchUpInside)
        
        hideKeyboard2()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let job = selectJob {
            selectJobTxt.text = job
        }
        if let work = workInfo{ //시급
            howWork.text = work
        }
        if let tag = tagInfo{
            tagTxt.text = tag
        }
        if let loc = locationInfo{
            locationTxt.text = loc
        }
    }
    
    @objc fileprivate func onLoadBtnClicked(){
        print("JobSearchWrite - onLoadBtnClicked() called")
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 4
        
        let picker = YPImagePicker(configuration: config)
        //사진이 선택 되었을때
        picker.didFinishPicking { [unowned picker] items, cancelled in
            self.selectedImages = []

            // 여러 이미지를 넣어주기 위해 하나씩 넣어주는 반복문
                for item in items {
                    switch item {
                        // 이미지만 받기때문에 photo case만 처리
                        case .photo(let photo):
                        // 이미지를 해당하는 이미지 배열에 넣어주는 code
                            self.selectedImages.append(photo.image)
                            picker.dismiss(animated: true, completion: nil)
                        default:
                            print("")
                    }
                }
            picker.dismiss(animated: true){
                self.collectionView.reloadData()
            }
        }
        // picker뷰 present
        present(picker, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count + 1//여기
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if /*indexPath.item == selectedImages.count || */indexPath.item == 0 {
            let cell: ButtonCell2 = collectionView.dequeueReusableCell(withReuseIdentifier: btnIdentifier, for: indexPath) as! ButtonCell2
            cell.loadBtn.image("JobSearchWriteLoadBtn")
            cell.loadBtn.addTarget(self, action: #selector(onLoadBtnClicked), for: .touchUpInside)
            return cell
        }else{
            let cell: ImageCell2 = collectionView.dequeueReusableCell(withReuseIdentifier: imgIdentifier, for: indexPath) as! ImageCell2
            cell.image.image = selectedImages[indexPath.item - 1]
            cell.isUserInteractionEnabled = false
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.row == selectedImages.count {
                onLoadBtnClicked()
            }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    }
    
    @objc private func addNewEntry() {
        myTitle = txtMyTitle.text
        jobTxt = selectJobTxt.text
        locTxt = locationTxt.text
        locUrl = locUrlTxt.text
        wTxt = wantTxt.text
        howTxt = howWork.text
        tagMy = tagTxt.text
        deTxt = detailTxt.text
        
        let fullHowArr = howTxt!.split(separator: ",")
        let fullTagArr = tagMy!.split(separator: ",")
        
        //요일, 요일, 시간 ~ 시간 [시급]돈(원)
        //파이어베이스에 정보 올리기
        ref = Database.database().reference()
        key = ref.childByAutoId().key //String
        self.ref.child("구인글작성").child(userID).child("글제목").setValue(myTitle)
        self.ref.child("구인글작성").child(userID).child("업직종").setValue(jobTxt)
        self.ref.child("구인글작성").child(userID).child("근무지").setValue(locTxt)
        self.ref.child("구인글작성").child(userID).child("매장url").setValue(locUrl)
        self.ref.child("구인글작성").child(userID).child("자격요건").setValue(wTxt)
        self.ref.child("구인글작성").child(userID).child("근무요일").setValue(fullHowArr[0])
        self.ref.child("구인글작성").child(userID).child("근무시간").setValue(fullHowArr[1])
        self.ref.child("구인글작성").child(userID).child("지급방법").setValue(fullHowArr[2])
        self.ref.child("구인글작성").child(userID).child("지급요금").setValue(fullHowArr[3])
        self.ref.child("구인글작성").child(userID).child("태그1").setValue(fullTagArr[0])
        self.ref.child("구인글작성").child(userID).child("태그2").setValue(fullTagArr[1])
        self.ref.child("구인글작성").child(userID).child("태그3").setValue(fullTagArr[2])
        self.ref.child("구인글작성").child(userID).child("상세글").setValue(deTxt)
        self.ref.child("구인글작성").child(userID).child("이메일").setValue(uEmail)
        
        //구인글 리스트뷰 파이어베이스 정보
        self.ref.child("구인리스트").child(userID).child("글제목").setValue(myTitle)
        self.ref.child("구인리스트").child(userID).child("근무요일시간").setValue(fullHowArr[0]+fullHowArr[1])
        self.ref.child("구인리스트").child(userID).child("근무지").setValue(locTxt)
        self.ref.child("구인리스트").child(userID).child("지급방법").setValue(fullHowArr[2])
        self.ref.child("구인리스트").child(userID).child("지급요금").setValue(fullHowArr[3])
        self.ref.child("구인리스트").child(userID).child("태그1").setValue(fullTagArr[0])
        self.ref.child("구인리스트").child(userID).child("태그2").setValue(fullTagArr[1])
        self.ref.child("구인리스트").child(userID).child("태그3").setValue(fullTagArr[2])
        self.ref.child("구인리스트").child(userID).child("리스트연결").setValue(userID)
        
        self.ref.child("구인리스트지도").child(userID).child("post").child("글제목").setValue(myTitle)
        self.ref.child("구인리스트지도").child(userID).child("post").child("근무요일시간").setValue(fullHowArr[0]+fullHowArr[1])
        self.ref.child("구인리스트지도").child(userID).child("post").child("근무지").setValue(locTxt)
        self.ref.child("구인리스트지도").child(userID).child("post").child("지급방법").setValue(fullHowArr[2])
        self.ref.child("구인리스트지도").child(userID).child("post").child("지급요금").setValue(fullHowArr[3])
        self.ref.child("구인리스트지도").child(userID).child("post").child("태그1").setValue(fullTagArr[0])
        self.ref.child("구인리스트지도").child(userID).child("post").child("태그2").setValue(fullTagArr[1])
        self.ref.child("구인리스트지도").child(userID).child("post").child("태그3").setValue(fullTagArr[2])
        self.ref.child("구인리스트지도").child(userID).child("post").child("리스트연결").setValue(userID)
        
        //구인글연결(근로) 파이어베이스
        self.ref.child("구인글연결(근로)").child(userID).child("post").child("글제목").setValue(myTitle)
        self.ref.child("구인글연결(근로)").child(userID).child("post").child("근무요일시간").setValue(fullHowArr[0]+fullHowArr[1])
        self.ref.child("구인글연결(근로)").child(userID).child("post").child("근무지").setValue(locTxt)
        self.ref.child("구인글연결(근로)").child(userID).child("post").child("지급방법").setValue(fullHowArr[2])
        self.ref.child("구인글연결(근로)").child(userID).child("post").child("지급요금").setValue(fullHowArr[3])
        self.ref.child("구인글연결(근로)").child(userID).child("post").child("태그1").setValue(fullTagArr[0])
        self.ref.child("구인글연결(근로)").child(userID).child("post").child("태그2").setValue(fullTagArr[1])
        self.ref.child("구인글연결(근로)").child(userID).child("post").child("태그3").setValue(fullTagArr[2])
        self.ref.child("구인글연결(근로)").child(userID).child("post").child("리스트연결").setValue(userID)
        
        //지도 마커
        self.ref.child("채팅구인마커").child(userID).child("근무지").setValue(locTxt)
        self.ref.child("채팅구인마커").child(userID).child("리스트연결").setValue(userID)
    }
    
    @IBAction func clickFinal(_ sender: UIButton) {
        if((txtMyTitle.text!.count > 1) && (selectJobTxt.text!.count > 1) && (locationTxt.text!.count > 1) &&
           (locUrlTxt.text!.count > 1) && (wantTxt.text!.count > 1) && (howWork.text!.count > 1) && (tagTxt.text!.count > 1) && (detailTxt.text!.count > 1)){
            if(isChecked == false){
                fCheckBtn.setImage(UIImage(named: "sCheckonePurple.png"), for: .normal)
                finBtn.setImage(UIImage(named: "wjnextBtn.png"), for: .normal)
                isChecked = true
            }
            else if(isChecked == true){
                fCheckBtn.setImage(UIImage(named: "sCheckone.png"), for: .normal)
                finBtn.setImage(UIImage(named: "xjnextBtn.png"), for: .normal)
                isChecked = false
            }
        }
        else{
            self.showToast(message: "내용 입력을 완료해주세요.")
        }

    }
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 16.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 85, y: self.view.frame.size.height-100, width: 170, height: 35))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.red
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: { toastLabel.alpha = 0.0
            
        }, completion: {(isCompleted) in toastLabel.removeFromSuperview() })
        
    }

    //닫기 기능
    @IBAction func goBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func finWritePage(_ sender: Any) {
        addNewEntry()
        self.presentingViewController?.dismiss(animated: true)
    }
    
}

class ImageCell2: UICollectionViewCell {
    var image: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        //super.backgroundColor = UIColor.yellow
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: 68, height: 68)) //선택된 이미지(Cell Content의 위치(이건 UICollectionViewCell 클래스가 기준이 됨 CV가 아니라))
        image.layer.cornerRadius = 4.0
        image.layer.masksToBounds = true

        layer.cornerRadius = 4.0
        layer.masksToBounds = false

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 4

        addSubview(image)
    }
}

class ButtonCell2: UICollectionViewCell {
    var loadBtn: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        //super.backgroundColor = UIColor.yellow
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        loadBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 68, height: 68)) //선택된 이미지(Cell Content의 위치(이건 UICollectionViewCell 클래스가 기준이 됨 CV가 아니라))
        loadBtn.layer.cornerRadius = 4.0
        loadBtn.layer.masksToBounds = true

        layer.cornerRadius = 4.0
        layer.masksToBounds = false

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 4

        addSubview(loadBtn)
    }
}

extension UIViewController {
    func hideKeyboard2() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard2() {
        view.endEditing(true)
    }
}
