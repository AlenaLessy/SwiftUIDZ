//
//  ContentView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

/// Экран настроек
struct ContentView: View {
    
    private enum Constants {
        static let navigationTitleText = "Настройки"
        static let bearImageName = "7"
        static let airplaneModeImageName = "1"
        static let wifiModeImageName = "2"
        static let bluetoothImageName = "3"
        static let CellularCommunicationImageName = "4"
        static let modemImageName = "5"
        static let vpnImageName = "6"
        static let chevronForwardSystemImageName = "chevron.forward"
        static let userName = "Beargreez"
        static let profileInfoText = "Apple ID, iCloud, контент и покупки"
        static let offersAppleIdText = "Предложения Apple ID"
        static let offersAppleIdCount = "3"
        static let updateText = "iOS 16.2: уже доступно"
        static let updateCount = "1"
        static let airplaneModeText = "Авиарежим"
        static let wiFiText = "Wi-Fi"
        static let bluetoothText = "Bluetooth"
        static let cellularCommunicationText = "Сотовая связь"
        static let modemText = "Режим модема"
        static let vPNText = "VPN"
    
        static let profileImageSide: CGFloat = 70
        static let profileImageCornerRadius: CGFloat = 35
        static let userNameShadowOffsetX: CGFloat = -40
        static let userNameShadowOffsetY: CGFloat = 15
        static let userFontSizeNumber: CGFloat = 25
        static let userDescriptionFontSizeNumber: CGFloat = 12
        static let userDescriptionShadowOffsetX: CGFloat = 10
        static let minLengthSpacerUserContainer: CGFloat = 5
        static let offersCornerRadius: CGFloat = 13
        static let offersSideNumber: CGFloat = 25
        static let iconCornerRadius: CGFloat = 10
        static let zeroNumber = 0
        
        static let connectionStatuses = ["Подключен", "Не подключен"]
        static let switchedStatuses = ["Вкл.", "Выкл."]
        static let cellularCommunicationStatuses = ["Beeline", "MTS", "Megafhone"]
    }
    
    @State private var isOnAirplaneMode = false
    @State private var isOnVPN = false
    @State private var wiFiSelection = Constants.zeroNumber
    @State private var bluetoothSelection = Constants.zeroNumber
    @State private var cellularCommunicationSelection = Constants.zeroNumber
    @State private var modemSelection = Constants.zeroNumber
    
    private var wifiStatuses = Constants.connectionStatuses
    private var switchedStatuses = Constants.switchedStatuses
    private var cellularCommunicationStatuses = Constants.cellularCommunicationStatuses

    var body: some View {
        NavigationView {
            Form {
                Section {
                    makeProfileContainer()
                    makeOffersAppleIdContainer()
                }
                Section {
                    makeUpdateContainer()
                }
                Section {
                    makeAirplaneModeContainer()
                    makeWiFiContainer()
                    makeBluetoothContainer()
                    makeCellularCommunicationContainer()
                    makeModemContainer()
                    makeVPNContainer()
                }
            }
            .navigationTitle(Constants.navigationTitleText)
        }
    }
    
    private func makeProfileContainer() -> some View {
        HStack {
                Image(Constants.bearImageName)
                    .resizable()
                    .frame(width: Constants.profileImageSide, height: Constants.profileImageSide)
                    .cornerRadius(CGFloat(Constants.profileImageCornerRadius))
            VStack {
                    Text(Constants.userName)
                    .offset(x: Constants.userNameShadowOffsetX, y: Constants.userNameShadowOffsetY)
                        .font(.system(size: Constants.userFontSizeNumber))
                Spacer(minLength: Constants.minLengthSpacerUserContainer)
                    Text(Constants.profileInfoText)
                    .font(.system(size: Constants.userDescriptionFontSizeNumber)).offset(x: Constants.userDescriptionShadowOffsetX)
                    Spacer()
            }
            Spacer()
            Image(systemName: Constants.chevronForwardSystemImageName)
                .foregroundColor(.gray)
        }
    }
    
    fileprivate func makeOffersAppleIdContainer() -> some View {
        HStack {
            Text(Constants.offersAppleIdText)
            Spacer()
            ZStack {
                Circle()
                    .foregroundColor(.red)
                    .frame(width: Constants.offersSideNumber, height: Constants.offersSideNumber)
                Text(Constants.offersAppleIdCount)
                    .foregroundColor(.white)
            }
            Image(systemName: Constants.chevronForwardSystemImageName)
                .foregroundColor(.gray)
        }
    }
    
    fileprivate func makeUpdateContainer() -> some View {
        HStack {
            Text(Constants.updateText)
            Spacer()
            ZStack {
                Circle()
                    .frame(width: Constants.offersSideNumber, height: Constants.offersSideNumber)
                    .foregroundColor(.red)
                Text(Constants.updateCount)
                    .foregroundColor(.white)
            }
            Image(systemName: Constants.chevronForwardSystemImageName)
                .foregroundColor(.gray)
        }
    }
    
    fileprivate func makeAirplaneModeContainer() -> some View {
        HStack {
            Image(Constants.airplaneModeImageName)
                .cornerRadius(Constants.iconCornerRadius)
            Toggle(isOn: $isOnAirplaneMode) {
                Text(Constants.airplaneModeText)
            }
        }
    }
    
    fileprivate func makeWiFiContainer() -> some View {
        HStack {
            Image(Constants.wifiModeImageName)
                .cornerRadius(Constants.iconCornerRadius)
            Picker(Constants.wiFiText, selection: $wiFiSelection) {
                ForEach(0 ..< wifiStatuses.count) {
                    Text(wifiStatuses[$0])
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    
    fileprivate func makeBluetoothContainer() -> some View {
        HStack {
            Image(Constants.bluetoothImageName)
                .cornerRadius(Constants.iconCornerRadius)
            Picker(Constants.bluetoothText, selection: $bluetoothSelection) {
                ForEach(0 ..< switchedStatuses.count) {
                    Text(switchedStatuses[$0])
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    
    fileprivate func makeCellularCommunicationContainer() -> some View {
        HStack {
            Image(Constants.CellularCommunicationImageName)
                .cornerRadius(Constants.iconCornerRadius)
            Picker(Constants.cellularCommunicationText, selection: $cellularCommunicationSelection) {
                ForEach(0 ..< cellularCommunicationStatuses.count) {
                    Text(cellularCommunicationStatuses[$0])
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    
    fileprivate func makeModemContainer() -> some View {
        HStack {
            Image(Constants.modemImageName)
                .cornerRadius(Constants.iconCornerRadius)
            Picker(Constants.modemText, selection: $modemSelection) {
                ForEach(0 ..< switchedStatuses.count) {
                    Text(switchedStatuses[$0])
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    
    fileprivate func makeVPNContainer() -> some View {
        HStack {
            Image(Constants.vpnImageName)
                .cornerRadius(Constants.iconCornerRadius)
            Toggle(isOn: $isOnVPN) {
                Text(Constants.vPNText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

