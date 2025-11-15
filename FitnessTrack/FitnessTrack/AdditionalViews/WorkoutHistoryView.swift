import Foundation
import ParseSwift
import SwiftUI


struct WorkoutHistoryView: View {
    @State private var workouts: [ExerciseLog] = []
    @State private var isLoading = false
    @State private var groupedWorkouts: [String: [ExerciseLog]] = [:]
    @State private var workoutToEdit: ExerciseLog?
    @State private var showDeleteAlert = false
    @State private var workoutToDelete: ExerciseLog?
    
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Workout History")
                .onAppear(perform: fetchWorkouts)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: fetchWorkouts) {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
                .sheet(item: $workoutToEdit) { workout in
                    EditWorkoutView(workout: workout) {
                        fetchWorkouts()
                    }
                }
                .alert("Delete Workout!", isPresented: $showDeleteAlert) {
                    Button("Cancel", role: .cancel) {}
                    Button("Delete", role: .destructive) {
                        if let workout = workoutToDelete {
                            deleteWorkout(workout)
                        }
                    }
                } message: {
                    Text("Are you positive you want to delete this log?")
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if isLoading {
            ProgressView()
        } else if workouts.isEmpty {
            emptyState
        } else {
            workoutsList
        }
    }

    private var emptyState: some View {
        VStack {
            Image(systemName: "dumbbell")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("No logged exercises. Start logging some!")
                .foregroundColor(.gray)
                .padding()
        }
    }

    private var workoutsList: some View {
        List {
            ForEach(sortedDays(), id: \.self) { day in
                Section(header: Text(day).font(.headline)) {
                    ForEach(groupedWorkouts[day] ?? [], id: \.objectId) { workout in
                        WorkoutRowView(workout: workout)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    workoutToDelete = workout
                                    showDeleteAlert = true
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                                Button {
                                    workoutToEdit = workout
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                    }
                }
            }
        }
    }
    
    func fetchWorkouts() {
        guard let userId = User.current?.objectId else { return }
        
        isLoading = true
        let query = ExerciseLog.query("userId" == userId)
            .order([.descending("date")])
        
        query.find { result in
            isLoading = false
            switch result {
            case .success(let fetchedWorkouts):
                workouts = fetchedWorkouts
                groupWorkoutsByDay()
            case .failure(let error):
                print("Error with exercises: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteWorkout(_ workout: ExerciseLog) {
        var workoutToDelete = workout
        workoutToDelete.delete { result in
            switch result {
            case .success:
                fetchWorkouts()
            case.failure(let error):
                print("could not delete workout: \(error.localizedDescription)")
            }
        }
    }
    
    func groupWorkoutsByDay() {
        let grouped = Dictionary(grouping: workouts) { workout in
            if let date = workout.date {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE"
                return formatter.string(from: date)
            }
            return "Unknown"
        }
        groupedWorkouts = grouped
    }
    
    func sortedDays() -> [String] {
        groupedWorkouts.keys.sorted { d1, d2 in
            guard let workouts1 = groupedWorkouts[d1],
                  let workouts2 = groupedWorkouts[d2],
                  let date1 = workouts1.first?.date,
                  let date2 = workouts2.first?.date else {
                return false
            }
            return date1 > date2
        }
    }
}
