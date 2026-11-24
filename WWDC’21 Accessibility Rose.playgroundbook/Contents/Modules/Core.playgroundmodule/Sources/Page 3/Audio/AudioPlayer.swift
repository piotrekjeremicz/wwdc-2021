//
//  AudioPlayer.swift
//  wwdc2021
//
//  Created by Piotrek on 14/04/2021.
//

import SwiftUI
import AVFoundation

public class AudioPlayer {
    public enum Sound: String, CaseIterable {
        case beep, blip, pop, tink, triangle
        
        func random() -> Sound { Sound.allCases.randomElement()! }
    }
    
    public enum Click: String {
        case click, tick
    }
    
    public var isPlaying: Bool {
        get { player?.isPlaying ?? false }
    }
    
    public var pan: Float {
        get { player?.pan ?? 0 }
        set { player?.pan = newValue }
    }
    
    public var volume: Float {
        get { player?.volume ?? 1}
        set { player?.volume = newValue}
    }
    
    private var player: AVAudioPlayer? = nil
    
    public func play() {
        if let player = player, player.isPlaying {
            player.stop()
        }
        player?.play()
    }
    
    public func stop() {
        player?.currentTime = .zero
    }
    
    public func load(sound: Sound, andPlay: Bool = true, completed: @escaping () -> () = {}) {
        load(file: sound.rawValue, andPlay: andPlay, completed: completed)
    }
    
    public func load(click: Click, andPlay: Bool = true, completed: @escaping () -> () = {}) {
        load(file: click.rawValue, andPlay: andPlay, completed: completed)
    }
    
    func load(file: String, ext: String = "wav", andPlay: Bool = true, completed: @escaping () -> () = {}) {
        let path = Bundle.main.path(forResource: file + "." + ext, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = andPlay ? -1 : 0
            
            if andPlay { player?.play() }
            
            completed()
        } catch {
            print(error)
        }
    }
}
