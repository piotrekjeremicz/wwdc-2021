//
//  Compas.swift
//  wwdc2021
//
//  Created by Piotrek on 10/04/2021.
//

import SwiftUI

public struct Compas: View {
    let compasData = CompasModel.Direction.allCases.map { CompasModel(direction: $0) }
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 0.5)
                .frame(width: 250, height: 250)

            ForEach(compasData, id: \.self) { data in
                if data.level == .first {
                    KiteStyled(model: data)
                        .frame(width: 40, height: 160)
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                } else if data.level == .second {
                    KiteStyled(model: data)
                        .frame(width: 40, height: 140)
                }
            }
        }
    }
}

struct KiteStyled: View {
    
    public var model: CompasModel
    
    public init(model: CompasModel) {
        self.model = model
    }
    
    var body: some View {
        let gradient = Gradient(stops: [
            Gradient.Stop(color: .white, location: 0.0),
            Gradient.Stop(color: .white, location: 0.5),
            Gradient.Stop(color: model.color, location: 0.5),
            Gradient.Stop(color: model.color, location: 1.0)
        ])
        GeometryReader { proxy in
            ZStack {
                Kite()
                    .fill(
                        LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
                )
                Kite()
                    .stroke(lineWidth: 2)
                    .foregroundColor(model.color)
                Text(model.text)
                    .font(model.level == .first ? .body : .caption)
                    .rotationEffect(-model.angle)
                    .offset(x: 0, y: -proxy.size.height*0.58)
            }
            .offset(x: 0, y: -proxy.size.height/2)
            .rotationEffect(model.angle)
        }
    }
}

struct Kite: Shape {
    public init() {}
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - rect.height/8))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - rect.height/8))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Compas_Previews: PreviewProvider {
    static var previews: some View {
        Compas()
    }
}
