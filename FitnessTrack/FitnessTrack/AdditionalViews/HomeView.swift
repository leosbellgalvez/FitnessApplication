import Foundation
import ParseSwift
import SwiftUI


struct HomeView: View {
    @Binding var isLoggedIn: Bool
    @State private var showWorkoutLog = false
    @State private var showMealPlanGen = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                DumbbellEffect()
                
                VStack(spacing: 30) {
                    Image(systemName: "dumbbell")
                        .frame(width: 200, height: 200)
                        .scaledToFill()
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: WorkoutLogView()) {
                            CustomHomeButton(title: "Exercise Logging", icon: "dumbbell.fill", color: .blue)
                        }
                        
                        NavigationLink(destination: MealPlanGeneratorView()) {
                            CustomHomeButton(title: "Meal Plan Generator", icon: "fork.knife", color: .green)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Button(action: logout) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
    
    func logout() {
        User.logout { result in
            switch result {
            case .success:
                isLoggedIn = false
            case .failure(let error):
                print("Error logging out: \(error.localizedDescription)")
            }
        }
    }
}
