//
//  SettingsViewController.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var showAudioSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        showAudioSwitch.on = UserStore.showAudioView
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        UserStore.showAudioView = showAudioSwitch.on
    }


}
