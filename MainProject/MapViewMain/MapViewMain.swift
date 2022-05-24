//
//  MapViewMain.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/18.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseDatabase
import NMapsMap
import Alamofire
import SwiftyJSON


class MapViewMain: UIViewController, CLLocationManagerDelegate{
    
    //상단뷰
    @IBOutlet weak var topView: UIView!

    //현재 위치 레이블
    @IBOutlet weak var myLocLabel: UILabel!
    //위치검색 버튼
    @IBOutlet weak var locBtn: UIButton!
    
    //지역이동 버튼
    @IBOutlet weak var movLocationBtn: UIButton!
    //리스트뷰 이동 버튼
    @IBOutlet weak var gotoListView: UIButton!
    //글쓰기 이동 버튼
    @IBOutlet weak var goWriteBtn: UIButton!
    
    //지도를 넣을 뷰
    @IBOutlet weak var mainMapView: UIView!
    @IBOutlet weak var uidTextLabel: UILabel!
    @IBOutlet weak var uidTextLabel2: UILabel!
    
//    var mark = [Marker]()

    var locationManager = CLLocationManager()
    
    let NAVER_CLIENT_ID = "hfwfh4mxps"
    let NAVER_CLIENT_SECRET = "ZI0asGXAIiHrRB7ZRSwM3Y9w11IEKOnUey4DSBTv"
    let NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
    
    var locSearch: DatabaseReference!
    var locOffer: DatabaseReference!
    var locList = [LocModel]()
    //var markList = [MarkModel]()
    var locMark : String? = ""// 변수형 문자열 배열
    var newlat : Double?
    var newlon : Double?
    var userId : String? //사용자 uid

    override func viewDidLoad() {
        super.viewDidLoad()
        //네이버 지도 넣기
        
        let mapView = NMFMapView(frame: view.frame)
        mainMapView.addSubview(mapView)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            print(locationManager.location?.coordinate)
            //현 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)

        } else {
            print("위치 서비스 Off 상태")
        }

        //리스트뷰이동버튼 그림자
        gotoListView.setFloatingStyle()
        
        //지역이동버튼 그림자
        movLocationBtn.setFloatingStyle()
        
        //글쓰기이동버튼 그림자
        goWriteBtn.setFloatingStyle()
        
        goWriteBtn.addTarget(self, action: #selector(goAlert), for: .touchUpInside)
        
        //글로 쓴 지역을 위도,경도 형태로 변경
        ChangeLocation(mapView: mapView)
        ChangeLocation2(mapView: mapView)
        
    }
    
    //구직의 경우
    func ChangeLocation(mapView : NMFMapView){
        locSearch = Database.database().reference().child("채팅구직마커")
        locSearch.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{

                for 채팅구직마커 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects2 = 채팅구직마커.value as? [String: AnyObject]
                    let obLoc = itemObjects2?["근무가능위치"] as? String ?? ""
                    //사용자 키 받아오기
                    let obUserKey = itemObjects2?["리스트연결"] as? String ?? ""
                    
                    let fullLocArr = obLoc.split(separator: "/")
                    let Loc = String(fullLocArr[0]) + "시 " + String(fullLocArr[1]) + " " + String(fullLocArr[2])
                    
                    self.locMark = Loc
                    self.uidTextLabel.text = obUserKey
                    
                    let encodeAddress = self.locMark!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                    
                    let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: self.NAVER_CLIENT_ID)
                    let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: self.NAVER_CLIENT_SECRET)
                    let headers = HTTPHeaders([header1,header2])
                    
