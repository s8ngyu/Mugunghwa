//
//  ContentView.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 9/17/22.
//

import SwiftUI

struct ContentView: View {
    let installing = NotificationCenter.default.publisher(for: NSNotification.Name("Theme/Installing"))
    let error = NotificationCenter.default.publisher(for: NSNotification.Name("Theme/Error"))
    let success = NotificationCenter.default.publisher(for: NSNotification.Name("Theme/Success"))
    @State private var showingInstalling = false
    @State private var showingError = false
    @State private var showingSuccess = false
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .alert(isPresented: $showingError) {
                    Alert(title: Text("Error"), message: Text("selected iconpack is invalid"), dismissButton: .default(Text("Okay")))
                }
                .onReceive(error) { (output) in
                    showingError.toggle()
                }
            UtilityView()
                .tabItem {
                    Image(systemName: "wrench.and.screwdriver.fill")
                    Text("Utilities")
                }
                .alert(isPresented: $showingSuccess) {
                    Alert(title: Text("Success"), message: Text("successfully installed selected iconpack"), dismissButton: .default(Text("Okay")))
                }
                .onReceive(success) { (output) in
                    showingSuccess.toggle()
                }
        }
        .alert(isPresented: $showingInstalling) {
            Alert(title: Text("Installing"), message: Text("installing selected iconpack"), dismissButton: .default(Text("Okay")))
        }
        .onReceive(installing) { (output) in
            showingInstalling.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
