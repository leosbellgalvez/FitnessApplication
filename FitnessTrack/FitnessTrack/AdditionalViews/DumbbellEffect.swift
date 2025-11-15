import Foundation
import ParseSwift
import SwiftUI
internal import Combine


struct DumbbellEffect: View {
    @State private var dumbbells: [FallingDumbbell] = []
    let animationTimer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    let spawnTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(dumbbells) { dumbbell in
                    Image(systemName: "dumbbell.fill")
                        .font(.system(size: dumbbell.size))
                        .foregroundColor(.blue.opacity(dumbbell.opacity))
                        .rotationEffect(.degrees(dumbbell.rotation))
                        .position(x: dumbbell.x, y: dumbbell.y)
                }
            }
            .onReceive(spawnTimer) { _ in
                addDumbbell(in: geometry.size)
                
            }
            .onReceive(animationTimer) { _ in
                updateDumbbells(in: geometry.size)
            }
            .onAppear {
                for _ in 0..<5 {
                    addDumbbell(in: geometry.size)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func addDumbbell(in size: CGSize) {
        let newDumbbell = FallingDumbbell(
            x: CGFloat.random(in: 0...size.width),
            y: -50,
            speed: CGFloat.random(in: 2...5),
            rotation: Double.random(in: 0...360),
            rotationSpeed: Double.random(in: -5...5),
            size: CGFloat.random(in: 20...40),
            opacity: Double.random(in: 0.1...0.3)
        )
        dumbbells.append(newDumbbell)
        
        if dumbbells.count > 20 {
            dumbbells.removeFirst()
        }
    }
    
    func updateDumbbells(in size: CGSize) {
        for index in dumbbells.indices {
            dumbbells[index].y += dumbbells[index].speed
            dumbbells[index].rotation += dumbbells[index].rotationSpeed
            
            if dumbbells[index].y > size.height + 50 {
                dumbbells.remove(at: index)
                break
            }
        }
    }
}
