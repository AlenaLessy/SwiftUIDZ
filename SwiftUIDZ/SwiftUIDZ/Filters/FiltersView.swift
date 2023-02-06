//
//  FiltersView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 05.02.2023.
//

import SwiftUI

/// Экран  фильтра
struct FiltersView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let alertText = "Settings apply"
        static let updateButtonTitleText = "Update Settings"
        static let chevronLeftSystemImageName = "chevron.left"
        static let chevronRightSystemImageName = "chevron.right"
        static let toolBarItemText = "Filters"
        static let gradientColorTwoName = "gr"
        static let filterImageName = "filt"
        static let categoryText = "Category"
        static let MoreText = "More"
        static let colorText = "Color"
        static let pricingText = "Pricing"
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack {
            gradientNavigationView
            VStack {
                categoryView
                furnituresLazyHGridView
                    .offset(y: -70)
                pricingSliderValue
                colorTextView
                colorsView
                Spacer()
            }
        }
        .hiddenTabBar()
        .toolbar {
            ToolbarItem(placement: .principal) {
                toolbarNotificationTitleTextView
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButtonView)
        .navigationBarItems(trailing: filterButtonView)
    }
    
    // MARK: - Private Properties
    
    private let rows: [GridItem] = [
        .init(.fixed(250))]
    
    private let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    @Environment(\.presentationMode) var presentation
    
    @StateObject private var filtersViewModel = FilterViewModel()
    
    private var pricingSliderValue: some View {
        VStack {
            HStack {
                Text(Constants.pricingText)
                    .font(.largeTitle)
                    .foregroundColor(.black.opacity(0.7))
                    .bold()
                Spacer()
            }
            .padding(.leading, 20)
            RangedSliderView(value: $filtersViewModel.sliderPositionValues, bounds: 100...5000)
                .padding(.horizontal, 50)
        }
        .offset(y: -70)
    }
    
    private var colorTextView: some View {
        HStack {
            Text(Constants.colorText)
                .foregroundColor(filtersViewModel.currentColor)
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    private var colorsView: some View {
        LazyVGrid(columns: columns) {
            ForEach(filtersViewModel.getColors(), id: \.self) { color in
                selectColorButtonView(color: color)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var furnituresLazyHGridView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(filtersViewModel.getFurnitureImageNames(), id: \.self) { name in
                    furnitureView(name: name)
                }
                .padding(.leading, 5)
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var categoryView: some View {
        HStack {
            Text(Constants.categoryText)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black.opacity(0.7))
            Spacer()
            Text(Constants.MoreText)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black.opacity(0.2))
            Image(systemName: Constants.chevronRightSystemImageName)
                .resizable()
                .frame(width: 15, height: 25)
                .foregroundColor(.black.opacity(0.2))
        }
        .padding(.horizontal, 20)
    }
    
    private var gradientNavigationView: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: 50)
            .background(LinearGradient(
                colors: [.yellow, Color(Constants.gradientColorTwoName)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            )
            .ignoresSafeArea(.all)
    }
    
    private var backButtonView: some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Image(systemName: Constants.chevronLeftSystemImageName)
                .resizable()
                .frame(width: 20, height: 30)
                .foregroundColor(.white)
        }
    }
    
    private var filterButtonView: some View {
        Button {
        } label: {
            Image(Constants.filterImageName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
        }
    }
    
    private var toolbarNotificationTitleTextView: Text {
        Text(Constants.toolBarItemText)
            .font(.title)
            .foregroundColor(.white)
            .bold()
    }
    
    // MARK: - Private Methods
    
    private func selectColorButtonView(color: Color) -> some View {
        Button {
            filtersViewModel.currentColor = color
        } label: {
            Circle()
                .foregroundColor(color)
                .frame(width: 45)
                .overlay(Circle()
                    .stroke(Color.gray.opacity(0.5), lineWidth: 3))
        }
    }
    
    private func furnitureView(name: String) -> some View {
        ZStack {
            Rectangle()
                .shadow(color: .black.opacity(0.2), radius: 10)
                .foregroundColor(.white)
                .frame(width: 160, height: 130)
            Image(name)
                .resizable()
                .frame(width: 100, height: 100)
                .offset(y: -5)
        }
    }
}

struct FiltersView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        FiltersView()
    }
}
