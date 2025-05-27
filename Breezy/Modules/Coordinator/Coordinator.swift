import Foundation

final class Coordinator: ObservableObject {
    enum ViewState {
        case preloader, home
    }
    
    @Published
    private(set) var viewState: ViewState = .preloader
    
    func goToHome() {
        self.viewState = .home
    }
}
