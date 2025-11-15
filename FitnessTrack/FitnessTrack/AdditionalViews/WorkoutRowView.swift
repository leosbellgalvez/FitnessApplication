import Foundation
import ParseSwift
import SwiftUI

struct WorkoutRowView: View {
    let workout: ExerciseLog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(workout.workoutName ?? "Unknown")
                .font(.headline)
            HStack {
                Text("\(workout.sets ?? 0) Sets")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                Spacer()
                Text("\(workout.reps ?? 0) Reps")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let weight = workout.weight {
                    Spacer()
                    Text("\(String(format: "%.1f", weight)) lbs")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(6)
                }
            }
        }
        .padding(.vertical, 5)
    }
}