                    AF.request(self.NAVER_GEOCODE_URL + encodeAddress, method: .get,headers: headers).validate()
                        .responseJSON { [self] response in
                                switch response.result {
                                case .success(let value as [String:Any]):
                                    let json = JSON(value)
                                    let data = json["addresses"]
                                    let lat = data[0]["y"]
                                    let lon = data[0]["x"]
                                    print("위도는",lat,"경도는",lon)
                                    
                                    self.newlat = NumberFormatter().number(from: lat.rawValue as! String)?.doubleValue
                                    self.newlon = NumberFormatter().number(from: lon.rawValue as! String)?.doubleValue
                                    
                                    self.makeMarker1(mapView: mapView, userI: uidTextLabel.text!)
                                    
                                case .failure(let error):
                                    print(error.errorDescription ?? "")
                                default :
                                    fatalError()
                        }
                    }
                    
                
                }
                    
            }
        })
            
    }
    
    func makeMarker1(mapView : NMFMapView, userI : String ){
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: self.newlat!, lng: self.newlon!)
        marker.iconImage = NMFOverlayImage(name: "markerIcon1")
        marker.width = 36
        marker.height = 42.8
        marker.mapView = mapView
        
        // 터치 이벤트 설정
        marker.touchHandler = { (overlay) -> Bool in
          print("마커 터치")
            self.goAlert2(user: userI )
          return true
        }
    }
    
    //구인의 경우
    func ChangeLocation2(mapView : NMFMapView){
        locOffer = Database.database().reference().child("채팅구인마커")
        locOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{

                for 채팅구인마커 in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects2 = 채팅구인마커.value as? [String: AnyObject]
                    let obLoc = itemObjects2?["근무지"] as? String ?? ""
                    print(obLoc)
                    //사용자 키 받아오기
                    let obUserKey = itemObjects2?["리스트연결"] as? String ?? ""
                    print(obUserKey)
                    
                    let fullLocArr = obLoc.split(separator: "/")
                    let Loc = String(fullLocArr[0]) + "시 " + String(fullLocArr[1]) + " " + String(fullLocArr[2])
                    
                    self.locMark = Loc
                    self.uidTextLabel2.text = obUserKey
                    
                    let encodeAddress = self.locMark!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                    
                    let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: self.NAVER_CLIENT_ID)
                    let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: self.NAVER_CLIENT_SECRET)
                    let headers = HTTPHeaders([header1,header2])
                    
                    AF.request(self.NAVER_GEOCODE_URL + encodeAddress, method: .get,headers: headers).validate()
                        .responseJSON { [self] response in
                                switch response.result {
                                case .success(let value as [String:Any]):
                                    let json = JSON(value)
                                    let data = json["addresses"]
                                    let lat = data[0]["y"]
                                    let lon = data[0]["x"]
                                    print("구인위도는",lat,"경도는",lon)
                                    
                                    self.newlat = NumberFormatter().number(from: lat.rawValue as! String)?.doubleValue
                                    self.newlon = NumberFormatter().number(from: lon.rawValue as! String)?.doubleValue
                                    
                                    self.makeMarker2(mapView: mapView, userI: uidTextLabel2.text!)
                                    
                                case .failure(let error):
                                    print(error.errorDescription ?? "")
                                default :
                                    fatalError()
                        }
                    }
                }
                    
            }
        })
            
    }
    
    func makeMarker2(mapView : NMFMapView, userI : String){
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: self.newlat!, lng: self.newlon!)
        marker.iconImage = NMFOverlayImage(name: "markerIcon2.png")
        marker.width = 36
        marker.height = 42.8
        marker.mapView = mapView
        
        // 터치 이벤트 설정
        marker.touchHandler = { (overlay) -> Bool in
          print("마커 터치")
            self.goAlert3(user: userI)
          return true
        }
    }
    
    
    @objc func goAlert(){
            let alert = self.storyboard?.instantiateViewController(withIdentifier: "WriteAlterView") as! WriteAlterView
            alert.modalPresentationStyle = .overCurrentContext
            alert.modalTransitionStyle = .crossDissolve
            present(alert, animated: false, completion: nil)
    }
    
    //구직글 인포로
    func goAlert2(user : String){
        guard let alert2 = self.storyboard?.instantiateViewController(withIdentifier: "MarkerInfoWindow") as? MarkerInfoWindow else {return}
        alert2.userID = user
        alert2.modalPresentationStyle = .overCurrentContext
        present(alert2, animated: true, completion: nil)
    }
    
    //구인글 인포로
    func goAlert3(user : String){
        guard let alert2 = self.storyboard?.instantiateViewController(withIdentifier: "MarkerInfoWindow2") as? MarkerInfoWindow2 else {return}
        alert2.userID = user
        alert2.modalPresentationStyle = .overCurrentContext
        present(alert2, animated: true, completion: nil)
    }
    
    //위치설정하러 버튼
    @IBAction func goLocationSelect(_ sender: Any) {
        guard let locVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationFind") else { return }
        self.navigationController?.pushViewController(locVC, animated: true)
    }

}


extension UIView {
    func setFloatingStyle() {
        setShadow(color: .black, alpha: 0.2, xPoint: 0, yPoint: 6, blur: 10, spread: 0)
    }

    func setShadow(color: UIColor = .black,
                   alpha: Float,
                   xPoint: CGFloat,
                   yPoint: CGFloat,
                   blur: CGFloat,
                   spread: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: xPoint, height: yPoint)
        layer.shadowRadius = blur / 2.0
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let diffx = -spread
            let rect = layer.bounds.insetBy(dx: diffx, dy: diffx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
