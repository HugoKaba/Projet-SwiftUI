import SwiftUI

struct JackpotCreditsView: View {
    let credits: Int

    var body: some View {
        Text("Crédits: \(credits)")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.top, 10)
    }
}
