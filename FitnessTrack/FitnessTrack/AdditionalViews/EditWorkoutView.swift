import Foundation
import ParseSwift
import SwiftUI


struct EditWorkoutView: View {
    var workout: ExerciseLog
    var onSave: () -> Void
    
    @State private var workoutName = ""
    @State private var sets = ""
    @State private var reps = ""
    @State private var weight = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Form {
                    Section(header: Text("Workout input")) {
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
                    Button(action: updateWorkout) {
                        Text("Update exercise log")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth:. infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                }
            }
            .navigationTitle("Edit Exercise Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear {
                workoutName = workout.workoutName ?? ""
                sets = "\(workout.sets ?? 0)"
                reps = "\(workout.reps ?? 0)"
                if let w = workout.weight {
                    weight = "\(w)"
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Successful!"), message: Text(alertMessage), dismissButton: .default(Text("Alright!")) {
                    if alertMessage.contains("Success") {
                        onSave()
                        presentationMode.wrappedValue.dismiss()
                    }
                })
            }
        }
    }
    
    func updateWorkout() {
        guard !workoutName.isEmpty,
              let setsInt = Int(sets),
              let repsInt = Int(reps) else {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        isLoading = true
        
        var updatedWorkout = workout
        updatedWorkout.workoutName = workoutName
        updatedWorkout.sets = setsInt
        updatedWorkout.reps = repsInt
        
        if !weight.isEmpty, let weightD = Double(weight) {
            updatedWorkout.weight = weightD
        } else {
            updatedWorkout.weight = nil
        }
        
        updatedWorkout.save { result in
            isLoading = false
            switch result {
            case .success:
                alertMessage = "Success! Workout updated"
                showAlert = true
            case .failure(let error):
                alertMessage = "Error! \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}

