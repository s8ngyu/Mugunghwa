//
//  ThemesManageView.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 12/10/2022.
//

import SwiftUI

func getListOfThemes(atPath: URL) -> [Theme] {
    var tmp: [Theme] = [Theme]()
    
    do {
        let dir: [URL] = try FileManager.default.contentsOfDirectory(at: atPath, includingPropertiesForKeys: nil)
        for f in dir {
            if f.isDirectory {
                let theme = Theme.init(withPath: f)
                tmp.append(theme)
            }
        }
        return tmp
    } catch {
        return tmp
    }
}

func getList(atPath: URL) -> [URL] {
    var tmp: [URL] = [URL]()
    
    do {
        let dir: [URL] = try FileManager.default.contentsOfDirectory(at: atPath, includingPropertiesForKeys: nil)
        for f in dir {
            tmp.append(f)
        }
        return tmp
    } catch {
        return tmp
    }
}

struct ThemesManageView: View {
    @State private var themes: [Theme] = getListOfThemes(atPath: URL(fileURLWithPath: "/private/var/mobile/mugunghwa/Themes"))
    @State private var selectedTheme: Theme? = getSelectedTheme()
    
    var body: some View {
        List {
            ForEach(themes) { theme in
                ThemeRow(theme: theme, selectedTheme: $selectedTheme)
            }
            .onDelete(perform: delete)
        }.navigationTitle("Manage Themes")
            .listStyle(.insetGrouped)
            .onAppear() {
                themes = getListOfThemes(atPath: URL(fileURLWithPath: "/private/var/mobile/mugunghwa/Themes"))
            }
            .toolbar {
                Button("Restore") {
                    UIApplication.shared.indicator(title: "Restoring...")
                    let prefs = MGPreferences.init(identifier: "me.soongyu.mugunghwa")
                    prefs.dictionary.setValue("Mugunghwa/Default", forKey: "selectedTheme")
                    prefs.updatePlist()
                    restoreTheme()
                }
            }
    }
    
    func delete(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: themes[index].path!.path) {
            try? fileManager.removeItem(at: themes[index].path!)
        }
        themes.remove(atOffsets: offsets)
    }
}

struct ThemeGroupLabel: View {
    @State var title: String
    
    var body: some View {
        Label {
            Text(title)
        } icon: {
        }
    }
}

struct ThemeRow: View {
    @State var theme: Theme
    @Binding var selectedTheme: Theme?
    @State private var showingFailedAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(theme.name)
                    .font(.title2)
                    .fontWeight(.medium)
                Text("\(theme.count) icons")
                    .font(.footnote)
                    .foregroundColor(Color(UIColor.systemGray))
                    .offset(y: -2)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.mobilesafari"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.AppStore"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.Preferences"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.mobilemail"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.mobilephone"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.MobileSMS"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.Music"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.weather"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.Maps"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.Health"))
                }
            }.alert(isPresented: $showingFailedAlert) {
                Alert(
                    title: Text("Failed!"),
                    message: Text("Please select theme before applying.")
                )
            }
            if theme.name == selectedTheme?.name {
                Button {
                    if (selectedTheme != nil) && FileManager.default.fileExists(atPath: selectedTheme!.path!.path) {
                        UIApplication.shared.indicator(title: "Applying...")
                        applyThemev2(selection: selectedTheme)
                    } else {
                        showingFailedAlert.toggle()
                    }
                } label: {
                    Text("Apply")
                        .frame(maxWidth: .infinity)
                }.backport.applyProminentBorder()
            } else {
                Button {
                    // select this
                    selectedTheme = theme
                    let prefs = MGPreferences.init(identifier: "me.soongyu.mugunghwa")
                    prefs.dictionary.setValue(selectedTheme!.name, forKey: "selectedTheme")
                    prefs.updatePlist()
                } label: {
                    Text("Select")
                        .frame(maxWidth: .infinity)
                }.backport.applyBorder()
            }
        }
    }
}

struct IconView: View {
    @State var image: UIImage?
    
    var body: some View {
        if (image != nil) {
            Image(uiImage: image!)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .cornerRadius(8)
        }
    }
}

struct ThemesManageView_Previews: PreviewProvider {
    static var previews: some View {
        ThemesManageView()
    }
}
