import Foundation
import ParseSwift
import SwiftUI


struct MealView: View {
    let meal: MealPlanResponse.Meal
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(meal.title)
                .font(.headline)
            
            if let time = meal.readyInMinutes {
                Text("Ready in \(time) minutes")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            if let servings = meal.servings {
                Text("Servings: \(servings)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
