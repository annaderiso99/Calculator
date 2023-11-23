//
//  ContentView.swift
//  Calculator
//
//  Created by Anna De Riso on 16/11/23.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = ","
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, . subtract, . multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
            
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
        
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                
//
                Spacer()
                
                //Text display
                HStack {
                    Spacer ()
                    Text(value == "0" ? runningNumber.description : value.description)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
               
                
                
                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    
                    
                    HStack(spacing: 15) {
                        
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                                
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 40))
                                    .frame(width: self.buttonWidth(item: item),
                                           height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                        
                    }
                    .padding(.init(top: 3, leading: 15, bottom: 3, trailing: 15))

                    
                
                }
            }
            
        }
    }
    
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber += Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber += Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber += Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber += Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"; self.runningNumber = 0
                case .subtract: self.value = "\(runningValue - currentValue)"; self.runningNumber = 0
                case .multiply: self.value = "\(runningValue * currentValue)"; self.runningNumber = 0
                case .divide: self.value = "\(runningValue / currentValue)"; self.runningNumber = 0
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            self.runningNumber = 0
            self.currentOperation = .none
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
        
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}
            
#Preview {
    ContentView()
}
