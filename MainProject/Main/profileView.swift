//
//  profileView.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/15.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class profileView: UIViewController{

    @IBOutlet weak var picPlusBtn: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var keyNumbers: String? //사용자 키 값 받아오기
    var cusKeyNum5: String?
    let db = Firestore.firestore()
    let pickerImage = UIImagePickerController()
    let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusKeyNum5 = keyNumbers
        defaultName()
        
        pickerImage.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
            self.nameTextfield.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.nameTextfield.resignFirstResponder()
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goNext(_ sender: UIButton) {
        let nameT = nameTextfield.text
        db.collection("가입개인정보").document(cusKeyNum5!).updateData(["이름" : nameT!])
        
        uploadImage(img: imageView.image!)
        
        // navigation controller 로 화면 전환
          guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "tutorialView") else { return }
          self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func defaultName(){
        let docRef = self.db.collection("가입개인정보").document(self.cusKeyNum5!)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"] as! String
                
                self.nameTextfield.text = obName
 
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func delTxt(_ sender: Any) {
        nameTextfield.text = ""
    }
    
    @IBAction func imageViewSelect(_ sender: UIButton) {
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
    
    public func uploadImage(img: UIImage){
        let email = cusKeyNum5!.replacingOccurrences(of: "@", with: "-")
        let safeEmail = email
        let filename = safeEmail + "_profile_picture.png"
        print(filename)
        let path = "userProfile/" + filename
        
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        storage.child(path).putData(data, metadata: nil, completion: { [weak self] metadata, error in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    // failed
                    print("failed to upload data to firebase for picture")
                    return
                }
                
//                strongSelf.storage.child(path).downloadURL { url, error in
//                    guard let url = url else {
//                        print("Failed to get download url")
//                        return
//                    }
//                    let urlString = url.absoluteString
//                    print("download url returned: \(urlString)")
//                }
            })
        
    }

}

extension profileView : UIImagePickerControllerDelegate,

UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                imageView.image = image
                imageView.contentMode = .scaleAspectFill
                imageView.layer.cornerRadius = imageView.frame.width / 2
                imageView.clipsToBounds = true
            }
            dismiss(animated: true, completion: nil)
    }


}
