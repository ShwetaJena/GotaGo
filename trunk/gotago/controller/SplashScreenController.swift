//
//  SplashScreen.swift
//  gotago
//
//  Created by Atin Amit on 5/31/16.
//  Copyright © 2016 Atin Amit. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController {
    
    @IBOutlet weak var copyrightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        performSelector(#selector(SplashScreenController.showGetStarted), withObject: nil, afterDelay: 3)
        
        copyrightLabel.font = OpenSansFont.regularWithSize(16)//OpenSansFont.regularWithSize(18)
    }
    
    func showGetStarted() {
        performSegueWithIdentifier("showGetStarted", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
