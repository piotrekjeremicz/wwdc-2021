//
//  DubMarker.swift
//  wwdc2021
//
//  Created by Piotrek on 20/04/2021.
//

import SwiftUI

public struct DubMarker: View, Identifiable {
    public var id = UUID()
    
    @State public var position: CGPoint
    
    public init(position: CGPoint) {
        self._position = State(initialValue: position)
    }
    
    public var body: some View {
        Circle()
            .frame(width: 30, height: 30)
            .foregroundColor(.red)
            .overlay(
                Circle()
                    .stroke(lineWidth: 4)
                    .foregroundColor(.white)
            )
            .shadow(radius: 4)
            .offset(CGSize(width: position.x, height: position.y))
    }
}

struct DubMarker_Previews: PreviewProvider {
    static var previews: some View {
        DubMarker(position: .zero)
    }
}
