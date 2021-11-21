//
//  CreditsView.swift
//  Project1 WatchKit Extension
//
//  Created by Joel Sereno on 11/20/21.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack {
            Text("App by Joel Sereno")
                .font(.headline)
            Text("Project1 completed 11/20/21")
                .fontWeight(.thin)
                
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
