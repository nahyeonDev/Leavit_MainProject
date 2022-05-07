//
//  MapLocationFind.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/20.
//

import UIKit
import CoreLocation

class MapLocationFind: UIViewController, CLLocationManagerDelegate  {
    
    var locationManager = CLLocationManager()
    
    var lat : Double?  //위도
    var long : Double?  //경도
    
    @IBOutlet weak var backBtn: UIButton!
    //검색으로 위치 찾기
    @IBOutlet weak var findLocationText: UITextField!
    //버튼으로 현재 위치 찾기
    @IBOutlet weak var findBtn: UIButton!
    
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
    
    //디폴트로 배치되는 뒤로가기 버튼 삭제
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func findCurrentLoc(_ sender: Any) {
        //현재 위치인 위도, 경도를 주소 형태로 변형
        let findLocation = CLLocation(latitude: lat!, longitude: long!)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks { if let name: String = address.last?.name {
                self.findLocationText.text = name
                print(name)
            } //전체 주소
            
        } })
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
