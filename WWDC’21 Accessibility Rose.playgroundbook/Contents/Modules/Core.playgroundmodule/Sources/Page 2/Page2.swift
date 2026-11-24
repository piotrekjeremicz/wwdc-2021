//
//  Page2.swift
//  wwdc2021
//
//  Created by Piotrek on 12/04/2021.
//

import SwiftUI

public struct Page2: View {
    @State private var updateInterval: Double = 60
    @State private var maximumDataAmmount: Double = 50
    @State private var measurmentAccuracy: Double = 0.1
    
    @ObservedObject var motion: MotionManager = MotionManager()
    
    public init() { }
    
    public var body: some View {
        ZStack {
            Background()
            VStack {
                Group {
                    GraphCompas(data: motion.graphData)
                        .frame(width: 160, height: 160)
                        .scaleEffect(0.8)
                }
                .frame(width: 400, height: 400)
                
                ViewContainer() {
                    CustomSlider(
                        bindingValue: $measurmentAccuracy,
                        in: 0.001...1,
                        step: 0.05,
                        title: "Accuracy: \(String(format: "%.2f", measurmentAccuracy))",
                        minimumValueLabel: "0.001",
                        maximumValueLabel: "1") { (value) in
                        motion.measurmentAccuracy = value
                    }
                    
                    CustomSlider(
                        bindingValue: $updateInterval,
                        in: 1...60,
                        step: 1,
                        title: "Update Interval: \(Int(updateInterval))fps",
                        minimumValueLabel: "1fps",
                        maximumValueLabel: "60fps") { (value) in
                        motion.updateInterval = 1/value
                    }
                    
                    CustomSlider(
                        bindingValue: $maximumDataAmmount,
                        in: 10...150,
                        step: 10,
                        title: "Maximum data ammount \(Int(maximumDataAmmount))",
                        minimumValueLabel: "10",
                        maximumValueLabel: "150") { (value) in
                        motion.maximumDataAmmount = Int(value)
                    }
                    .padding(.bottom, 10)
                    Button(action: { motion.graphData = [] }, label: {
                        Image(systemName: "minus.circle.fill")
                        Text("Clear").bold()
                    })
                    .frame(minWidth: 200)
                    .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(lineWidth: 2).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/))
                }
                .frame(width: 500)
            }
            .onAppear(perform: setupMotionManager)
            .padding()
        }
    }
    
    private func setupMotionManager() {
        motion.updateInterval = 1/updateInterval
        motion.measurmentAccuracy = measurmentAccuracy
        motion.maximumDataAmmount = Int(maximumDataAmmount)
    }
}

public struct CustomSlider: View {
    public let bindingValue: Binding<Double>
    public let `in`: ClosedRange<Double>
    public let step: Double

    public let title: String
    public let minimumValueLabel: String
    public let maximumValueLabel: String
    
    public let onChange: (_ value: Double) -> ()
    
    public init(bindingValue: Binding<Double>, in inValue: ClosedRange<Double>, step: Double, title: String, minimumValueLabel: String, maximumValueLabel: String, onChange: @escaping (_ value: Double) -> ()) {
        self.bindingValue = bindingValue
        self.in = inValue
        self.step = step
        
        self.title = title
        self.minimumValueLabel = minimumValueLabel
        self.maximumValueLabel = maximumValueLabel
        
        self.onChange = onChange
    }
    
    public var body: some View {
        VStack{
            Text(title).foregroundColor(.alwaysBlack)
            Slider(
                value: bindingValue,
                in: `in`,
                step: step,
                minimumValueLabel: Text(minimumValueLabel).foregroundColor(.alwaysBlack),
                maximumValueLabel: Text(maximumValueLabel).foregroundColor(.alwaysBlack),
                label: { Text(title).foregroundColor(.alwaysBlack) }
            )
            .onChange(of: bindingValue.wrappedValue, perform: { value in
                onChange(value)
            })
        }
    }
}

struct Page2_Previews: PreviewProvider {
    static var previews: some View {
        Page2()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 597, height: 720))
    }
}
