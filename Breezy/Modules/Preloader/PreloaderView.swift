import SwiftUI

struct PreloaderView: View {
    @State
    private var isAnimating: Bool = false
    
    let goToHome: () -> Void
    
    var body: some View {
        VStack {
            Image(.miniIcon)
                .resizable()
                .frame(width: 80, height: 80)
                .offset(y: -8)
                .scaleEffect(isAnimating ? 1.2 : 1)
                .shadow(color: isAnimating ? .gray : .white, radius: 10, x: 3, y: 3)
                .animation(.easeInOut(duration: 2), value: isAnimating)
        }
        .onAppear {
            isAnimating.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                goToHome()
            }
        }
    }
}

#Preview {
    PreloaderView(goToHome: {})
}
