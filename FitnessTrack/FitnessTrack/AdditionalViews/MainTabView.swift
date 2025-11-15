import Foundation
import ParseSwift
import SwiftUI


struct MainTabView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            HomeView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            WorkoutHistoryView()
                .tabItem {
                    Label("History", systemImage: "book.fill")
                }
        }
    }
}
