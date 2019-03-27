//
//  ViewController.swift
//  Back to Bach
//
//  Created by Sasha Dubikovskaya on 04.02.2019.
//  Copyright © 2019 Back to Bach. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    let audioPath = Bundle.main.path(forResource: "sheep", ofType: "mp3")
    
    var timer = Timer()
    
    @objc func updateScrubber() {
        
        secondSlider.value = Float(player.currentTime)
        
    }
    
    @IBAction func play(_ sender: Any) {
        
        player.play()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func pause(_ sender: Any) {
        
        player.pause()
        
        timer.invalidate()
        
    }
    
    @IBAction func stop(_ sender: Any) {
        
        secondSlider.value = 0
        
        timer.invalidate()
        
        player.pause()
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
        } catch {
            
            // Process any errors
            
        }
        
    }
    
    @IBAction func sliderVolume(_ sender: Any) {
        
        player.volume = firstSlider.value
        
    }
    
    @IBOutlet weak var firstSlider: UISlider!
    
    @IBAction func sliderScrub(_ sender: Any) {
        
        player.currentTime = TimeInterval(secondSlider.value)
        
    }
    
    @IBOutlet weak var secondSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
            secondSlider.maximumValue = Float(player.duration)
            
        } catch {
            
            // Process any errors
            
        }
        
    }


}

