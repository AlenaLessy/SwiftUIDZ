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
        static let zeroFloatNumber: Float = 0.0
        static let emptyString = ""
        static let formatSongText = "mp3"
        static let zeroDoubleNumber: Double = 0
        static let zeroIntNumber = 0
        static let oneIntNumber = 1
        static let oneDoubleNumber: Double = 1

    }
        
    // MARK: - Public Properties
    
    @Published public var maxDuration = Constants.zeroFloatNumber
    @Published public var currentDuration = Constants.zeroFloatNumber
    @Published public var isPlaying = false
    
    
    // MARK: - Private Properties
    private var player: AVAudioPlayer?
    private var songs: [Song] = [
        Song(name: "lada", albumName: "album", albumImageName: "1", type: "mp3"),
        Song(name: "anna", albumName: "album", albumImageName: "2", type: "mp3"),
        Song(name: "11", albumName: "album", albumImageName: "3", type: "mp3"),
        Song(name: "wrong", albumName: "album",  albumImageName: "7", type: "mp3"),
    ]
    private var numberCurrentSong = Constants.zeroIntNumber

    
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
        numberCurrentSong += Constants.oneIntNumber
        setupSong(number: numberCurrentSong)
        player?.play()
    }
    
    public func backSong() {
        numberCurrentSong -= Constants.oneIntNumber
        setupSong(number: numberCurrentSong)
        player?.play()
    }
    
    public func getSongName() -> String {
        guard numberCurrentSong < songs.count else { return Constants.emptyString }
        return songs[numberCurrentSong].name
    }
    
    public func getAlbomImageName() -> String {
        guard numberCurrentSong < songs.count else { return Constants.emptyString }
        return songs[numberCurrentSong].albumImageName
    }
    
    public func getAlbumName() -> String {
        guard numberCurrentSong < songs.count else { return Constants.emptyString }
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
            numberCurrentSong = Constants.zeroIntNumber
        } else if number < Constants.zeroIntNumber {
            numberCurrentSong = songs.count - Constants.oneIntNumber
        }
                
        guard let audioPath = Bundle.main.path(forResource: songs[numberCurrentSong].name, ofType: Constants.formatSongText) else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = Float(player?.duration ?? Constants.zeroDoubleNumber)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: Constants.oneDoubleNumber, repeats: true) { [weak self] timer in
            guard let self else { return }
            self.currentDuration = Float(self.player?.currentTime ?? Constants.zeroDoubleNumber)
            if Int(self.currentDuration) >= Int(self.maxDuration) {
                self.nextSong()
                timer.invalidate()
            }
        }
    }
}
