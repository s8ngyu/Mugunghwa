//
//  ThemesManageView.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 12/10/2022.
//

import SwiftUI

extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}

class Theme: Identifiable {
    let id: UUID
    var name: String
    var path: URL?
    var count: Int
    
    init() {
        self.id = UUID()
        self.name = ""
        self.path = nil
        self.count = 0
    }
}

extension Theme {
    convenience init(withPath: URL) {
        self.init()
        
        name = withPath.lastPathComponent
        path = withPath
        count = getList(atPath: path!).count
    }
    
    func getIcon(bundleIdentifier: String) -> UIImage? {
        var data = try? Data(contentsOf: path!.appendingPathComponent("\(bundleIdentifier)-large.png"))
        if data == nil {
            data = try? Data(contentsOf: path!.appendingPathComponent("\(bundleIdentifier)@3x.png"))
        }
        if data == nil {
            data = try? Data(contentsOf: path!.appendingPathComponent("\(bundleIdentifier)@2x.png"))
        }
        if data == nil {
            return nil
        }
        
        let image = UIImage(data: data!)
        
        return image
    }
}

class AppBundle: Identifiable {
    var id: String
    var path: URL?
    var bundlePath: URL?
    var bundleIdentifier: String
    
    init() {
        self.id = ""
        self.path = nil
        self.bundlePath = nil
        self.bundleIdentifier = ""
    }
}

extension AppBundle {
    convenience init(withPath: URL) {
        self.init()
        
        // init
        id = withPath.lastPathComponent
        path = withPath
        
        let helper = ObjcHelper.init()
        let metadata = helper.getDictionaryOfPlist(atPath: withPath.appendingPathComponent(".com.apple.mobile_container_manager.metadata.plist").path) as! Dictionary<String,Any>
        bundleIdentifier = metadata["MCMMetadataIdentifier"] as! String
        
        bundlePath = getListOfDirectories(atPath: path!).first!
        
        // create bak.assets if it doesn't exist
        let fileManager = FileManager.default
        
        if (fileManager.fileExists(atPath: bundlePath!.appendingPathComponent("Assets.car").path) && !fileManager.fileExists(atPath: bundlePath!.appendingPathComponent("bak.car").path)) {
            helper.copyWithRoot(at: bundlePath!.appendingPathComponent("Assets.car").path, to: bundlePath!.appendingPathComponent("bak.car").path)
        }
    }
}

func getListOfDirectories(atPath: URL) -> [URL] {
    var tmp = [URL]()
    
    do {
        let dir: [URL] = try FileManager.default.contentsOfDirectory(at: atPath, includingPropertiesForKeys: nil)
        for f in dir {
            if f.isDirectory {
                tmp.append(f)
            }
        }
        return tmp
    } catch {
        return tmp
    }
}

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
    @State private var themes: [Theme] = getListOfThemes(atPath: URL(string: "/private/var/mobile/mugunghwa/Themes")!)
    
    var body: some View {
        List {
            ForEach(themes) { theme in
                ThemeRow(theme: theme)
            }
            .onDelete(perform: delete)
        }.navigationTitle("Manage Themes")
            .listStyle(.insetGrouped)
            .onAppear() {
                themes = getListOfThemes(atPath: URL(string: "/private/var/mobile/mugunghwa/Themes")!)
            }
            .toolbar {
                EditButton()
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
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.facetime"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.calculator"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.mobilemail"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.mobilenotes"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.weather"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.Music"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.compass"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.Maps"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.news"))
                    IconView(image: theme.getIcon(bundleIdentifier: "com.apple.podcasts"))
                }
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
