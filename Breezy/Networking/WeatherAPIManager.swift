import Foundation

final class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    private init() {}

    func fetchForecast(for city: String, days: Int = 5) async throws -> WeatherResponse {
        guard var urlComponents = URLComponents(string: Constants.baseURL) else {
            throw URLError(.badURL)
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: Constants.apiKey),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: "\(days)"),
            URLQueryItem(name: "aqi", value: "no"),
            URLQueryItem(name: "alerts", value: "no")
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return decodedData
    }
}
