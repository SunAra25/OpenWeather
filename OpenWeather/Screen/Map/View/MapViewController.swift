//
//  MapViewController.swift
//  OpenWeather
//
//  Created by 아라 on 7/15/24.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.delegate = self
        return view
    }()
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setHierarchy()
        setConstraints()
        checkDeviceLocationAuthorization()
    }
    
    func setHierarchy() {
        view.addSubview(mapView)
    }
    
    func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        checkCurrentLocationAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkCurrentLocationAuthorization()
    }
}

extension MapViewController {
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
        
        let coordinates = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        mapView.addAnnotation(annotation)
    }
    
    func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization()
        } else {
            let center = CLLocationCoordinate2D(latitude: 37.517768794428, longitude: 126.88578560648)
            setRegionAndAnnotation(center: center)
        }
    }
    
    func checkCurrentLocationAuthorization() {
        var status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            presentSetting()
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default: print(status)
        }
    }
    
    func presentSetting() {
        let alertController = UIAlertController(title: "위치 접근 권한이 없습니다.", message: "설정으로 이동하여 권한 설정을 해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: false, completion: nil)
    }
}
