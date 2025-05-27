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
                    ScrollView {
                        ForEach(viewModel.forecast) { day in
                            dayItem(day: day)
                        }
                    }
                }
            }
            .navigationTitle(title())
        }
    }
    
    @ViewBuilder
    private func dayItem(day: ForecastDay) -> some View {
        HStack {
            weatherSpecification(day: day)
            weatherImage(day: day)
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
        .padding(.vertical, 5)
        .shadow(color: .gray, radius: 10, x: 5, y: 5)
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
        viewModel.city.isEmpty ? "Defining a city..." : "\(viewModel.city)"
    }
}

#Preview {
    HomeView()
}
