//
//  Page3.swift
//  wwdc2021
//
//  Created by Piotrek on 15/04/2021.
//

import SwiftUI

public struct Page3: View {
    
    @State var screenCenter = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    
    @State var userRotation = Angle(degrees: 0)
    @State private var soundMarkers: [SoundMarker] = []
    
    public init() { }
    
    public var body: some View {
        let doubleTapGesture = ClickGesture(count: 2)
            .onEnded { point in
                guard soundMarkers.count < 5 else { return }
                
                let newSoundMarker = SoundMarker(position: point, userDirection: $userRotation, userPosition: $screenCenter)
                
                soundMarkers.append(newSoundMarker)
            }
            
        let rotateGesture = RotationGesture()
            .onChanged { angle in
                userRotation = angle
                soundMarkers.forEach { marker in
                    marker.update()
                }
            }
        return ZStack {
            GeometryReader { proxy in
                Background()
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            screenCenter = CGPoint(x: proxy.frame(in: .global).midX, y: proxy.frame(in: .global).midY)
                        }
                    })
            }
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(.gray)
                .frame(width: 580, height: 580)
                .padding()
            
            UserMarker(userRotation: $userRotation)
            ForEach(soundMarkers) { soundMarker in
                soundMarker
            }
            Button {
                soundMarkers.removeAll()
            } label: {
                Image(systemName: "speaker.slash.fill")
                Text("Remove all sounds")
            }
            .padding()
            .frame(minWidth: 200)
            .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(lineWidth: 2).foregroundColor(.blue))
            .padding(.top, 660)

        }
        .gesture(doubleTapGesture)
        .gesture(rotateGesture)
    }
}

struct Page3_Previews: PreviewProvider {
    static var previews: some View {
        Page3()
            .previewLayout(.fixed(width: 597, height: 720))
    }
}
