//  ContentView.swift
//  SwiftUIDZ
//  Created by Алена Панченко on 17.01.2023.

import SwiftUI

///  Экран Шоурума
struct ContentView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let salonTypes = ["Кожа-рожа", "Тряпично-практично", "Странный деревянный"]
        static let showroomNameText = "Тачилы"
        static let emptyString = ""
        static let buyText = "Купить"
        static let buyButtonAlertTitleText = "Поздравляем!"
        static let buiButtonAlertMessageText = "Вы купили ведро"
        static let salonPickerText = "Салон"
        static let carPickerText = "Car"
        static let steeringWheelText = "Наличие руля"
        static let priceText = "Стоимость:"
        static let currencyText = "бублей"
        static let enginePowerText = "Мощность двигателя:"
        static let numberEnginePowerText = "хомяка"
        static let toningText = "Тонировка:"
        static let underestimateText = "Занизить"
        static let shareButtonTitleText = "Похвастаться"
        static let infoActivityViewText = "Купил ведро -"
        static let buiButtonAlertDefaultText = "Ок"
        static let underestimateNumber: CGFloat = 70
        static let underestimateRange: ClosedRange<CGFloat> = 0...100
        static let spacingVStack: CGFloat = 15
        static let showroomNameTextOffset: CGFloat = 10
        static let spacingButton: CGFloat = 50
        static let showroomNameTextFontSize: CGFloat = 30
        static let buiButtonFontSize: CGFloat = 15
        static let buiButtonWidthNumber: CGFloat = 90
        static let buiButtonHeightNumber: CGFloat = 25
        static let buiButtonCornerRadiusNumber: CGFloat = 10
        static let carImageWidthNumber: CGFloat = 350
        static let carImageHeightNumber: CGFloat = 300
        static let carImageCornerRadiusNumber: CGFloat = 50
        static let zeroNumber = 0
        static let shareButtonTitleFontNumber: CGFloat = 15
        static let shareButtonWidthNumber: CGFloat = 130
        static let shareButtonHeightNumber: CGFloat = 25
        static let shareButtonCornerRadiusNumber: CGFloat = 10
    }
    
    // MARK: - Public Properties

    var body: some View {
        NavigationView {
            VStack(spacing: Constants.spacingVStack) {
                showroomNameText.offset(y: Constants.showroomNameTextOffset)
                carImageView
                carPickerView
                Form {
                    priceTextView
                    enginePowerTextView
                    toningTextView
                    steeringWheelTextView
                    salonPickerView
                    HStack {
                        underestimateTextView
                        underestimateSlierView
                    }
                }
                HStack(spacing: Constants.spacingButton) {
                    buyButtonView
                    shareButtonView
                }
            }
        }
    }
    
    // MARK: Private Properties
    
    private let cars: [Car] = Car.getCars()
    
    @State private var selectionCarPicker = Constants.zeroNumber
    @State private var selectionSalonPicker = Constants.zeroNumber
    @State private var isSharePressed = false
    @State private var isBuyPressed = false
    @State private var isSteeringWheel = false
    @State private var underestimate = Constants.underestimateNumber

    private var salonTypes = Constants.salonTypes
    
    private var showroomNameText: some View {
        Text(Constants.showroomNameText)
            .bold()
            .font(.system(size: Constants.showroomNameTextFontSize))
            .foregroundColor(.red)
    }
        
    private var buyButtonView: some View {
        return Button {
            isBuyPressed = true
        } label: {
            Text(Constants.buyText).font(.system(size: Constants.buiButtonFontSize))
                .padding()
        }
        .alert(isPresented: $isBuyPressed) {
            Alert(title: Text(Constants.buyButtonAlertTitleText), message: Text(Constants.buiButtonAlertMessageText), primaryButton: .cancel(), secondaryButton: .default(Text(Constants.buiButtonAlertDefaultText)))
        }
        .frame(width: Constants.buiButtonWidthNumber, height: Constants.buiButtonHeightNumber)
            .foregroundColor(.black)
            .background(Color.red)
            .cornerRadius(Constants.buiButtonCornerRadiusNumber)
    }
    
    private var carImageView: some View {
        Image(cars[selectionCarPicker].imageName)
            .resizable()
            .frame(width: Constants.carImageWidthNumber,
                   height: Constants.carImageHeightNumber)
            .cornerRadius(Constants.carImageCornerRadiusNumber)
            
    }
    
    private var salonPickerView: some View {
        Picker(Constants.salonPickerText, selection: $selectionSalonPicker) {
            ForEach(Constants.zeroNumber ..< salonTypes.count) {
                                 Text(salonTypes[$0])
                             }
                         }
                         .pickerStyle(.navigationLink)
                     }
            
    private var carPickerView: some View {
        Picker(Constants.carPickerText, selection: $selectionCarPicker) {
            ForEach(Constants.zeroNumber ..< cars.count) {
                Text(cars[$0].name)
            }
        }
        .pickerStyle(.segmented)
        .colorMultiply(.red)
        .padding()
    }
    
    private var steeringWheelTextView: some View {
        Toggle(Constants.steeringWheelText, isOn: $isSteeringWheel).colorMultiply(.red)
    }
        
    private var priceTextView: some View {
        Text("\(Constants.priceText) \(cars[selectionCarPicker].price) \(Constants.currencyText)")
    }
    
    private var enginePowerTextView: some View {
        Text("\(Constants.enginePowerText) \(cars[selectionCarPicker].enginePower) \(Constants.numberEnginePowerText)")
    }
    
    private var toningTextView: some View {
        Text("\(Constants.toningText) \(cars[selectionCarPicker].toning)")
    }
    
    private var underestimateTextView: some View {
        Text(Constants.underestimateText)
    }
    
    private var underestimateSlierView: some View {
        Slider(value: $underestimate, in: Constants.underestimateRange)
    }

    private var shareButtonView: some View {
        Button {
            isSharePressed = true
        } label: {
            Text(Constants.shareButtonTitleText).font(.system(size: Constants.shareButtonTitleFontNumber))
                .padding().frame(width: Constants.shareButtonWidthNumber, height: Constants.shareButtonHeightNumber)
                .foregroundColor(.black)
                .background(Color.red)
                .cornerRadius(Constants.shareButtonCornerRadiusNumber)
        }.sheet(isPresented: $isSharePressed) {
            let info = "\(Constants.infoActivityViewText) \(cars[selectionCarPicker].name)"
            ActivityViewController(items: [info])
        }
    }
}

/// Шоурум
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
