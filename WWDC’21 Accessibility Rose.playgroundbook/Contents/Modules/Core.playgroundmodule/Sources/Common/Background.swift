//
//  Background.swift
//  wwdc2021
//
//  Created by Piotrek on 17/04/2021.
//

import SwiftUI

public struct Background: View {
    public var body: some View {
        GeometryReader { proxy in
            Image(uiImage: UIImage(named: "Background.jpg")!)
                .scaledToFit()
                .opacity(0.2)
                .blur(radius: 20, opaque: false)
                .edgesIgnoringSafeArea(.all)
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}

extension Color {
    static let alwaysBlack = Color(red: 0, green: 0, blue: 0, opacity: 1.0)
}

extension UIColor {
    static let alwaysBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
}
