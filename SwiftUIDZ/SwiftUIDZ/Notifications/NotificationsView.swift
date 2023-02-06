//
//  Notifications.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import SwiftUI

/// Экран  настройки уведомлений
struct NotificationsView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let alertText = "Settings apply"
        static let updateButtonTitleText = "Update Settings"
        static let chevronLeftSystemImageName = "chevron.left"
        static let toolBarItemText = "Notifications"
        static let gradientColorTwoName = "gr"
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack {
            gradientNavigationView
            VStack {
                ScrollView {
                    notificationsView
                }
                .padding(.top, 20)
                updateSettingsButtonView
                    .offset(y: -100)
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
    }
    
    // MARK: - Private Properties
    
    @Environment(\.presentationMode) var presentation
    
    @StateObject private var notificationsViewModel = NotificationsViewModel()
    
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
    
    private var toolbarNotificationTitleTextView: Text {
        Text(Constants.toolBarItemText)
            .font(.title)
            .foregroundColor(.white)
            .bold()
    }
    
    private var headerView: some View {
        Rectangle()
            .background(Gradient(colors: [.orange, .orange]))
            .frame(width: UIScreen.main.bounds.width, height: 100)
            .ignoresSafeArea(edges: .top)
    }
    
    private var updateSettingsButtonView: some View {
        RedGradientButtonView(actionHandler: {
            notificationsViewModel.isUpdateSettingsButtonPressed.toggle()
        }, label: Constants.updateButtonTitleText, offset: 0)
        .alert(Constants.alertText, isPresented: $notificationsViewModel.isUpdateSettingsButtonPressed, actions: {
        })
    }
    
    private var notificationsView: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 330)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.3), radius: 10)
                VStack {
                    ForEach(0..<notificationsViewModel.notificationsCount) { index in
                        notificationView(index: index)
                    }
                }
                .padding(.horizontal, 35)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func notificationView(index: Int) -> some View {
        VStack(alignment: .leading) {
            HStack {
                notificationNameView(index: index)
                notificationToggleView(index: index)
            }
            notificationDescriptionView(index: index)
            Divider()
        }
    }
    
    private func notificationDescriptionView(index: Int) -> some View {
        Text(notificationsViewModel.getNotificationDescription(index: index))
            .bold()
    }
    
    private func notificationToggleView(index: Int) -> some View {
        Toggle(Constants.emptyString, isOn: Binding {
            notificationsViewModel.getNotificationState(index: index)
        } set: { newValue in
            notificationsViewModel.updateNotificationState(index: index, value: newValue)
        })
        .tint(.orange)
    }
    
    private func notificationNameView(index: Int) -> some View {
        Text(notificationsViewModel.getNotificationName(index: index))
            .bold()
            .font(.title3)
    }
}

struct Notifications_PreviewProvider: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
