import Foundation
import ParseSwift
import SwiftUI

struct WorkoutLogView: View {
    @State private var workoutName = ""
    @State private var sets = ""
    @State private var reps = ""
    @State private var weight = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack(spacing: 20) {
            Form {
                Section(header: Text("Workout Input")) {
                    TextField("Workout Name", text: $workoutName)
                    TextField("Sets", text: $sets)
                        .keyboardType(.numberPad)
                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)
                    TextField("Weight (lbs) (optional)", text: $weight)
                        .keyboardType(.decimalPad)
                }
            }
            
            if isLoading {
                ProgressView()
            } else {
                Button(action: saveWorkout) {
                    Text("Save Workout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
            }
        }
        .navigationTitle("Log Workout")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Message"), message: Text(alertMessage), dismissButton: .default(Text("Alright!")) {
                if alertMessage.contains("Success") {
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
    
    func saveWorkout() {
        guard !workoutName.isEmpty,
              let setsInt = Int(sets),
              let repsInt = Int(reps) else {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        
        isLoading = true
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let dayOfWeek = formatter.string(from: date)
        
        var workout = ExerciseLog()
        workout.workoutName = workoutName
        workout.sets = setsInt
        workout.reps = repsInt
        
        if !weight.isEmpty, let weightDouble = Double(weight) {
            workout.weight = weightDouble
        }
        workout.dayOfWeek = dayOfWeek
        workout.date = date
        workout.userId = User.current?.objectId
        
        workout.save { result in
            isLoading = false
            switch result {
            case .success:
                alertMessage = "Workout saved successfully."
                showAlert = true
                workoutName = ""
                sets = ""
                reps = ""
            case .failure(let error):
                alertMessage = "Failed to save workout. Error: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}
