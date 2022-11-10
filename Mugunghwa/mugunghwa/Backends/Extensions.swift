//
//  Extensions.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 08/11/2022.
//

import Foundation
import SwiftUI

var alert: UIAlertController?

extension UIApplication {
    func indicator(title: String) {
        DispatchQueue.main.async {
            alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .medium
            activityIndicator.startAnimating()
            alert!.view.addSubview(activityIndicator)
            
            if var topController = self.windows[0].rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                topController.present(alert!, animated: true)
            }
        }
    }
    
    func plainAlert(title: String, message: String) {
        DispatchQueue.main.async {
            alert?.title = title
            alert?.message = message
            let cancelAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil)
            alert?.addAction(cancelAction)
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            alert?.dismiss(animated: true)
        }
    }
}

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
            self.content.foregroundColor(.gray)
        }
    }
    
    @ViewBuilder func applyProminentBorder() -> some View {
        if #available(iOS 15, *) {
            self.content.buttonStyle(.borderedProminent)
        } else {
            self.content.foregroundColor(.gray)
        }
    }
}

extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}
