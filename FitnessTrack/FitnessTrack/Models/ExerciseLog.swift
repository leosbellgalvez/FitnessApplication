import Foundation
import SwiftUI
import ParseSwift


struct ExerciseLog: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?
    
    
    var workoutName: String?
    var sets: Int?
    var reps: Int?
    var weight: Double?
    var dayOfWeek: String?
    var date: Date?
    var userId: String?
}
