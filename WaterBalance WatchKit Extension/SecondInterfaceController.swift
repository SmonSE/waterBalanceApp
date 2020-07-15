//
//  SecondInterfaceController.swift
//  WaterBalance WatchKit Extension
//
//  Created by Simon Eisele on 18.11.19.
//  Copyright © 2019 Simon Eisele. All rights reserved.
//

import WatchKit
import Foundation


class SecondInterfaceController: WKInterfaceController {

    @IBOutlet weak var imageView: WKInterfaceImage!
    

    
    
//    override func awake(withContext context: Any?) {
//        super.awake(withContext: context)
//
//        // Configure interface objects here.
//    }

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        //Animate the Progress Bar //
        imageView.setImageNamed("Steps-")
        imageView.startAnimatingWithImages(in: NSMakeRange(0, 21), duration: 2, repeatCount: 1)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
