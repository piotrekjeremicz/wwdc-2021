//
//  Speaker.swift
//  wwdc2021
//
//  Created by Piotrek on 18/04/2021.
//

import AVFoundation

public class Speaker {
    public let synthesizer = AVSpeechSynthesizer()
    
    private var lastSentence: String = ""
    
    public init() { }
    
    public func say(_ string: String) {
        guard lastSentence != string else { return }
        lastSentence = string
        
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        
        synthesizer.speak(utterance)
    }
}
