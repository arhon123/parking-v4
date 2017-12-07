
import UIKit
import MapKit
import CoreLocation

class TotalMapViewController: UIViewController {
    
    @IBOutlet weak var myMapView: MKMapView!
    var locationManager: CLLocationManager!
    var tItems:[[String:String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 현재 위치 트랙킹
        locationManager = CLLocationManager()
        //locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        //locationManager.startUpdatingHeading()
        
        // 지도에 현재 위치 마크를 보여줌
        myMapView.showsUserLocation = true
        
        self.title = "공영 주차장"
        
        //print("tItems = \(tItems)")
        // lat, lng
        var annos = [MKPointAnnotation]()
        
        for item in tItems {
            let geoCoder = CLGeocoder()
            
            geoCoder.geocodeAddressString(item["addrRoad"]! , completionHandler: { placemarks, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let myPlacemarks = placemarks {
                    let myPlacemark = myPlacemarks[0]
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = item["parkingName"]!
                    
                    if let myLocation = myPlacemark.location {
                        annotation.coordinate = myLocation.coordinate
                        annos.append(annotation)
                    }
                }
                self.myMapView.showAnnotations(annos, animated: true)
                self.myMapView.addAnnotations(annos)
                
            })
            
        }
        //myMapView.showAnnotations(annos, animated: true)
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
