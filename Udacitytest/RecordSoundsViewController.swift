//
//  ViewController.swift
//  Udacitytest
//
//  Created by sundus on 09/07/1440 AH.
//  Copyright © 1440 sundus. All rights reserved.
//

import UIKit
//framework AVaudiorecord
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var stopbutton: UIButton!
    
    @IBOutlet weak var recordbutton: UIButton!
    var audioRecord: AVAudioRecorder!

    @IBOutlet weak var recordlabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // use to stop audio record
        stopbutton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
    }
    
    
    func configureUI(isRecording: Bool){
        recordbutton.isEnabled = !isRecording
        stopbutton.isEnabled = isRecording
        recordlabel.text = isRecording ? "stop recording" : "Start recording"
        
    }
    
   
    
    @IBAction func recordaudio(_ sender: Any) {
        configureUI(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //print(filePath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecord = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecord.delegate = self
        audioRecord.isMeteringEnabled = true
        audioRecord.prepareToRecord()
        audioRecord.record()
    }

    @IBAction func stoprecord(_ sender: Any) {
        configureUI(isRecording: false)
        audioRecord.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            
            //withIdentifier segue identifier
            performSegue(withIdentifier: "stopRecord", sender: audioRecord.url)
        } else {
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecord" {
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
            
        
        }
    }
    
    
    
   
    
   
       
    }
    


