//
//  RangedSliderView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 05.02.2023.
//

import SwiftUI

/// Cлайдер с 2 тумблерами
struct RangedSliderView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let darkPurpleColorName = "darkPurple"
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        GeometryReader { geomentry in
            sliderView(sliderSize: geomentry.size)
        }
    }
    
    // MARK: - Private Properties
    
    private  let currentValue: Binding<ClosedRange<Float>>
    private  let sliderBounds: ClosedRange<Int>
    
    // MARK: - Initializers
    
    public init(value: Binding<ClosedRange<Float>>, bounds: ClosedRange<Int>) {
        self.currentValue = value
        self.sliderBounds = bounds
    }
    
    // MARK: - Private Methods
    
    @ViewBuilder private func sliderView(sliderSize: CGSize) -> some View {
        let sliderViewYCenter = sliderSize.height / 2
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray.opacity(0.5))
                .frame(height: 10)
            ZStack {
                let sliderBoundDifference = sliderBounds.count
                let stepWidthInPixel = CGFloat(sliderSize.width)  / CGFloat(sliderBoundDifference)
                let leftThumbLocation: CGFloat = currentValue.wrappedValue.lowerBound == Float(sliderBounds.lowerBound)
                ? 0
                : CGFloat(currentValue.wrappedValue.lowerBound - Float(sliderBounds.lowerBound)) * stepWidthInPixel
                let rightThumbLocation = CGFloat(currentValue.wrappedValue.upperBound) * stepWidthInPixel
                lineBetweenThumbs(from: .init(x: leftThumbLocation, y: sliderViewYCenter), to: .init(x: rightThumbLocation, y: sliderViewYCenter))
                let leftThumbPoint = CGPoint(x: leftThumbLocation, y: sliderViewYCenter)
                thumbView(position: leftThumbPoint, value: Float(currentValue.wrappedValue.lowerBound))
                    .highPriorityGesture(DragGesture().onChanged { dragValue in
                        let dragLocation = dragValue.location
                        let xThumbOffset = min(max(0, dragLocation.x), sliderSize.width)
                        let newValue = Float(sliderBounds.lowerBound) + Float(xThumbOffset / stepWidthInPixel)
                        if newValue < currentValue.wrappedValue.upperBound {
                            currentValue.wrappedValue = newValue...currentValue.wrappedValue.upperBound
                        }
                    })
                thumbView(position: CGPoint(x: rightThumbLocation, y: sliderViewYCenter), value: currentValue.wrappedValue.upperBound)
                    .highPriorityGesture(DragGesture().onChanged { dragValue in
                        let dragLocation = dragValue.location
                        let xThumbOffset = min(max(CGFloat(leftThumbLocation), dragLocation.x), sliderSize.width)
                        var newValue = Float(xThumbOffset / stepWidthInPixel)
                        newValue = min(newValue, Float(sliderBounds.upperBound))
                        if newValue > currentValue.wrappedValue.lowerBound {
                            currentValue.wrappedValue = currentValue.wrappedValue.lowerBound...newValue
                        }
                    })
            }
        }
    }
    
    @ViewBuilder private func lineBetweenThumbs(from: CGPoint, to: CGPoint) -> some View {
        Path { path in
            path.move(to: from)
            path.addLine(to: to)
        }.stroke(Color(Constants.darkPurpleColorName), lineWidth: 10)
    }
    
    @ViewBuilder private func thumbView(position: CGPoint, value: Float) -> some View {
        ZStack {
            Circle()
                .frame(width: 24, height: 24)
                .foregroundColor(.yellow)
                .shadow(color: Color.black.opacity(0.16), radius: 8, x: 0, y: 2)
                .contentShape(Rectangle())
            Text("$\(Int(value))")
                .font(.system(size: 15, weight: .bold))
                .offset(y: 25)
        }
        .position(x: position.x, y: position.y)
    }
}
