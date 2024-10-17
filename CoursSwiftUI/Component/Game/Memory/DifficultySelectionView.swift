import SwiftUI

struct DifficultySelectionView: View {
    let difficulties: [(title: String, color: Color, level: Difficulty)]
    let onSelect: (Difficulty) -> Void
    
    var body: some View {
        HStack {
            ForEach(difficulties, id: \.level) { difficulty in
                Button(action: {
                    onSelect(difficulty.level)
                }) {
                    Text(difficulty.title)
                        .padding()
                        .background(difficulty.color)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
