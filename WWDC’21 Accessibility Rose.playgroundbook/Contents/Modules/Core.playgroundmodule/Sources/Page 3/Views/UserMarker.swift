//
//  UserMarker.swift
//  wwdc2021
//
//  Created by Piotrek on 14/04/2021.
//

import SwiftUI

public struct UserMarker: View {
    
    @Binding var userRotation: Angle
    
    public init(userRotation: Binding<Angle>) {
        self._userRotation = userRotation
    }
    
    public var body: some View {
        ZStack {
            PieSlice(amount: 0.10, startAngle: .degrees(0), endAngle: .degrees(90))
                .rotation(.init(degrees: userRotation.degrees - 135))
                .foregroundColor(Color.blue.opacity(0.5))

            Circle()
                .foregroundColor(.blue)
                .frame(width: 30, height: 30)
                .overlay(
                    Circle()
                        .stroke(lineWidth: 4)
                        .foregroundColor(.white)
                )
                .shadow(radius: 4)
        }
    }
}

struct UserMarker_Previews: PreviewProvider {
    static var previews: some View {
        UserMarker(userRotation: .constant(.degrees(0)))
    }
}
