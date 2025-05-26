import SwiftUI

struct HomeView: View {
    @StateObject
    private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(viewModel.forecast) { day in
                        HStack {
                            weatherSpecification(day: day)
                            weatherImage(day: day)
                        }
                    }
                }
            }
            .navigationTitle(title())
        }
    }
    
    @ViewBuilder
    private func weatherSpecification(day: ForecastDay) -> some View {
        VStack(alignment: .leading) {
            Text(day.date)
                .font(.headline)
            Text(day.day.condition.text)
            Text("🌡 \(day.day.avgtempC, specifier: "%.1f")°C, 💧 \(day.day.avghumidity, specifier: "%.0f")%, 💨 \(day.day.maxwindKph, specifier: "%.0f") km/h")
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
        }
    }
    
    @ViewBuilder
    private func weatherImage(day: ForecastDay) -> some View {
        AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        } placeholder: {
            ProgressView()
        }
    }
    
    private func title() -> String {
        viewModel.city.isEmpty ? "Defining a city..." : "Weather in \(viewModel.city)"
    }
}

#Preview {
    HomeView()
}
