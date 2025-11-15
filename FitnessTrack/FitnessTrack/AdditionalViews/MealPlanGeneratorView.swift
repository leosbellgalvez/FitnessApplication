import Foundation
import SwiftUI



struct MealPlanGeneratorView: View {
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var height = ""
    @State private var weight = ""
    @State private var planType = "Day"
    @State private var targetCalories = ""
    @State private var diet = "None"
    @State private var isLoading = false
    @State private var generatedMealPlan: MealPlanResponse? = nil
    
    
    let planTypes = ["Day", "Week"]
    let diets = ["None", "Vegetarian", "Vegan", "Gluten Free", "Ketogenic", "Paleo"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Form {
                    Section(header: Text("Information")) {
                        TextField("Height (cm)", text: $height)
                            .keyboardType(.numberPad)
                        TextField("Weight (kg)", text: $weight)
                            .keyboardType(.numberPad)
                        TextField("Target Calories", text: $targetCalories)
                            .keyboardType(.numberPad)
                        
                        Picker("Diet Type", selection: $diet) {
                            ForEach(diets, id: \.self) { diet in
                                Text(diet)
                            }
                        }
                        
                        Picker("Plan Length", selection: $planType) {
                            ForEach(planTypes, id: \.self) { type in
                                Text(type)
                            }
                        }
                    }
                }
                .frame(height: 400)
                
                if isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button(action: generateMealPlan) {
                        Text("Generate Meal Plan")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                }
                
                if let plan = generatedMealPlan {
                    MealPlanResultView(mealPlan: plan)
                        .padding()
                }
            }
        }
        .navigationTitle("Meal Plan Generator")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("Alright!")))
        }
    }
    
    
    func generateMealPlan() {
        guard !targetCalories.isEmpty else {
            alertMessage = "Enter calorie target"
            showAlert = true
            return
        }
        
        isLoading = true
        
        let timeFrame = planType.lowercased()
        var urlString = "https://api.spoonacular.com/mealplanner/generate?apiKey=96fa091232bd466785ba88119dd7e8a0&timeFrame=\(timeFrame)&targetCalories=\(targetCalories)"
        
        if diet != "None" {
            urlString += "&diet=\(diet.lowercased().replacingOccurrences(of: " ", with: ""))"
        }
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            alertMessage = "Invalid URL input"
            showAlert = true
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    alertMessage = "Error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                
                guard let data = data else {
                    alertMessage = "No data was received from Spoonacular API"
                    showAlert = true
                    return
                }
                
                
                do {
                    let decoder = JSONDecoder()
                    let plan = try decoder.decode(MealPlanResponse.self, from: data)
                    generatedMealPlan = plan
                } catch {
                    alertMessage = "Failure in meal plan parser... \(error.localizedDescription)"
                    showAlert = true
                }
            }
        }.resume( )
    }
}

