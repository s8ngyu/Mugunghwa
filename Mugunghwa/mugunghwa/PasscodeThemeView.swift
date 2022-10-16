//
//  PasscodeThemeView.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 9/19/22.
//

import SwiftUI
import UIKit
import PhotosUI

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

struct Backport<Content: View> {
    let content: Content
}

extension View {
    var backport: Backport<Self> { Backport(content: self) }
}

extension Backport {
    @ViewBuilder func applyBorder() -> some View {
        if #available(iOS 15, *) {
            self.content.buttonStyle(.bordered)
        } else {
            self.content
        }
    }
}

func getPath() -> String {
    let fileManager = FileManager.default
   
    if fileManager.fileExists(atPath: "/private/var/mobile/Library/Caches/TelephonyUI-8") {
        return "/private/var/mobile/Library/Caches/TelephonyUI-8"
    }
    
    let path = "/private/var/mobile/Library/Caches/"
    do {
        let paths = try fileManager.contentsOfDirectory(at: URL(string: path)!, includingPropertiesForKeys: nil)
        var names = [String]()
        
        for path in paths {
            names.append(path.lastPathComponent)
        }
        
        let name = names.filter({ $0.hasPrefix("Telep") })
        
        let tryPath = URL(string: path)!.appendingPathComponent(name[0])
        
        return tryPath.path
    } catch {
        print("error")
    }
    
    return "null"
}

func getValidNames(_ num: Int) -> [String] {
    var pathsToReturn = [String]()
    let fileManager = FileManager.default
    do {
        let paths = try fileManager.contentsOfDirectory(at: URL(string: getPath())!, includingPropertiesForKeys: nil)
        var names = [String]()
        
        for path in paths {
            names.append(path.lastPathComponent)
        }
        
        let name  = names.filter { path in
            return path.contains(String(num))
        }
        pathsToReturn = name
        
    } catch {
        print("error")
    }
    
    
    return pathsToReturn
}

func getPathFor(_ num: Int) -> [String] {
    var paths = [String]()
    for e in getValidNames(num) {
        paths.append(URL(string: getPath())!.appendingPathComponent(e).path)
    }
    
    return paths
}

func getOriginalPathFor(_ num: Int) -> [String] {
    var paths = [String]()
    for e in getValidNames(num) {
        paths.append(URL(string: "/private/var/mobile/mugunghwa/Telephone")!.appendingPathComponent(e).path)
    }
    
    return paths
}

func getImageFor(_ num: Int) -> UIImage {
    if checkSandbox() {
        return UIImage(systemName: "star")!
    }
    
    let imagePath: [String] = getPathFor(num)
    
    let helper = ObjcHelper.init()
    let image: UIImage = helper.getImageFromData(imagePath[0])
    
    return image
}

func getOriginalImageFor(_ num: Int) -> UIImage {
    if checkSandbox() {
        return UIImage(systemName: "star")!
    }
    
    let imagePath = getOriginalPathFor(num)
    let helper = ObjcHelper.init()
    let image: UIImage = helper.getImageFromData(imagePath[0])
    
    return image
}

func applyImage(_ newValue: UIImage, num: Int) {
    let image = getImageFor(num)
    var resized = newValue.imageResized(to: CGSize(width: image.size.width, height: image.size.height))
    resized = resized.imageResized(to: CGSize(width: resized.size.width/resized.scale, height: resized.size.height/resized.scale))
    let helper = ObjcHelper.init()
    for e in getPathFor(num) {
        helper.save(resized, atPath: e)
    }
}

struct PasscodeThemeView: View {
    @State private var zeroImage = getImageFor(0)
    @State private var oneImage = getImageFor(1)
    @State private var twoImage = getImageFor(2)
    @State private var threeImage = getImageFor(3)
    @State private var fourImage = getImageFor(4)
    @State private var fiveImage = getImageFor(5)
    @State private var sixImage = getImageFor(6)
    @State private var sevenImage = getImageFor(7)
    @State private var eightImage = getImageFor(8)
    @State private var nineImage = getImageFor(9)
    
