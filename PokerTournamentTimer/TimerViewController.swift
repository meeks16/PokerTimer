//
//  TimerViewController.swift
//  PokerTournamentTimer
//
//  Created by meeks on 12/5/15.
//  Copyright © 2015 meeks. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController{
    
    var timerBell: AVAudioPlayer!
    
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var smallBlind: UILabel!
    @IBOutlet weak var bigBlind: UILabel!

    @IBOutlet weak var timeStepper: UIStepper!
    @IBOutlet weak var blindStepper: UIStepper!
    
    
    var time = 00
    var bBlind = 00
    
    var timer = NSTimer()
    var timerRunning = false
    var secondsCount:Int = 00
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        secondsCount = time * 60
        setComponents()

        print(timeStepper.value)
        
    }
    
    func setComponents(){
        timeStepper.value = Double(secondsCount)
        blindStepper.value = Double(bBlind)
        let minutes = secondsCount / 60
        let seconds = secondsCount - (minutes * 60)
        let timerOutput = String(format:"%02d:%02d", minutes, seconds)
        let sBlind = bBlind / 2
        
        timeRemaining.text = timerOutput
        bigBlind.text = String(bBlind)
        smallBlind.text = String(sBlind)
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        return audioPlayer!
    }
    

    @IBAction func adjustTimer(sender: AnyObject) {
        
        secondsCount = Int(timeStepper.value)
        setComponents()
        print(secondsCount)
    }
    
    @IBAction func adjustBlinds(sender: AnyObject) {
        bBlind = Int(blindStepper.value)
        setComponents()
        print(bBlind)
    }
    
    func runTimer(){
        secondsCount = secondsCount - 1
        setComponents()
        
        if secondsCount == 0 {
            secondsCount = time * 60
            bBlind = bBlind * 2
            timerBell = setupAudioPlayerWithFile("Bell", type: "mp3")
            timerBell.play()
        }
    }
    
    @IBAction func startButton(sender: AnyObject) {
        if timerRunning == false {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("runTimer"), userInfo: nil, repeats: true)
            timerRunning = true
        }
    }
    
    @IBAction func pauseButton(sender: AnyObject) {
        if timerRunning == true {
            timer.invalidate()
            timerRunning = false
        }
    }
    
    @IBAction func resetButton(sender: AnyObject) {
        secondsCount = time * 60
        timeRemaining.text = String(format:"%02d:%02d", time, 00)
    }

}
