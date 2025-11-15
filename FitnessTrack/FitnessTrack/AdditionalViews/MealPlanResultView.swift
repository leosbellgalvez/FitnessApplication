import Foundation
import ParseSwift
import SwiftUI

struct MealPlanResultView: View {
    let mealPlan: MealPlanResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Your Meal Plan")
                .font(.title2)
                .bold()
            
            if let meals = mealPlan.meals {
                ForEach(meals) { meal in
                    MealView(meal: meal)
                }
                
                if let nutrients = mealPlan.nutrients {
                    NutrientSummaryView(nutrients: nutrients)
                }
            } else if let week = mealPlan.week {
                ForEach(week.sorted(by: { $0.key < $1.key }), id: \.key) { day, dayMeals in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(formatDay(day))
                            .font(.headline)
                            .padding(.top)
                        
                        ForEach(dayMeals.meals) { meal in
                            MealView(meal: meal)
                        }
                        
                        NutrientSummaryView(nutrients: dayMeals.nutrients)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    func formatDay(_ day: String) -> String {
        let components = day.split(separator: "y")
        if components.count > 1 {
            return "Day \(components[1])"
        }
        return day.capitalized
    }
}
