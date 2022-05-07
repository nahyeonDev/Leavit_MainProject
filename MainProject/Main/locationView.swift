//
//  locationView.swift
//  MainProject
//
//  Created by 김나현 on 2022/03/24.
//

import UIKit
import CoreLocation

class locationView: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    var lat : Double?  //위도
    var long : Double?  //경도
    
    @IBOutlet weak var locationTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //델리게이트 설정
        locationManager.delegate = self
        //거리 정확도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //사용자에게 허용 받기 alert 띄우기
        locationManager.requestWhenInUseAuthorization()
        //위치 업데이트
        locationManager.startUpdatingLocation()
        //위도 경도 가져오기
        let coor = locationManager.location?.coordinate
        lat = coor?.latitude
        long = coor?.longitude
        
    }
    
    @IBAction func currentLoc(_ sender: Any) {
        //현재 위치인 위도, 경도를 주소 형태로 변형
        let findLocation = CLLocation(latitude: lat!, longitude: long!)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks { if let name: String = address.last?.name {
                self.locationTxt.text = name
                print(name)
            } //전체 주소
            
        } })
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let preVC = self.presentingViewController
        
        guard let vc = preVC as? SignUpDetail else {
            return
        }
        vc.loc = self.locationTxt.text!
        
        self.presentingViewController?.dismiss(animated: true)
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
