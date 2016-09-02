//
//  SetupProfileController.swift
//  gotago
//
//  Created by Atin Amit on 6/22/16.
//  Copyright © 2016 Atin Amit. All rights reserved.
//

import UIKit

class SetupProfileController: UIViewController {
    
//    let name:String;
    
//
//    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
//    }
    deinit{
        doNothing()
        
//        self.navigationController!.viewControllers.removeAll()
        print("deinit called")
        print(" is being deInitialized.");
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doNothing() {
        print("do nothing..!!")
    }
    
}
