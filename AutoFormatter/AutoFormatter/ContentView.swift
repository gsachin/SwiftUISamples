//
//  ContentView.swift
//  AutoFormatter
//
//  Created by Sachin Gupta on 12/20/20.
//

import SwiftUI

struct ContentView: View {
    @AutoFormatter(type:.phone) var phoneNumber:String
    @AutoFormatter(type:.zipcode) var zipCode:String
    @AutoFormatter(type:.currency) var currencyValue:String
    var body: some View {
        VStack {
        Text("Text Formatting")
            .padding()
        TextField("Phone Number", text: $phoneNumber).onReceive(phoneNumber.publisher.collect()) {
            self.phoneNumber = String($0.prefix(10))
        }
            TextField("ZipCode", text: $zipCode) .onReceive(zipCode.publisher.collect()) {
                self.zipCode = String($0.prefix(9))
            }
            TextField("Currency", text: $currencyValue) .onReceive(currencyValue.publisher.collect()) {
                self.currencyValue = String($0.prefix(9))
            }

        Spacer()

        }.padding(20)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
