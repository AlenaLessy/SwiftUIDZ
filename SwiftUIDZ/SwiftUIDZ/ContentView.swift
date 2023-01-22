//  ContentView.swift
//  SwiftUIDZ
//  Created by Алена Панченко on 17.01.2023.

import SwiftUI

/// Плеер
struct ContentView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let playSystemImageName = "play.fill"
        static let backwardSystemImageName = "backward.fill"
        static let pauseSystemImageName =  "pause.fill"
        static let stopSystemImageName = "stop.fill"
        static let forwardSystemImageName = "forward.fill"
        static let shareSongButtonTitleText = "Поделиться"
        static let shareSongButtonAlertTitleText = "Поделиться?"
        static let shareSongAlertButtonYesText = "Да"
        static let shareSongAlertButtonNoText = "Нет"
        static let downloadSongButtonTitleText = "Скачать"
        static let actionSheetTitleText = "сохранен в папку загрузки"
        static let VStackSpacingNumber: CGFloat = 10
        static let HStackPlayTimeSpacingNumber: CGFloat = 250
        static let HStackPlayButtonsSpacingNumber: CGFloat = 100
        static let downloadSongAndShareSongButtonSpacingNumber: CGFloat = 60
        static let downloadSongAndShareSongButtonOffsetNumber: CGFloat = 30
        static let songsNameFontSize: CGFloat = 30
        static let aspectRationNumber: CGSize = CGSize(width: 1, height: 1)
        static let zeroFloatNumber: Float = 0.0
        static let playAndStopButtonSpacing: CGFloat = 30
        static let buttonWidthNumber: CGFloat = 100
        static let buttonHeightNumber: CGFloat = 30
        static let buttonCornerRadiusNumber: CGFloat = 7
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack(spacing: Constants.VStackSpacingNumber) {
            songsName
            albumNameText
            albumImage
            HStack(spacing: Constants.HStackPlayTimeSpacingNumber) {
                pastTimeText
                timeLeftText
                }
            musicSlider
            HStack(spacing: Constants.HStackPlayButtonsSpacingNumber) {
                backwardButton
                playAndStopButton
                forwardButton
            }
            
            HStack(spacing: Constants.downloadSongAndShareSongButtonSpacingNumber) {
                downloadSongButton
                shareSongButton
            }.offset(y: Constants.downloadSongAndShareSongButtonOffsetNumber)
   
        }
    }
    
// MARK: - Private Properties
    
    @StateObject private var playerViewModel = PlayerViewModel()
    
    @State private var isShareButtonPressed = false
    @State private var isDownloadButtonPressed = false
    
    private var imageName = Constants.playSystemImageName

    private var songsName: Text {
        Text(playerViewModel.getSongName()).font(.system(size: Constants.songsNameFontSize))
            .bold()
    }
    
    private var albumImage: some View {
        Image(playerViewModel.getAlbomImageName())
            .resizable()
            .aspectRatio(Constants.aspectRationNumber, contentMode: .fit)
            .padding()
    }
    
    private var albumNameText: Text {
        Text(playerViewModel.getAlbumName())
            .bold()
            .foregroundColor(.gray)
    }
    
    private var backwardButton: Button<Image> {
        return Button {
              self.playerViewModel.backSong()
            playerViewModel.isPlaying = true
        } label: {
            Image(systemName: Constants.backwardSystemImageName)
        }
    }
    
    private var playButton: Button<Image> {
         Button {
            if self.playerViewModel.isPlaying {
                self.playerViewModel.play()
                self.playerViewModel.isPlaying = false
            } else {
                self.playerViewModel.play()
                self.playerViewModel.isPlaying = true
            }
        } label: {
            Image(systemName: self.playerViewModel.isPlaying ? Constants.pauseSystemImageName : Constants.playSystemImageName)
        }
    }
    
    private var pastTimeText: Text {
         Text(verbatim: ( playerViewModel.getPastTime().formatted(.dateTime.minute()
            .second())))
    }
    
    private var timeLeftText: Text {
         Text(verbatim: ( playerViewModel.getTimeLeft().formatted(.dateTime.minute()
            .second())))
    }
    
    private var stopButton: Button<Image> {
         Button {
            self.playerViewModel.currentDuration = Constants.zeroFloatNumber
            self.playerViewModel.stop()
        } label: {
            Image(systemName: Constants.stopSystemImageName)
        }
    }
    
    private var playAndStopButton: HStack<TupleView<(Button<Image>, Button<Image>)>> {
         HStack(spacing: Constants.playAndStopButtonSpacing) {
            playButton
            stopButton
        }
    }
    
    private var forwardButton: Button<Image> {
         Button {
            self.playerViewModel.nextSong()
            playerViewModel.isPlaying = true
        } label: {
            Image(systemName: Constants.forwardSystemImageName)
        }
    }

    private var musicSlider: some View {
        Slider(value: Binding(get: {
            playerViewModel.currentDuration
        }, set: { newValue in
            playerViewModel.currentDuration = newValue
            playerViewModel.setTime(value: playerViewModel.currentDuration)
        }), in: Float.zero ... Float(playerViewModel.maxDuration))
        .padding()
    }
    
    private var shareSongButton: some View {
        Button {
            isShareButtonPressed = true
        } label: {
            Text(Constants.shareSongButtonTitleText)
                .foregroundColor(.white)
        }
        .frame(width: Constants.buttonWidthNumber, height: Constants.buttonHeightNumber)
        .cornerRadius(Constants.buttonCornerRadiusNumber)
        .background(.blue)
        .alert(isPresented: $isShareButtonPressed) {
            Alert(title: Text(Constants.shareSongButtonAlertTitleText),
                  primaryButton: .default(Text(Constants.shareSongAlertButtonYesText)),
                  secondaryButton: .default(Text(Constants.shareSongAlertButtonNoText)))
        }
    }
    
    private var downloadSongButton: some View {
        Button {
            isDownloadButtonPressed = true
        } label: {
            Text(Constants.downloadSongButtonTitleText)
                .foregroundColor(.white)
        }
        .frame(width: Constants.buttonWidthNumber, height: Constants.buttonHeightNumber)
        .cornerRadius(Constants.buttonCornerRadiusNumber)
        .background(.blue)
        .actionSheet(isPresented: $isDownloadButtonPressed) {
            ActionSheet(title: Text("\(playerViewModel.getSongName()) \(Constants.actionSheetTitleText)"))
        }
    }
}


/// Плеер
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
