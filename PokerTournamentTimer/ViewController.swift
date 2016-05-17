//
//  ViewController.swift
//  PokerTournamentTimer
//
//  Created by meeks on 12/5/15.
//  Copyright © 2015 meeks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var minutesPer: UITextField!

    @IBOutlet weak var startingBig: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToTimer" {
            let timerView = (segue.destinationViewController) as! TimerViewController
//            timerView.setTimer()
            timerView.time = Int(self.minutesPer.text!)!
            timerView.bBlind = Int(self.startingBig.text!)!
        
        }
    }

}

