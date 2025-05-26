import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var currentCity: String?
    @Published var errorMessage: String?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }

    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                self.errorMessage = "Geocoding error: \(error.localizedDescription)"
                self.currentCity = "Moscow"
                return
            }
            
            if let placemark = placemarks?.first {
                let resolvedCity = [
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.subAdministrativeArea,
                    placemark.name
                ].compactMap { $0 }.first ?? "Moscow"
                
                print("🎯 Resolved city: \(resolvedCity)")
                self.currentCity = resolvedCity
            } else {
                print("⚠️ Placemark not found")
                self.currentCity = "Moscow"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.errorMessage = "Location error: \(error.localizedDescription)"
        self.currentCity = "Moscow"
    }
}
