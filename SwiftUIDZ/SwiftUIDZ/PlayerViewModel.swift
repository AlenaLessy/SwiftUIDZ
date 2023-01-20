//
//  PlayerViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 20.01.2023.
//

import AVFoundation
import SwiftUI
import Foundation

/// Вью-модель для плеера
final class PlayerViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let songNames = ["lada", "anna", "11", "wrong"]
        static let secText = "s"
        static let minText = "m"
        static let pointText = " : "
        static let emptyText = ""
        static let formatSongText = "mp3"
        static let zeroNumberFloat: Float = 0.0
        static let zeroNumberDouble: Double = 0.0
        static let zeroNumberInt = 0
        static let intervalTimerNumber = 0.2
        static let hourNumber = 3600
        static let minNumber = 60
    }
        
    // MARK: - Public Properties
    
    @Published public var maxDuration: Float = Constants.zeroNumberFloat
    @Published public var currentDuration: Float = Constants.zeroNumberFloat
    @Published public var isPlaying = false
    
    
    // MARK: - Private Properties
    private var player: AVAudioPlayer?
    private var songs: [Song] = [
        Song(name: "lada", albumName: "album", albumImageName: "1", type: "mp3"),
        Song(name: "anna", albumName: "album", albumImageName: "2", type: "mp3"),
        Song(name: "11", albumName: "album", albumImageName: "3", type: "mp3"),
        Song(name: "wrong", albumName: "album",  albumImageName: "7", type: "mp3"),
    ]
    private var numberCurrentSong = Constants.zeroNumberInt

    
    // MARK: - Public Methods
    
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
        player?.play()
        setupTimer()
    }
    
    public func play() {
        if isPlaying {
            player?.stop()
        } else {
            setupSong(number: numberCurrentSong)
            setTime(value: currentDuration)
        }
    }
    
    public func stop() {
        isPlaying = false
        setTime(value: currentDuration)
        player?.stop()
    }
    
    
    public func nextSong() {
        numberCurrentSong += 1
        setupSong(number: numberCurrentSong)
        player?.play()
    }
    
    public func backSong() {
        numberCurrentSong -= 1
        setupSong(number: numberCurrentSong)
        player?.play()
    }
    
    public func getSongName() -> String {
        guard numberCurrentSong < songs.count else { return Constants.emptyText }
        return songs[numberCurrentSong].name
    }
    
    public func getAlbomImageName() -> String {
        guard numberCurrentSong < songs.count else { return Constants.emptyText }
        return songs[numberCurrentSong].albumImageName
    }
    
    public func getAlbumName() -> String {
        guard numberCurrentSong < songs.count else { return Constants.emptyText }
        return songs[numberCurrentSong].albumName
    }
        
    public func getPastTime() -> Date {
        let progressong = Date(timeIntervalSince1970: Double(currentDuration))
       return progressong
    }
    
    public func getTimeLeft() -> Date {
        let progressong = Date(timeIntervalSince1970: Double(maxDuration - currentDuration))
       return progressong
    }
    
    // MARK: - Private Methods
    
    private func setupSong(number: Int) {
        if number >= songs.count {
            numberCurrentSong = 0
        } else if number < 0 {
            numberCurrentSong = songs.count - 1
        }
                
        guard let audioPath = Bundle.main.path(forResource: songs[numberCurrentSong].name, ofType: Constants.formatSongText) else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = Float(player?.duration ?? Constants.zeroNumberDouble)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else { return }
            self.currentDuration = Float(self.player?.currentTime ?? 0)
            if Int(self.currentDuration) >= Int(self.maxDuration) {
                self.nextSong()
                timer.invalidate()
            }
        }
    }
}