    @State private var zeroPickedImage = UIImage()
    @State private var onePickedImage = UIImage()
    @State private var twoPickedImage = UIImage()
    @State private var threePickedImage = UIImage()
    @State private var fourPickedImage = UIImage()
    @State private var fivePickedImage = UIImage()
    @State private var sixPickedImage = UIImage()
    @State private var sevenPickedImage = UIImage()
    @State private var eightPickedImage = UIImage()
    @State private var ninePickedImage = UIImage()
    
    @State private var zeroShowing = false
    @State private var oneShowing = false
    @State private var twoShowing = false
    @State private var threeShowing = false
    @State private var fourShowing = false
    @State private var fiveShowing = false
    @State private var sixShowing = false
    @State private var sevenShowing = false
    @State private var eightShowing = false
    @State private var nineShowing = false
    
    @State private var zeroPicker = false
    @State private var onePicker = false
    @State private var twoPicker = false
    @State private var threePicker = false
    @State private var fourPicker = false
    @State private var fivePicker = false
    @State private var sixPicker = false
    @State private var sevenPicker = false
    @State private var eightPicker = false
    @State private var ninePicker = false
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Group {
                VStack {
                    HStack {
                        Button(action: {
                            //1
                            oneShowing.toggle()
                        }) {
                            Image(uiImage: oneImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $oneShowing) {
                            ActionSheet(title: Text("1"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        onePicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        onePickedImage = getOriginalImageFor(1)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $onePicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $onePickedImage)
                        }.onChange(of: onePickedImage) { [onePickedImage] newValue in
                            if onePickedImage != newValue {
                                applyImage(newValue, num: 1)
                                oneImage = newValue
                            }
                        }
                        
                        Button(action: {
                            //2
                            twoShowing.toggle()
                        }) {
                            Image(uiImage: twoImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $twoShowing) {
                            ActionSheet(title: Text("2"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        twoPicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        twoPickedImage = getOriginalImageFor(2)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $twoPicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $twoPickedImage)
                        }.onChange(of: twoPickedImage) { [twoPickedImage] newValue in
                            if twoPickedImage != newValue {
                                applyImage(newValue, num: 2)
                                twoImage = newValue
                            }
                        }
                        
                        Button(action: {
                            //3
                            threeShowing.toggle()
                        }) {
                            Image(uiImage: threeImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $threeShowing) {
                            ActionSheet(title: Text("3"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        threePicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        threePickedImage = getOriginalImageFor(3)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $threePicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $threePickedImage)
                        }.onChange(of: threePickedImage) { [threePickedImage] newValue in
                            if threePickedImage != newValue {
                                applyImage(newValue, num: 3)
                                threeImage = newValue
                            }
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            //4
                            fourShowing.toggle()
                        }) {
                            Image(uiImage: fourImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $fourShowing) {
                            ActionSheet(title: Text("4"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        fourPicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        fourPickedImage = getOriginalImageFor(4)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $fourPicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $fourPickedImage)
                        }.onChange(of: fourPickedImage) { [fourPickedImage] newValue in
                            if fourPickedImage != newValue {
                                applyImage(newValue, num: 4)
                                fourImage = newValue
                            }
                        }
                        
                        Button(action: {
                            //5
                            fiveShowing.toggle()
                        }) {
                            Image(uiImage: fiveImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $fiveShowing) {
                            ActionSheet(title: Text("5"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        fivePicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        fivePickedImage = getOriginalImageFor(5)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $fivePicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $fivePickedImage)
                        }.onChange(of: fivePickedImage) { [fivePickedImage] newValue in
                            if fivePickedImage != newValue {
                                applyImage(newValue, num: 5)
                                fiveImage = newValue
                            }
                        }
                        
                        Button(action: {
                            //6
                            sixShowing.toggle()
                        }) {
                            Image(uiImage: sixImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $sixShowing) {
                            ActionSheet(title: Text("6"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        sixPicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        sixPickedImage = getOriginalImageFor(6)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $sixPicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $sixPickedImage)
                        }.onChange(of: sixPickedImage) { [sixPickedImage] newValue in
                            if sixPickedImage != newValue {
                                applyImage(newValue, num: 6)
                                sixImage = newValue
                            }
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            //7
                            sevenShowing.toggle()
                        }) {
                            Image(uiImage: sevenImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $sevenShowing) {
                            ActionSheet(title: Text("7"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        sevenPicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        sevenPickedImage = getOriginalImageFor(7)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $sevenPicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $sevenPickedImage)
                        }.onChange(of: sevenPickedImage) { [sevenPickedImage] newValue in
                            if sevenPickedImage != newValue {
                                applyImage(newValue, num: 7)
                                sevenImage = newValue
                            }
                        }
                        
                        Button(action: {
                            //8
                            eightShowing.toggle()
                        }) {
                            Image(uiImage: eightImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $eightShowing) {
                            ActionSheet(title: Text("8"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        eightPicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        eightPickedImage = getOriginalImageFor(8)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $eightPicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $eightPickedImage)
                        }.onChange(of: eightPickedImage) { [eightPickedImage] newValue in
                            if eightPickedImage != newValue {
                                applyImage(newValue, num: 8)
                                eightImage = newValue
                            }
                        }
                        
                        Button(action: {
                            //9
                            nineShowing.toggle()
                        }) {
                            Image(uiImage: nineImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $nineShowing) {
                            ActionSheet(title: Text("9"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        ninePicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        ninePickedImage = getOriginalImageFor(9)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $ninePicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $ninePickedImage)
                        }.onChange(of: ninePickedImage) { [ninePickedImage] newValue in
                            if ninePickedImage != newValue {
                                applyImage(newValue, num: 9)
                                nineImage = newValue
                            }
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            //0
                            zeroShowing.toggle()
                        }) {
                            Image(uiImage: zeroImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }.actionSheet(isPresented: $zeroShowing) {
                            ActionSheet(title: Text("0"), message: Text("Choose an option."), buttons: [
                                .default(
                                    Text("Choose from Photo Library"),
                                    action: {
                                        zeroPicker.toggle()
                                    }
                                ),
                                .destructive(
                                    Text("Revert to original"),
                                    action: {
                                        zeroPickedImage = getOriginalImageFor(0)
                                    }
                                ),
                                .cancel(Text("Cancel"))
                            ])
                        }.sheet(isPresented: $zeroPicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $zeroPickedImage)
                        }.onChange(of: zeroPickedImage) { [zeroPickedImage] newValue in
                            if zeroPickedImage != newValue {
                                applyImage(newValue, num: 0)
                                zeroImage = newValue
                            }
                        }
                    }
                    
                }.backport.applyBorder()
                Spacer()
            }.onAppear() {
                // backup
                if !FileManager.default.fileExists(atPath: "/private/var/mobile/mugunghwa/Telephone") {
                    do {
                        try FileManager.default.copyItem(atPath: getPath(), toPath: "/private/var/mobile/mugunghwa/Telephone")
                    } catch {
                        print("error")
                    }
                }
                
                zeroImage = getImageFor(0)
                oneImage = getImageFor(1)
                twoImage = getImageFor(2)
                threeImage = getImageFor(3)
                fourImage = getImageFor(4)
                fiveImage = getImageFor(5)
                sixImage = getImageFor(6)
                sevenImage = getImageFor(7)
                eightImage = getImageFor(8)
                nineImage = getImageFor(9)
                
            }
        }.navigationTitle("Passcode Theming")
    }
}




struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}

struct PasscodeThemeView_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeThemeView()
    }
}
