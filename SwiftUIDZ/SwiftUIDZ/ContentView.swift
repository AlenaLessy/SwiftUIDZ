//
//  ContentView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

/// Шоурум
struct ContentView: View {
    // MARK: - Private Constants
    private enum Constants {
        static let salonTypes = ["Кожа-рожа", "Тряпично-практично", "Странный деревянный"]
        static let showroomNameText = "Тачилы"
        static let emptyString = ""
        static let underestimateNumber: CGFloat = 70

        static let underestimateRange: ClosedRange<CGFloat> = 0...100
    }
    // MARK: - Public Properties

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                showroomNameText.offset(y: 10)
                carImage
                carPicker
                Form {
                    priceText
                    enginePowerText
                    toningText
                    steeringWheelText
                    salonPicker
                    HStack {
                        underestimateText
                        underestimateSlier
                    }
                }
                HStack(spacing: 50) {
                    buiButton
                    shareButton
                }
            }
        }
    }
    
    // MARK: Private Properties
    
    private let cars = [
        Car(name: "Пятера",
            imageName: "11",
            toning: "Аквариум",
            enginePower: 74,
            price: 25000),
        
        Car(name: "Не пешком",
            imageName: "22",
            toning: "Гаишники попутают",
            enginePower: 82,
            price: 30000),
        Car(name: "Дедушкина",
            imageName: "33",
            toning: "Аквариум",
            enginePower: 123,
            price: 15000),
        Car(name: "Феррари",
            imageName: "44",
            toning: "Аквариум",
            enginePower: 162,
            price: 100000)
    ]
    
  //  private let showroom = Showroom()
    @State private var selectionCarPicker = 0
    @State private var selectionSalonPicker = 0
    @State private var isShare = false
    @State private var isBui = false
    @State private var isSteeringWheel = false
    @State private var underestimate = Constants.underestimateNumber

   
    
    private var salonTypes = Constants.salonTypes
    
    private var showroomNameText: some View {
        Text(Constants.showroomNameText)
            .bold()
            .font(.system(size: 30))
            .foregroundColor(.red)
    }
        
    private var buiButton: some View {
        return Button {
            isBui = true
        } label: {
            Text("Купить").font(.system(size: 15))
                .padding()
        }.alert(isPresented: $isBui) {
            Alert(title: Text("Поздравляем!"), message: Text("Вы купили ведро"), primaryButton: .cancel(), secondaryButton: .default(Text("Ок")))
        }.frame(width: 90, height: 25)
            .foregroundColor(.black)
            .background(Color.red)
            .cornerRadius(10)
    }
    
    private var carImage: some View {
        Image(cars[selectionCarPicker].imageName)
            .resizable()
            .frame(width: 350,
                   height: 300)
            .cornerRadius(50)
            
    }
    
    private var salonPicker: some View {
            Picker("Салон", selection: $selectionSalonPicker) {
                             ForEach(0 ..< salonTypes.count) {
                                 Text(salonTypes[$0])
                             }
                         }
                         .pickerStyle(.navigationLink)
                     }
            
    private var carPicker: some View {
        Picker("Car", selection: $selectionCarPicker) {
            ForEach(0 ..< cars.count) {
                Text(cars[$0].name)
            }
        }
        .pickerStyle(.segmented)
        .colorMultiply(.red)
        .padding()
    }
    
    private var
    steeringWheelText: some View {
        Toggle("Наличие руля", isOn: $isSteeringWheel).colorMultiply(.red)
    }
        
    private var priceText: some View {
        Text("Стоимость: \(cars[selectionCarPicker].price) бублей")
    }
    
    private var enginePowerText: some View {
        Text("Мощность двигателя: \(cars[selectionCarPicker].enginePower) хомяка")
    }
    
    private var toningText: some View {
        Text("Тонировка: \(cars[selectionCarPicker].toning)")
    }
    
    private var underestimateText: some View {
        Text("Занизить")
    }
    
    private var underestimateSlier: some View {
        Slider(value: $underestimate, in: Constants.underestimateRange)
    }

    private var shareButton: some View {
        Button {
            isShare = true
        } label: {
            Text("Похвастаться").font(.system(size: 15))
                .padding().frame(width: 130, height: 25)
                .foregroundColor(.black)
                .background(Color.red)
                .cornerRadius(10)
        }.sheet(isPresented: $isShare) {
            let info = "Купил ведро - \(cars[selectionCarPicker].name)"
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
