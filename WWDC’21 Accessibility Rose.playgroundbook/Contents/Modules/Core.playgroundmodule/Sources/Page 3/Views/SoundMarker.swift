//
//  SoundMarker.swift
//  wwdc2021
//
//  Created by Piotrek on 14/04/2021.
//

import SwiftUI

public struct SoundMarker: View, Identifiable {
    public var id = UUID()
    public var distance: CGFloat = 300
    
    @State var position: CGPoint
    
    @Binding var userDirection: Angle
    @Binding var userPosition: CGPoint
    
    private let soundPlayer = AudioPlayer()
    
    public init(position: CGPoint, userDirection: Binding<Angle>, userPosition: Binding<CGPoint>) {
        self._position = State(initialValue: position)
        self._userDirection = userDirection
        self._userPosition = userPosition
    }
    
    public var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                self.position = value.location
                self.update(sound: value.location)
            }
        
        return Circle()
            .frame(width: 50, height: 50)
            .foregroundColor(.green)
            .overlay(
                Circle()
                    .stroke(lineWidth: 4)
                    .foregroundColor(.white)
            )
            .shadow(radius: 4)
            .position(position)
            .gesture(dragGesture)
            .onAppear(perform: {
                soundPlayer.load(sound: AudioPlayer.Sound.allCases.randomElement()!) {
                    update(sound: position)
                }
            })
    }
    
    public func update(sound position: CGPoint) {
        self.position = position
        self.update()
    }
    
    public func update() {
        let vector = Vector(start: position, end: userPosition)
        let degreesUserAngle = userDirection.degrees > 0 ? userDirection.degrees : (360 - abs(userDirection.degrees))
        let degreesSoundAngle = vector.angle.degrees < 0 ? abs(vector.angle.degrees) : 360 - vector.angle.degrees
        
        let deltaSoundAngle = (degreesSoundAngle - degreesUserAngle) > 0 ? (degreesSoundAngle - degreesUserAngle) : 360 + (degreesSoundAngle - degreesUserAngle)
        let degreesTranslation = deltaSoundAngle <= 180 ? deltaSoundAngle : -(180 - (deltaSoundAngle - 180))

        let pan: Float
        let reducer: Float
        let side: Float = degreesTranslation > 0 ? 1 : -1
        
        if (0...90).contains(abs(degreesTranslation)) {
            pan = Float(abs(degreesTranslation)/90)*side
            reducer = 0
        } else  {
            pan = Float(1-(abs(degreesTranslation)/90-1))*side
            reducer = 0.5 - abs(pan)/2
        }

        let volume = 1 - reducer - Float(vector.size/distance)

        soundPlayer.pan = Float(pan)
        soundPlayer.volume = volume > 0 ? volume : 0
    }
}

struct SoundMarker_Previews: PreviewProvider {
    static var previews: some View {
        SoundMarker(position: .init(x: 200, y: 200), userDirection: .constant(.init(degrees: 0)), userPosition: .constant(.init(x: 100, y: 100)))
    }
}
