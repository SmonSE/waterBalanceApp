//
//  ThirdInterfaceController.swift
//  WaterBalance WatchKit Extension
//
//  Created by Simon Eisele on 18.11.19.
//  Copyright © 2019 Simon Eisele. All rights reserved.
//

import WatchKit
import Foundation


class ThirdInterfaceController: WKInterfaceController {
    
    weak var InterfaceController: WKInterfaceController!
    var toRing = 0
    var plusOne = 1
    var finalRing = 0
    
    @IBOutlet weak var imageView: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        guard let values = context as? [Any] else { return }
        let context = values[0]
        //let InterfaceController = values[1] as! WKInterfaceController
        print("from Third Controller: \(context)")
        toRing = context as! Int
        finalRing = toRing+plusOne
        print("finalRing: \(finalRing)")
    }
    
    
//    override func awake(withContext context: Any?) {
//    super.awake(withContext: context)
//    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        //Animate the Progress Bar //
        imageView.setImageNamed("Steps-")
        imageView.startAnimatingWithImages(in: NSMakeRange(0, finalRing), duration: 2, repeatCount: 1)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
