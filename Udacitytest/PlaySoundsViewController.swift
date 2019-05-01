//
//  playsoundViewController.swift
//  Udacitytest
//
//  Created by sundus on 09/07/1440 AH.
//  Copyright © 1440 sundus. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    @IBOutlet weak var lowpitch: UIButton!
    @IBOutlet weak var stopbutton: UIButton!
    @IBOutlet weak var revbutton: UIButton!
    @IBOutlet weak var echo: UIButton!
    @IBOutlet weak var highpitch: UIButton!
    @IBOutlet weak var fastbutton: UIButton!
    @IBOutlet weak var lowbutton: UIButton!
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        print("Play Sound Button Pressed")
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
        print("Stop Audio Button Pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lowpitch.imageView?.contentMode = .scaleAspectFit
        revbutton.imageView?.contentMode = .scaleAspectFit
        echo.imageView?.contentMode = .scaleAspectFit
        highpitch.imageView?.contentMode = .scaleAspectFit
        fastbutton.imageView?.contentMode = .scaleAspectFit
        lowbutton.imageView?.contentMode = .scaleAspectFit
        setupAudio()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    
  
    

    

}
