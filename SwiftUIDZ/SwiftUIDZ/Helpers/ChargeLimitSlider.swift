//
//  ChargeLimitSlider.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 03.02.2023.
//

import Foundation

// NeumorphismSlider.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Слайдер в стиле неоморфизма
struct ChargeLimitSlider<V>: View where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {
    // MARK: - Public Properties

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                trackView
                thumbView
                    .frame(width: length, height: length / 1.7)
                    .offset(x: (proxy.size.width - length) * neumorphismSliderViewModel.ratio)
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged {
                                neumorphismSliderViewModel.updateStatus(value: $0, proxy: proxy, length: length)
                            }
                            .onEnded { _ in neumorphismSliderViewModel.startX = nil }
                    )
            }
            .frame(height: length)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { update(value: $0, proxy: proxy) }
            )
            .onAppear {
                neumorphismSliderViewModel.ratio = min(1, max(0, CGFloat(value / bounds.upperBound)))
            }
        }
    }

    // MARK: - Private Properties

    @Binding private var value: V

    @StateObject private var neumorphismSliderViewModel = NeumorphismSliderViewModel()

    private let bounds: ClosedRange<V>
    private let step: V.Stride
    private let length: CGFloat = 50
    private let lineWidth: CGFloat = 2

    private var overlayView: some View {
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
        }.frame(width: 300, height: length / 5)
    }

    private var thumbView: some View {
        TriangleShape()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("GradientTop").opacity(0.5),
                        Color("GradientTop"),
                        Color("GradientBottom")
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    .frame(width: 25, height: 30)
    }

    private var fillingView: some View {
        RoundedRectangle(cornerRadius: length / 2)
            .fill(LinearGradient(
                colors: [Color("GradientTop"), Color("GradientBottom")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .frame(width: CGFloat((value) * 15), height: length / 5)
    }

    // MARK: - Initializers

    init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1) {
        _value = value
        self.bounds = bounds
        self.step = step
    }

    // MARK: - Private Methods

    private func update(value: DragGesture.Value, proxy: GeometryProxy) {
        guard let xValue = neumorphismSliderViewModel.startX else { return }
        neumorphismSliderViewModel.startX = min(length, max(0, xValue))
        var point = value.location.x - xValue
        let delta = proxy.size.width - length
        if point < 0 {
            neumorphismSliderViewModel.startX = value.location.x
            point = 0
        } else if delta < point {
            neumorphismSliderViewModel.startX = value.location.x - delta
            point = delta
        }
        var ratio = point / delta
        if step != 1 {
            let unit = CGFloat(step) / CGFloat(bounds.upperBound)
            let remainder = ratio.remainder(dividingBy: unit)
            if remainder != 0 {
                ratio -= CGFloat(remainder)
            }
        }
        neumorphismSliderViewModel.ratio = ratio
        self.value = V(bounds.upperBound) * V(ratio)
    }
}
