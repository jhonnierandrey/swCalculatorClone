//
//  ContentView.swift
//  CalculatorClone
//
//  Created by Jhonnier Zapata on 6/28/23.
//

import SwiftUI

enum CalcButtons : String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six  = "6"
    case seven  = "7"
    case eight  = "8"
    case nine = "9"
    case zero = "0"
    case subtract  = "-"
    case add  = "+"
    case divide  = "/"
    case multiply = "x"
    case equal  = "="
    case clear  = "AC"
    case decimal = "."
    case percent  = "%"
    case negative  = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .divide, .multiply, .equal :
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, divide, multiply, none
}

struct ContentView: View {
    @State var displayValue = "0"
    @State var computeValue = 0
    @State var currentOperator : Operation = .none
    
    let buttons: [[CalcButtons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text(displayValue)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.primary)
                    
                }.padding()
                
                ForEach(buttons, id: \.self){ row in
                    HStack (spacing: 12){
                        ForEach(row, id:\.self){
                            item in Button  {
                                self.didTap(button: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size : 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            }

                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button : CalcButtons){
        switch button {
        case .add, .subtract, .multiply, .divide, .equal :
            if button == .add {
                self.currentOperator = .add
                self.computeValue = Int(self.displayValue) ?? 0
            } else if button == .subtract {
                self.currentOperator = .subtract
                self.computeValue = Int(self.displayValue) ?? 0
            } else if button == .multiply {
                self.currentOperator = .multiply
                self.computeValue = Int(self.displayValue) ?? 0
            } else if button == .divide {
                self.currentOperator = .divide
                self.computeValue = Int(self.displayValue) ?? 0
            } else if button == .equal {
                let runningValue = self.computeValue
                let currentValue = Int(self.displayValue) ?? 0
                switch self.currentOperator {
                case .add: self.displayValue = "\(runningValue + currentValue)"
                case .subtract: self.displayValue = "\(runningValue - currentValue)"
                case .multiply: self.displayValue = "\(runningValue * currentValue)"
                case .divide: self.displayValue = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.displayValue = "0"
            }
        case .clear :
            self.displayValue = "0"
        case .decimal, .negative, .percent:
            break
        default :
            let number = button.rawValue
            if self.displayValue == "0" {
                displayValue = number
            }else {
                self.displayValue = "\(self.displayValue)\(number)"
            }
        }
    }
    
    func buttonWidth (item : CalcButtons) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    func buttonHeight () -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

#Preview {
    ContentView()
}
