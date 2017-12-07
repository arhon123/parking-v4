import UIKit
import MapKit
import CoreLocation

class SingleMapTableViewController: UITableViewController, CLLocationManagerDelegate {

    var sItem:[String:String] = [:]
    var locationManager: CLLocationManager!
    
    var annotations = [MKPointAnnotation]()
    
    var coordinatesT = MKPointAnnotation()
    
    @IBOutlet weak var singleMapView: MKMapView!
    @IBOutlet weak var sMealDay: UITableViewCell!
    @IBOutlet weak var sTarget: UITableViewCell!
    @IBOutlet weak var sManageNm: UITableViewCell!
    @IBOutlet weak var sPhone: UITableViewCell!
    @IBOutlet var SParkingName: UITableViewCell!
    
    @IBOutlet var ddd: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        ddd.title = "네비"
        // 현재 위치 트랙킹
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        // 지도에 현재 위치 마크를 보여줌
        singleMapView.showsUserLocation = true
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(sItem["addrJibun"]! , completionHandler: { placemarks, error in
            if error != nil {
                print(error!)
                return
            }
            
            if let myPlacemarks = placemarks {
                let myPlacemark = myPlacemarks[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = self.sItem["parkingName"]!
                
                if let myLocation = myPlacemark.location {
                    annotation.coordinate = myLocation.coordinate
                    self.coordinatesT.coordinate = myLocation.coordinate
                    self.annotations.append(annotation)
                }
            }
            self.singleMapView.showAnnotations(self.annotations, animated: true)
            self.singleMapView.addAnnotations(self.annotations)
            
            
        })
        
       
        
        self.title = sItem["parkingName"]!
        SParkingName.textLabel?.text = "주차장 이름"
        SParkingName.detailTextLabel?.text = sItem["parkingName"]!
        sMealDay.textLabel?.text = "유무료 여부"
        sMealDay.detailTextLabel?.text = sItem["chargeInfo"]! /*+ "  " + sItem["basicTime"]! + "분 당 " + sItem["basicCharge"]! + "원"*/
        sTarget.textLabel?.text = "주차장의 종류"
        sTarget.detailTextLabel?.text = sItem["parkingCategory"]! // + " ~ " + sItem["satEndTime"]!
        sManageNm.textLabel?.text = "운영기간"
        sManageNm.detailTextLabel?.text = sItem["runDate"]
        sPhone.textLabel?.text = "전화번호"
        sPhone.detailTextLabel?.text = sItem["tel"]
    }
    
    @IBAction func sss(_ sender: Any) {
        let regionDistance:CLLocationDistance = 1000;
        let regionSpan = MKCoordinateRegionMakeWithDistance(self.coordinatesT.coordinate, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: self.coordinatesT.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.sItem["parkingName"]
        mapItem.openInMaps(launchOptions: options)
        
    }
    
     //콘솔(print)로 현재 위치 변화 출력
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let coor = manager.location?.coordinate
//        print("latitute" + String(describing: coor?.latitude) + "/ longitude" + String(describing: coor?.longitude))
//    }
//
}
