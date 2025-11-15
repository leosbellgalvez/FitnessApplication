import Foundation
import ParseSwift
import SwiftUI


struct NutrientSummaryView: View {
    let nutrients: MealPlanResponse.Nutrients
    
    
    var body: some View {
        VStack(alignment:. leading, spacing: 5) {
            Text("Nutritional Info")
                .font(.subheadline)
                .bold()
            
            HStack {
                NutrientSub(name: "Calories", value: String(format: "%.0f", nutrients.calories))
                NutrientSub(name: "Protein", value: String(format: "%.0fg", nutrients.protein))
                NutrientSub(name: "Carbs", value: String(format: "%.0fg", nutrients.carbohydrates))
                NutrientSub(name: "Fats", value: String(format: "%.0fg", nutrients.fat))
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}
