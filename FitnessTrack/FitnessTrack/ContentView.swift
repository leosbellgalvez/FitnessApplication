import SwiftUI
import ParseSwift
import Foundation

struct ContentView: View {
    @State private var isLoggedIn = false
    var body: some View {
        Group {
            if isLoggedIn || User.current != nil {
                MainTabView(isLoggedIn: $isLoggedIn)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
        .onAppear {
            isLoggedIn = User.current != nil
        }
    }
}

#Preview {
    ContentView()
}
