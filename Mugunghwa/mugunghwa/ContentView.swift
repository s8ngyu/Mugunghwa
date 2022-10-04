//
//  ContentView.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 9/17/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            UtilityView()
                .tabItem {
                    Image(systemName: "wrench.and.screwdriver.fill")
                    Text("Utilities")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
