//
//  GraphCompas.swift
//  wwdc2021
//
//  Created by Piotrek on 11/04/2021.
//

import SwiftUI

public struct GraphCompas: View {
    
    public let data: [GraphModel]
    
    public init(data: [GraphModel]) {
        self.data = data
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .frame(width: proxy.size.width*2, height: 2)
                Rectangle()
                    .frame(width: 2, height: proxy.size.height*2)
                ForEach(1..<5) { i in
                    Circle()
                        .stroke()
                        .frame(width: proxy.size.width*CGFloat(i)*0.5, height: proxy.size.height*CGFloat(i)*0.5)
                }
                
                ForEach(data, id: \.self) { data in
                    PieSliceView(color: data.color, amount: data.amount)
                        .rotationEffect(.degrees(22.5*Double(data.direction.rawValue)))
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                
                Text("N")
                    .font(.title)
                    .offset(.init(width: 0, height: -proxy.size.height - 26))
                Text("E")
                    .font(.title)
                    .offset(.init(width: proxy.size.width + 26, height: 0))
                Text("S")
                    .font(.title)
                    .offset(.init(width: 0, height: proxy.size.height + 26))
                Text("W")
                    .font(.title)
                    .offset(.init(width: -proxy.size.width - 26, height: 0))
            }
            .offset(.init(width: -proxy.size.width/2, height: -proxy.size.height/2))
        }
    }
}

public struct PieSliceView: View {
    
    public let color: Color
    public let amount: CGFloat
    
    public init(color: Color, amount: CGFloat) {
        self.color = color
        self.amount = amount
    }
    
    public var body: some View {
        PieSlice(amount: amount)
            .foregroundColor(color)
            .zIndex(Double(1-amount))
            .rotationEffect(.degrees(-100))
        PieSlice(amount: amount)
            .stroke()
            .rotationEffect(.degrees(-100))
            .zIndex(2)
    }
}

public struct PieSlice: Shape {
    public let amount: CGFloat
    public let startAngle: Angle
    public let endAngle: Angle
    
    public init(amount: CGFloat, startAngle: Angle = .degrees(1), endAngle: Angle = .degrees(21)) {
        self.amount = amount
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .init(x: rect.midX, y: rect.midY))
        path.addArc(center: .init(x: rect.midX, y: rect.midY), radius: rect.height*amount, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addLine(to: .init(x: rect.midX, y: rect.midY))
        return path
    }
}

struct GraphCompas_Previews: PreviewProvider {
    static var previews: some View {
        GraphCompas(data: GraphData.data)
            .frame(width: 160, height: 160)
    }
}
