//
//  ContentView.swift
//  WeSplit
//
//  Created by sanchita lachke on 03/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    //To calculate final total amoung number of people with selected tip amount
    var totalPerPerson: Double {
        // numberOfPeople here is treated as index as we are starting the loop from 2 in 2..<100
        //that is if numberofpeople = 2, that means in the picker it will show value at 2nd index which is 4. So calulate it from 0th index we do (numberOfPeople + 2)
        //We are converting the values to Double as it needs to be used alongside the checkAmount.
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        //Calculate tip
        let tipAmount = checkAmount / 100 * tipSelection
        
        //Add tip amount to actual amount
        let totalAmountWithTip = checkAmount + tipAmount
        
        //Calculate the split amount after adding tip
        let grandTotalPerPerson = totalAmountWithTip / peopleCount
        
        return grandTotalPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Add amount
                    TextField("Amount:", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    //Select number of people
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                //Select tip percentage
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                //Shows final amount per person
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            //adding toolbar button
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
