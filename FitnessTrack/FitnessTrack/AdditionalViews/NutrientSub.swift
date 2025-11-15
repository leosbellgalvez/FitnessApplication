import Foundation
import ParseSwift
import SwiftUI


struct NutrientSub: View {
    let name: String
    let value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.caption)
                .bold()
            Text(name)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(8)
    }
}
