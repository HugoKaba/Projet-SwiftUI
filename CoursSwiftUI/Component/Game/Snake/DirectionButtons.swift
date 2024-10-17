import SwiftUI

struct DirectionButtons: View {
    var changeDirection: (Direction) -> Void

    var body: some View {
        HStack {
            Button(action: {
                changeDirection(.left)
            }) {
                Text("←")
                    .font(.largeTitle)
                    .frame(width: 80, height: 80)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
            
            VStack {
                Button(action: {
                    changeDirection(.up)
                }) {
                    Text("↑")
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                }
                
                Button(action: {
                    changeDirection(.down)
                }) {
                    Text("↓")
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                }
            }
            
            Button(action: {
                changeDirection(.right)
            }) {
                Text("→")
                    .font(.largeTitle)
                    .frame(width: 80, height: 80)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
        }
        .padding()
    }
}
