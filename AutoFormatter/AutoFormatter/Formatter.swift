//
//  File.swift
//  AutoFormatter
//
//  Created by Sachin Gupta on 12/25/20.
//
import Foundation
import SwiftUI
import Combine

// Define number of enum to support auto formating
enum AutoFormatterType {
    case phone
    case zipcode
    case currency
    
}

// Extension to format and deformat Test
// accepting list symbol(char/string) and it index position in which symbol need to inserted
extension String {
    func formatString(symbols:[Int:String])->String {
        var formattedComponents = [String]()
        self.forEach {
            if let symbol = symbols[formattedComponents.count] {
                // inserting symbols at its index position to format a text
                formattedComponents.append(symbol)
            }
            if "0123456789".contains($0)
            {
                formattedComponents.append("\($0)")
            }
        }
        return formattedComponents.joined()
    }
    
    func deformatString()->String {
        return self.filter {
            //removing symbols
            return "0123456789".contains($0)
        }
    }
}
//creation generic Auto Formatter proporty wrapper
@available(iOS 13.0, *)
@propertyWrapper struct AutoFormatter : DynamicProperty {
    var type:AutoFormatterType
    //A Dictionary to hold the list of symbol and its index position
    private var symbolsToInsert = [Int:String]()
    @State private var value = ""
    
    // Here we are doing the magic populating symbol and its index position to symbolsToInsert
    init(type:AutoFormatterType) {
        self.type = type
        switch type {
        case .phone:
            symbolsToInsert[0] = "("
            symbolsToInsert[4] = ") "
            symbolsToInsert[8] = "-"
        case .zipcode:
            symbolsToInsert[5] = "-"
        case .currency:
            symbolsToInsert[0] = "$"
        }
        
    }
    
    var wrappedValue: String {
        get {
         value
        }
        nonmutating set {
                value = newValue
        }
    
    }
    var projectedValue:Binding<String> {
        Binding(get:{
            wrappedValue.formatString(symbols: symbolsToInsert)
        },
        set: {
             wrappedValue = $0.deformatString()
        }
        )

    }
}


