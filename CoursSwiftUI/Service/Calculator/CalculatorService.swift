import SwiftUI
import Combine

class CalculatorService: ObservableObject {
    @Published var display: String = "0"
    private var currentInput: String = ""
    private var lastWasOperator: Bool = false
    private var lastResult: String = ""
    
    func numberTapped(_ number: String) {
        if lastResult.isEmpty {
            if currentInput == "0" {
                currentInput = number
            } else {
                currentInput += number
            }
            updateDisplay()
            lastWasOperator = false
        }
    }
    
    func operationTapped(_ operation: String) {
        if !currentInput.isEmpty && !lastWasOperator {
            currentInput += " " + operation + " "
            updateDisplay()
            lastWasOperator = true
        }
    }
    
    func calculateResult() {
        guard !currentInput.isEmpty, !lastWasOperator else { return }
        let expression = currentInput.replacingOccurrences(of: " ", with: "")
        let result = evaluateExpression(expression)
        currentInput = result
        lastResult = result
        updateDisplay()
        lastWasOperator = false
    }
    
    func clear() {
        currentInput = ""
        lastResult = ""
        updateDisplay()
    }
    
    private func updateDisplay() {
        display = currentInput.isEmpty ? "0" : currentInput
    }
    
    private func evaluateExpression(_ expression: String) -> String {
        let exp = NSExpression(format: expression)
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.stringValue
        }
        return "Error"
    }
}
