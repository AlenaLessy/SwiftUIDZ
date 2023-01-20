//
//  ContentView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI
import Foundation

/// Плеер
struct ContentView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let playSystemImageName = "play.fill"
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack(spacing: 10) {
            songsName
            Text(playerViewModel.getAlbumName())
                .bold()
                .foregroundColor(.gray)
            albumImage
            HStack(spacing: 250) {
                    Text(verbatim: ( playerViewModel.getPastTime().formatted(.dateTime.minute()
                        .second())))
                    Text(verbatim: ( playerViewModel.getTimeLeft().formatted(.dateTime.minute()
                        .second())))
                }
            musicSlider
            HStack(spacing: 100) {
                backwardButton
                playAndStopButton
                forwardButton
            }
            
            HStack(spacing: 60) {
                downloadSongButton
                shareSongButton
            }.offset(y: 30)
   
        }
    }
    
// MARK: - Private Properties
    
    @ObservedObject private var playerViewModel = PlayerViewModel()
    
    @State private var isShareButton = false
    @State private var isDownloadButton = false
    
    private var imageName = Constants.playSystemImageName

    private var songsName: Text {
        return Text(playerViewModel.getSongName()).font(.system(size: 30))
            .bold()
    }
    
    private var albumImage: some View {
        return Image(playerViewModel.getAlbomImageName())
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
    
    private var backwardButton: Button<Image> {
        return Button {
              self.playerViewModel.backSong()
            playerViewModel.isPlaying = true
        } label: {
            Image(systemName: "backward.fill")
        }
    }
    
    private var playButton: Button<Image> {
        return Button {
            if self.playerViewModel.isPlaying {
                self.playerViewModel.play()
                self.playerViewModel.isPlaying = false
            } else {
                self.playerViewModel.play()
                self.playerViewModel.isPlaying = true
            }
        } label: {
            Image(systemName: self.playerViewModel.isPlaying ? "pause.fill" : "play.fill")
        }
    }
    
    private var stopButton: Button<Image> {
        return Button {
            self.playerViewModel.currentDuration = 0.0
            self.playerViewModel.stop()
            
        } label: {
            Image(systemName: "stop.fill")
        }
    }
    
    private var playAndStopButton: HStack<TupleView<(Button<Image>, Button<Image>)>> {
        return HStack(spacing: 30) {
            playButton
            stopButton
        }
    }
    
    private var forwardButton: Button<Image> {
        return Button {
            
            self.playerViewModel.nextSong()
            playerViewModel.isPlaying = true
        } label: {
            Image(systemName: "forward.fill")
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
            isShareButton = true
        } label: {
            Text("Поделиться")
                .foregroundColor(.white)
        }
        .frame(width: 100, height: 30)
        .cornerRadius(7)
        .background(.blue)
        
        .alert(isPresented: $isShareButton) {

            Alert(title: Text("Поделиться"),
                  primaryButton: .default(Text("Да")),
                  secondaryButton: .default(Text("Нет")))
        }
    }
    
    private var downloadSongButton: some View {
        Button {
            isDownloadButton = true
        } label: {
            Text("Скачать")
                .foregroundColor(.white)
        }
        .frame(width: 100, height: 30)
        .cornerRadius(7)
        .background(.blue)
      
        .actionSheet(isPresented: $isDownloadButton) {
            ActionSheet(title: Text("\(playerViewModel.getSongName()) сохранен в папку загрузки"))
        }
    }
}


/// Плеер
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
