//
//  GoodsView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import SwiftUI

/// Экран  настройки уведомлений
struct GoodsView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let gradientColorTwoName = "gr"
        static let filterImageName = "filt"
        static let magnifyingglassSystemImageName = "magnifyingglass"
        static let placeholderTextfieldText = "search..."
        static let xmarkCircleSystemImageName = "xmark.circle.fill"
        static let totalAmountText = "Сумма покупок - "
        static let dollarSymbol = "$"
        static let plusSystemImageName = "plus"
        static let minusSystemImageName = "minus"
        static let darkPurpleColorName = "darkPurple"
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ZStack {
                    gradientNavigationView
                    HStack {
                        searchBar
                        NavigationLink(Constants.emptyString, destination: FiltersView(), isActive: $goodsViewModel.isFilterButtonPressed)
                        filterButtonView
                    }
                }
                VStack(spacing: 20) {
                    totalAmountPurchasesView
                    ScrollView(showsIndicators: false) {
                        productsView
                    }
                }
                Spacer()
            }
        }
        
    }
    
    // MARK: - Private Properties
    
    @StateObject private var goodsViewModel = GoodsViewModel()
    
    private var totalAmountPurchasesView: some View {
        ZStack {
            GradientNavigationView()
                .frame(width: 350, height: 50)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.4), radius: 10)
            Text("\(Constants.totalAmountText) \(goodsViewModel.summ)\(Constants.dollarSymbol)")
                .font(.title2)
                .bold()
                .foregroundColor(Color.white)
        }
    }
    
    private var productsView: some View {
        VStack {
            ForEach(0..<goodsViewModel.furnituresCount) { index in
                makeProductView(index: index)
            }
            .padding(.all, 10)
        }
    }
    
    private var productRectangleView: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 350, height: 110)
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.2), radius: 10)
    }
    
    private var gradientNavigationView: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: 70)
            .background(LinearGradient(
                colors: [.yellow, Color(Constants.gradientColorTwoName)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            )
            .ignoresSafeArea(.all)
    }
    
    private var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: Constants.magnifyingglassSystemImageName)
                TextField(Constants.placeholderTextfieldText, text: $goodsViewModel.searchText, onEditingChanged: { isEditing in
                }, onCommit: {
                })
                .foregroundColor(.primary)
                Button(action: {
                    goodsViewModel.searchText = Constants.emptyString
                }) {
                    Image(systemName: Constants.xmarkCircleSystemImageName).opacity(goodsViewModel.searchText == Constants.emptyString ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 12, leading: 6, bottom: 12, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(25.0)
        }
        .padding(.horizontal, 15)
    }
    
    private var filterButtonView: some View {
        Button {
            goodsViewModel.isFilterButtonPressed.toggle()
        } label: {
            Image(Constants.filterImageName)
                .resizable()
                .frame(width: 30, height: 30)
        }
        .padding(.trailing, 20)
    }
    
    // MARK: - Private Methods
    
    private func makeProductImageView(index: Int) -> some View {
        Image(goodsViewModel.getFurnitureImageName(index: index))
            .resizable()
            .frame(width: 100, height: 100)
            .offset(y: -5)
    }
    
    private func makeProductView(index: Int) -> some View {
        ZStack {
            productRectangleView
            VStack {
                HStack(spacing: 30) {
                    makeProductImageView(index: index)
                    VStack {
                        makeProductNameView(index: index)
                        HStack {
                            deleteProductButtonView(index: index)
                            productCountTextView(index: index)
                            addProductButtonView(index: index)
                        }
                    }
                    VStack {
                        makeProductOldPriceView(index: index)
                        makeProductPriceView(index: index)
                    }
                }
            }
        }
    }
    
    private func makeProductOldPriceView(index: Int) -> some View {
        Text("\(Constants.dollarSymbol)\(goodsViewModel.getOldFurniturePrice(index: index))")
            .font(.largeTitle)
            .foregroundColor(Color(.gray))
            .strikethrough()
    }
    
    private func makeProductPriceView(index: Int) -> some View {
        Text("\(Constants.dollarSymbol)\(goodsViewModel.getFurniturePrice(index: index))")
            .font(.largeTitle)
            .foregroundColor(Color(Constants.darkPurpleColorName))
    }
    
    private func makeProductNameView(index: Int) -> some View {
        Text(goodsViewModel.getFurnitureName(index: index))
            .bold()
    }
    
    private func productCountTextView(index: Int) -> some View {
    ZStack {
        Rectangle()
            .shadow(color: .black.opacity(0.3), radius: 5)
            .frame(width: 40, height: 50)
            .foregroundColor(.white)
        Text(goodsViewModel.getFurnitureCount(index: index))
            .font(.title)
    }
}
    
    private func deleteProductButtonView(index: Int) ->  some View {
        Button {
            goodsViewModel.updateRemoveFurnitureCount(index: index)
        } label: {
            Image(systemName: Constants.minusSystemImageName)
                .tint(.black)
        }
    }
    
    private func addProductButtonView(index: Int) -> some View {
        Button {
            goodsViewModel.updateAddFurnitureCount(index: index)
        } label: {
            Image(systemName: Constants.plusSystemImageName)
                .tint(.black)
        }
    }
}

struct Goods_PreviewProvider: PreviewProvider {
    static var previews: some View {
        GoodsView()
    }
}
