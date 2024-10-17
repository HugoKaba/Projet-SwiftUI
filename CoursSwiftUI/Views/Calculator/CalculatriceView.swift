import SwiftUI

struct CalculatorView: View {
    @ObservedObject var calculatorService = CalculatorService()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            
            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Calculatrice Scientifique")
            
            VStack {
                Spacer()
                
                Text(calculatorService.display)
                    .font(.system(size: 70))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        CalculatorButton(title: "7") { calculatorService.numberTapped("7") }
                        CalculatorButton(title: "8") { calculatorService.numberTapped("8") }
                        CalculatorButton(title: "9") { calculatorService.numberTapped("9") }
                        CalculatorButton(title: "/") { calculatorService.operationTapped("/") }
                    }
                    HStack(spacing: 10) {
                        CalculatorButton(title: "4") { calculatorService.numberTapped("4") }
                        CalculatorButton(title: "5") { calculatorService.numberTapped("5") }
                        CalculatorButton(title: "6") { calculatorService.numberTapped("6") }
                        CalculatorButton(title: "*") { calculatorService.operationTapped("*") }
                    }
                    HStack(spacing: 10) {
                        CalculatorButton(title: "1") { calculatorService.numberTapped("1") }
                        CalculatorButton(title: "2") { calculatorService.numberTapped("2") }
                        CalculatorButton(title: "3") { calculatorService.numberTapped("3") }
                        CalculatorButton(title: "-") { calculatorService.operationTapped("-") }
                    }
                    HStack(spacing: 10) {
                        CalculatorButton(title: "0") { calculatorService.numberTapped("0") }
                        CalculatorButton(title: "C") { calculatorService.clear() }
                        CalculatorButton(title: "=") { calculatorService.calculateResult() }
                        CalculatorButton(title: "+") { calculatorService.operationTapped("+") }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    CalculatorView(isLoggedIn: .constant(true))
}
