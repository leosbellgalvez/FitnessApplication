import Foundation
import SwiftUI
import ParseSwift


struct FallingDumbbell: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var speed: CGFloat
    var rotation: Double
    var rotationSpeed: Double
    var size: CGFloat
    var opacity: Double
}
