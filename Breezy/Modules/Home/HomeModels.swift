import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let localtime: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable, Identifiable {
    var id: String { date }
    let date: String
    let day: Day
}

struct Day: Codable {
    let avgtempC: Double
    let maxwindKph: Double
    let avghumidity: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
        case maxwindKph = "maxwind_kph"
        case avghumidity
        case condition
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
}
