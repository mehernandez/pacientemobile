//
//  NuevoEpisodioViewController.swift
//  PacienteMobile
//
//  Created by Mario Hernandez on 15/03/15.
//  Copyright (c) 2015 Equinox. All rights reserved.
//

import UIKit
import AVFoundation

class NuevoEpisodioViewController: UIViewController,
AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet weak var btnGrabar: UIButton!
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}