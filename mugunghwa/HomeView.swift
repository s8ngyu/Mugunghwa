//
//  HomeView.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 9/17/22.
//

import SwiftUI
import Alamofire

func version() -> String {
    let dictionary = Bundle.main.infoDictionary!
    let version = dictionary["CFBundleShortVersionString"] as! String
    return version
}

func checkSandbox() -> Bool {
    let fileManager = FileManager.default
    fileManager.createFile(atPath: "/var/mobile/me.soongyu.red-dot", contents: nil)
    if fileManager.fileExists(atPath: "/var/mobile/me.soongyu.red-dot") {
        do {
            try fileManager.removeItem(atPath: "/var/mobile/me.soongyu.red-dot")
        } catch {
            print("Failed to remove sandbox check file")
        }
        return false
    }
    
    return true
}

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            AppHeaderView()
                .padding(.bottom, 30)
            
            Text("Quick Actions")
                .font(.title3)
                .fontWeight(.semibold)
            UtilButtonView()
            
            Spacer()
            
            Text("Follow me on")
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack {
                Link(destination: URL(string: "https://twitter.com/soongyu_kwon")!) {
                    HStack {
                        Text("Twitter")
                    }.frame(maxWidth: .infinity)
                }
                
                Link(destination: URL(string: "https://instagram.com/s8ngyu.kwon")!) {
                    HStack {
                        Text("Instagram")
                    }.frame(maxWidth: .infinity)
                }
            }.buttonStyle(.bordered)
                .tint(.pink)
            
            Link(destination: URL(string: "https://paypal.me/peterdev")!) {
                HStack {
                    Text("Buy me a coffee")
                }.frame(maxWidth: .infinity)
            }.buttonStyle(.bordered)
                .tint(.pink)
            Text("Credits")
                .font(.title3)
                .fontWeight(.semibold)
            Link(destination: URL(string: "https://twitter.com/DaanDH13")!) {
                HStack {
                    Text("Beautiful icon by Daan")
                }.frame(maxWidth: .infinity)
            }.buttonStyle(.bordered)
                .tint(.pink)
            Link(destination: URL(string: "https://twitter.com/opa334dev")!) {
                HStack {
                    Text("TSUtil by Lars Fröder")
                }.frame(maxWidth: .infinity)
            }.buttonStyle(.bordered)
                .tint(.pink)
        }.padding()
    }
}

struct AppHeaderView: View {
    @State private var isSandboxed = checkSandbox()
    
    var body: some View {
        VStack(alignment: .center   ) {
            HStack {
                Image("Icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(13)
                    .offset(y: 2)
                    .padding(.trailing, 3)
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        Text("Mugunghwa")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("v\(version())")
                            .font(.title2)
                            .fontWeight(.medium)
                            .offset(y: -3)
                            .foregroundColor(.gray)
                    }
                    Text("by Soongyu Kwon")
                }
            }
            
            HStack {
                Image(systemName: isSandboxed ? "xmark.seal.fill" : "checkmark.seal.fill")
                Text(isSandboxed ? "Bad permissions" :"Installed via TrollStore")
            }.padding(.top, 3)
                .foregroundColor(isSandboxed ? .red :.green)
        }.frame(maxWidth: .infinity)
    }
}

struct UtilButtonView: View {
    @State private var isSandboxed = checkSandbox()
    @State private var showingUpToDate = false
    @State private var showingNewVersionAvailable = false
    
    var body: some View {
        HStack {
            Button(action: {
                // check updates
                URLCache.shared.removeAllCachedResponses()
                AF.request("https://raw.githubusercontent.com/s8ngyu/Mugunghwa/main/version").response { response in
                    let recentVersion = String(data: response.data!, encoding: .utf8)!.filter { !$0.isWhitespace }
                    print(recentVersion)
                    if recentVersion == version() {
                        // up to date
                        showingUpToDate.toggle()
                    } else {
                        // needs update
                        showingNewVersionAvailable.toggle()
                    }
                }
            }) {
                VStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text("check updates")
                }.frame(maxWidth: .infinity, maxHeight: 70)
            }.alert("You are up to date", isPresented: $showingUpToDate
            ) {
                Button(role: .cancel, action: {}, label: {Text("Okay")})
            } message: {
                Text("")
            }
            
            Button(action: {
                let helper = ObjcHelper()
                helper.respring()
            }) {
                VStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("respring")
                }.frame(maxWidth: .infinity, maxHeight: 70)
            }.disabled(isSandboxed)
                .alert("New version is available.", isPresented: $showingNewVersionAvailable
                ) {
                    Button(role: .cancel, action: {}, label: {Text("Okay")})
                } message: {
                    Text("Please update Mugunghwa.")
                }
        }.buttonStyle(.bordered)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
