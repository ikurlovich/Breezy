import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var forecast: [ForecastDay] = []
    @Published var city: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let locationManager = LocationManager()
    
    init() {
        locationManager.requestLocation()
        Task {
            await observeCityChanges()
        }
    }
    
    private func observeCityChanges() async {
        for await city in locationManager.$currentCity.values {
            if let city = city {
                self.city = city
                await loadWeather()
            }
        }
    }
    
    func loadWeather() async {
        guard !city.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        do {
            let response = try await WeatherAPIManager.shared.fetchForecast(for: city)
            self.forecast = response.forecast.forecastday
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
