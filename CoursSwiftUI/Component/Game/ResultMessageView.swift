import SwiftUI

struct ResultMessageView: View {
    let resultMessage: String
    
    var body: some View {
        Text(resultMessage)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
}
