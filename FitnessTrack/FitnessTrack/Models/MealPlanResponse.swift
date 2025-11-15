import Foundation
import ParseSwift
import SwiftUI


struct MealPlanResponse: Codable {
    let meals: [Meal]?
    let nutrients: Nutrients?
    let week: [String: DayMeals]?
    
    struct Meal: Codable, Identifiable {
        let id: Int
        let title: String
        let readyInMinutes: Int?
        let servings: Int?
        let sourceUrl: String?
    }
    
    struct Nutrients: Codable {
        let calories: Double
        let protein: Double
        let fat: Double
        let carbohydrates: Double
    }
    
    struct DayMeals: Codable {
        let meals: [Meal]
        let nutrients: Nutrients
    }
}
