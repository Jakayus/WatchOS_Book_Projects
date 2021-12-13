//
//  DefaultValues.swift
//  Project4 WatchKit Extension
//
//  Created by Joel Sereno on 12/10/21.
//

import SwiftUI

struct DefaultValues: View {
    
    let defaultOptions = [1, 5, 10, 25, 50, 100, 250, 500, 1000]
    
    var body: some View {
        List () {
            ForEach(defaultOptions, id: \.self) { option in
                Button {
                    UserDefaults.standard.set(option, forKey: "amount")
                    print(UserDefaults.standard.double(forKey: "amount"))
                } label: {
                    Text("\(option)")
                }
            }
        }
        
    }
    
    func convertAmount() {
        
    }
}

struct DefaultValues_Previews: PreviewProvider {
    static var previews: some View {
        DefaultValues()
    }
}
