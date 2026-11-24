//
//  SwiftUIView.swift
//  wwdc2021
//
//  Created by Piotrek on 17/04/2021.
//

import SwiftUI

public struct ViewContainer<Content>: View where Content: View  {
    
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content
    }
    
    public var body: some View {
        VStack {
            content()
        }
        .padding(.all, 20)
        .background(Color(red: 242/255, green: 242/255, blue: 242/255, opacity: 1))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).foregroundColor(.gray))
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.2), radius: 12, x: -8, y: -8)
        .shadow(color: .gray, radius: 12, x: 8, y: 8)
    }
}

public struct TextViewContainer: View {
    
    let title: String
    let description: String
    
    public var body: some View {
        ViewContainer {
            Text(title).font(.title)
            Text(description).font(.body)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TextViewContainer(title: "Title", description: "Description that is longer")
    }
}
