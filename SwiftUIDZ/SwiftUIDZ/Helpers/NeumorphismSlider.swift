//
//  LockerSlider.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 01.02.2023.
//

import SwiftUI

/// Слайдер в стиле неоморфизма
struct NeumorphismSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    
    // MARK: - Public Properties

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                trackView
                fillingView
                thumbView
                    .frame(width: length, height: length/1.7)
                    .offset(x: (proxy.size.width - length) * ratio)
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
                    .gesture(DragGesture(minimumDistance: 0)
                                .onChanged({ updateStatus(value: $0, proxy: proxy) })
                                .onEnded { _ in startX = nil })
            }
            .frame(height: length)
            .simultaneousGesture(DragGesture(minimumDistance: 0)
            .onChanged({ update(value: $0, proxy: proxy) }))
            .onAppear {
                ratio = min(1, max(0,CGFloat(value / bounds.upperBound)))
            }
        }
    }
    
    // MARK: - Private Properties
    
    @Binding private var value: V
    
    @State private var ratio: CGFloat   = 0
    @State private var startX: CGFloat? = nil
    
    private let bounds: ClosedRange<V>
    private let step: V.Stride
    private let length: CGFloat    = 50
    private let lineWidth: CGFloat = 2
    
    private var overlay: some View {
        RoundedRectangle(cornerRadius: (length + lineWidth) / lineWidth)
            .stroke(Color.gray, lineWidth: lineWidth)
            .frame(height: length + lineWidth)
    }
    
    private var trackView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: length / 2)
                .fill(Color("buttonBackground").opacity(0.5))
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.black.opacity(1), lineWidth: 1)
                        .blur(radius: 1)
                        .offset(x: 2, y: 2)
                        .mask(RoundedRectangle(cornerRadius: length / 2).fill(LinearGradient(Color.black, Color.clear)))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: length / 2)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        .blur(radius: 1)
                        .offset(x: -2, y: -2)
                        .mask(RoundedRectangle(cornerRadius: length / 2).fill(LinearGradient(Color.clear, Color.black)))
                )
        }.frame(width: 230, height: length / 5)
    }
    
    private var thumbView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(colors: [Color.white.opacity(0.15), Color.black.opacity(0.35)], startPoint: .top, endPoint: .bottomTrailing))
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(LinearGradient(colors: [Color.black.opacity(0.6), Color.white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.8))
                .padding(.all, 0)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("back2")))
            HStack(spacing: 3) {
                ZStack {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color("buttonBackground").opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.black.opacity(1), lineWidth: 1)
                                .blur(radius: 1)
                                .offset(x: 2, y: 2)
                                .mask(RoundedRectangle(cornerRadius: 3).fill(LinearGradient(Color.black, Color.clear)))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                                .blur(radius: 1)
                                .offset(x: -2, y: -2)
                                .mask(RoundedRectangle(cornerRadius: 3).fill(LinearGradient(Color.clear, Color.black)))
                        )
                }.frame(width: 7, height: 25)
                ZStack {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color("buttonBackground").opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.black.opacity(1), lineWidth: 1)
                                .blur(radius: 1)
                                .offset(x: 2, y: 2)
                                .mask(RoundedRectangle(cornerRadius: 3).fill(LinearGradient(Color.black, Color.clear)))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                                .blur(radius: 1)
                                .offset(x: -2, y: -2)
                                .mask(RoundedRectangle(cornerRadius: 3).fill(LinearGradient(Color.clear, Color.black)))
                        )
                }.frame(width: 7, height: 25)
            }
        }
    }
    
    private var fillingView: some View {
        RoundedRectangle(cornerRadius: length / 2)
            .fill(LinearGradient(colors: [Color("GradientTop"), Color("GradientBottom")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: CGFloat(value * 15), height: length / 5)
    }

    // MARK: - Initializers
    
    init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1) {
        _value  = value
        self.bounds = bounds
        self.step   = step
    }

   // MARK: - Private Methods
    
    private func updateStatus(value: DragGesture.Value, proxy: GeometryProxy) {
        guard startX == nil else { return }
    
        let delta = value.startLocation.x - (proxy.size.width - length) * ratio
        startX = (length < value.startLocation.x && 0 < delta) ? delta : value.startLocation.x
    }

    private func update(value: DragGesture.Value, proxy: GeometryProxy) {
        guard let x = startX else { return }
        startX = min(length, max(0, x))
        var point = value.location.x - x
        let delta = proxy.size.width - length
        if point < 0 {
            startX = value.location.x
            point = 0
        } else if delta < point {
            startX = value.location.x - delta
            point = delta
        }
        var ratio = point / delta
        if step != 1 {
            let unit = CGFloat(step) / CGFloat(bounds.upperBound)
            let remainder = ratio.remainder(dividingBy: unit)
            if remainder != 0 {
                ratio = ratio - CGFloat(remainder)
            }
        }
        self.ratio = ratio
        self.value = V(bounds.upperBound) * V(ratio)
    }
}
