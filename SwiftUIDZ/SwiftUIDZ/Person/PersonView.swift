//
//  PersonView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import SwiftUI

/// Экран  "Пользователь"
struct PersonView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let mapImageName = "map"
        static let messagesText = "Messages"
        static let notificationText = "Notification"
        static let accountDetailsText = "Account Details"
        static let myPurchasesText = "My purchases"
        static let settingsText = "Settings"
        static let settingsImageName = "44"
        static let messageImageName = "message"
        static let notificationImageName = "notification"
        static let cartImageName = "cart"
        static let personImageName = "33"
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                personInfo
              infoListView
            }
            .showTabBar()
              .padding(.top, 30)
        }
    }
    
    // MARK: - Private Properties
    
    @StateObject private var personViewModel = PersonViewModel()
    
    
    private var infoListView: some View {
        List {
            NavigationLink {
                NotificationsView()
            } label: {
                makeMenuView(imageName: Constants.messageImageName, name: Constants.messagesText, newEvent: true, eventCount: personViewModel.getMessageCount())
            }
            NavigationLink {
             
            } label: {
                makeMenuView(imageName: Constants.notificationImageName, name: Constants.notificationText, newEvent: true, eventCount: personViewModel.getNotificationCount())
            }
            NavigationLink {
                
            } label: {
                makeMenuView(imageName: Constants.personImageName, name: Constants.accountDetailsText, newEvent: false)
            }
            NavigationLink {
                
            } label: {
                makeMenuView(imageName: Constants.cartImageName, name: Constants.myPurchasesText, newEvent: false)
            }
            NavigationLink {
                
            } label: {
                makeMenuView(imageName: Constants.settingsImageName, name: Constants.settingsText, newEvent: false)
            }
        }
        .padding(.horizontal, 30)
        .listStyle(.plain)
    }
    
    private var personImageView: some View {
        Image(personViewModel.getPersonImageName())
            .resizable()
            .frame(width: 200, height: 200)
    }
    
    private var personNameTextView: some View {
        Text(personViewModel.getPersonName())
            .font(.largeTitle)
            .bold()
    }
    
    private var cityView: some View {
        HStack {
            Image(Constants.mapImageName)
                .resizable()
                .frame(width: 20, height: 20)
            Text(personViewModel.getPersonCityName())
                .font(.system(size: 27))
        }
    }
    
    private var personInfo: some View {
        VStack(spacing: 0) {
            personImageView
            personNameTextView
            cityView
        }
    }
    
    // MARK: - Private Methods
    
    private func makeListTextView(text: String) -> some View {
        Text(text)
            .font(.system(size: 22))
    }
    
    private func makeImageListView(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .frame(width: 40, height: 40)
    }
    
    private func makeNewEventView(count: Int) -> some View {
        ZStack {
            Circle()
                .fill(
                    Gradient(colors: [.orange, .yellow]))
                .frame(width: 30, height: 30)
            Text("\(count)")
                .bold()
                .font(.title3)
                .foregroundColor(.white)
        }
    }
    
    private func makeMenuView(imageName: String, name: String, newEvent: Bool, eventCount: Int = 0) -> some View {
        HStack {
            HStack {
                makeImageListView(imageName: imageName)
                makeListTextView(text: name)
                Spacer()
            }
            if newEvent {
                makeNewEventView(count: eventCount)
            }
        }
    }
}

struct PersonView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
