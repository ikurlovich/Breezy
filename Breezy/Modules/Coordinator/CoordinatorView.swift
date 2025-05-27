import SwiftUI

struct CoordinatorView: View {
    @StateObject
    private var coordinator = Coordinator()
    
    var body: some View {
        VStack {
            switch coordinator.viewState {
            case .preloader:
                PreloaderView(goToHome: coordinator.goToHome)
            case .home:
                HomeView()
            }
        }
        .animation(.easeInOut(duration: 1), value: coordinator.viewState)
    }
}

#Preview {
    CoordinatorView()
}
