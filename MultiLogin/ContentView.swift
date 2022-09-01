//
//  ContentView.swift
//  MultiLogin
//
//  Created by Calum Haddow on 01/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Login()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
