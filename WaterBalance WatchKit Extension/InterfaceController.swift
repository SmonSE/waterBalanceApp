//
//  InterfaceController.swift
//  WaterBalance WatchKit Extension
//
//  Created by Simon Eisele on 17.11.19.
//  Copyright © 2019 Simon Eisele. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    weak var ThirdInterfaceController: WKInterfaceController!
    
    var mathView = 0.0
    var mathView2 = 0.0
    var mathView3 = 0.0
    var mathView4 = 0.0
    var mathView5 = 0
    var liquidAll = 0.0
    var waterScoreConv = 0.0
    var coffeeScoreConv = 0.0
    var teaScoreConv = 0.0
    var contextEmpty = 0
    var ageBetween = 0.0
    
    var resultBool = false
    var value = 0.0
    var weight = 0.0
    var unz = 0.00          // defined by formula
    var result = 0.0
    var waterSize = 150.0
    var coffeeSize = 150.0
    var teaSize = 150.0
    var waterneeds = 0.0
    
    let waterSizeAction = " ml"
    
    //Mark: - Outlets
    @IBOutlet weak var waterScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var coffeeScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var teaScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var ageTextFieldOutlet: WKInterfaceTextField!
    @IBOutlet weak var weightTextFieldOutlet: WKInterfaceTextField!
    @IBOutlet weak var dailyWaterTextFieldOutlet: WKInterfaceTextField!
    @IBOutlet weak var totalWaterStateTextFieldOutlet: WKInterfaceTextField!
    @IBOutlet weak var waterSizeOutlet: WKInterfaceTextField!
    @IBOutlet weak var coffeeSizeOutlet: WKInterfaceTextField!
    @IBOutlet weak var teaSizeOutlet: WKInterfaceTextField!
    
    //Mark: - Scores
    func safeScore(score: Int)->Int{
        if score < 0 {
            return 0
        }
        let maximumScore = scoreStrings.count-1
        if score > maximumScore {
            return maximumScore
        }
        return score
    }
    
    func calculation(result: Double){
        if (!resultBool){
            if (value != 0){
                dailyWaterTextFieldOutlet.setText("water needs")
            }else{
                let str1 = String(format: "%.2f", arguments: [result])
                dailyWaterTextFieldOutlet.setText(str1 + " L")
                
                let waterresult:Double = result
                let waterneeds:String = String(format:"%f", waterresult)
                print("WaterNeeds not rounded: \(waterneeds)") // result
            }
        }
    }
    
    func math() {
        waterScoreConv = Double(waterScore)*(waterSize/1000)          //müssen im Menü ersetzbar sein
        //print("WaterConv: \(waterScoreConv)")
        coffeeScoreConv = Double(coffeeScore)*(coffeeSize/1000)         //müssen im Menü ersetzbar sein
        //print("CoffeeConv: \(coffeeScoreConv)")
        teaScoreConv = Double(teaScore)*(teaSize/1000)              //müssen im Menü ersetzbar sein
        //print("TeaConv: \(teaScoreConv)")
        
        liquidAll = (waterScoreConv+coffeeScoreConv+teaScoreConv)
        //print("liquidAll: \(liquidAll)")

        if (waterScore>0||coffeeScore>0||teaScore>0){
            if (ageBetween>0.0 && weight>0.0) {
                    mathView = (result)
                    //print("resultRounded: \(result)")
                    mathView2 = (liquidAll/result)
                    //print("mathView2: \(mathView2)")
                    mathView3 = (mathView2*100)
                    //print("mathView3: \(mathView3)")
                    mathView4 = mathView3.rounded()
                    //print("mathView4: \(mathView4)")
                    mathView5 = Int(mathView4)
                    //print("mathView5: \(mathView5)")
                    
                    let str2 = String(format: "%.2f", arguments: [liquidAll])
                    totalWaterStateTextFieldOutlet.setText(str2 + " L")
                }
            }
    }
    
    var waterScore = 0 {
        didSet{
            waterScore = safeScore(score: waterScore)
            waterScoreLabel.setText(scoreStrings[waterScore])
        }
    }
    var teaScore = 0 {
        didSet{
            teaScore = safeScore(score: teaScore)
            teaScoreLabel.setText(scoreStrings[teaScore])
        }
    }
    var coffeeScore = 0 {
        didSet{
            coffeeScore = safeScore(score: coffeeScore)
            coffeeScoreLabel.setText(scoreStrings[coffeeScore])
        }
    }
    
    let scoreStrings = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"];
    
    //Mark: - Aktions
    @IBAction func didTrapWaterMinusButton() {
        if(ageBetween>0.0 && weight>0.0){
            waterScore-=1
            math()
        }
    }
    @IBAction func didTrapWaterPlusButton() {
        if(ageBetween>0.0 && weight>0.0){
            waterScore+=1
            math()
        }
    }
    @IBAction func didTrapCoffeeMinusButton() {
       if(ageBetween>0.0 && weight>0.0){
           coffeeScore-=1
           math()
       }
    }
    @IBAction func didTrapCoffeePlusButton() {
        if(ageBetween>0.0 && weight>0.0){
            coffeeScore+=1
            math()
        }
    }
    @IBAction func didTrapTeaMinusButton() {
        if(ageBetween>0.0 && weight>0.0){
            teaScore-=1
            math()
        }
    }
    @IBAction func didTrapTeaPlusButton() {
        if(ageBetween>0.0 && weight>0.0){
            teaScore+=1
            math()
        }
    }
    
    @IBAction func ageAction(_ value1: NSString?) {
        if (value1 != "" && value1 != nil){
                ageBetween = (value1! as NSString).doubleValue
                //print("Age: \(ageBetween)")
            }else{
                //print("leer")
            }
            if (ageBetween>=1 && ageBetween<=4){
                unz = 95.0
                //print("unz95: \(unz)")
            }else if(ageBetween>=5 && ageBetween<=7){
                unz = 75.0
                //print("unz75: \(unz)")
            }else if(ageBetween>=8 && ageBetween<=10){
                unz = 60.0
                //print("unz60: \(unz)")
            }else if(ageBetween>=11 && ageBetween<=13){
                unz = 50.0
                //print("unz50: \(unz)")
            }else if(ageBetween>=14 && ageBetween<=15){
                unz = 40.0
                //print("unz40: \(unz)")
            }else if(ageBetween>=16 && ageBetween<=19){
                unz = 40.0
                //print("unz40: \(unz)")
            }else if(ageBetween>=20 && ageBetween<=25){
                unz = 35.0
                //print("unz35: \(unz)")
            }else if(ageBetween>=26 && ageBetween<=51){
                unz = 35.0
                //print("unz35: \(unz)")
            }else if(ageBetween>=52 && ageBetween<=65){
                unz = 30.0
                //print("unz30: \(unz)")
            }else if(ageBetween>=66 && ageBetween<=120){
                unz = 30.0
                //print("unz30: \(unz)")
            }else{
                unz = 35.0
                //print("unz default: \(unz)")
            }
    }
    @IBAction func weightAction(_ value2: NSString?) {
        if (value2 != "" && value2 != nil){
            weight = (value2! as NSString).doubleValue
            //print("Weight: \(weight)")
        }else{
            print("leer")
        }
    }
    @IBAction func waterSizeAction(_ value3: NSString?) {
        if (value3 != "" && value3 != nil){
            waterSize = (value3! as NSString).doubleValue
            //print("Water size: \(waterSize) ml")
        }else{
            print("leer")
        }
    }
    @IBAction func coffeeSizeAction(_ value4: NSString?) {
        if (value4 != "" && value4 != nil){
            coffeeSize = (value4! as NSString).doubleValue
            //print("Coffee size: \(coffeeSize) ml")
        }else{
            print("leer")
        }
    }
    @IBAction func teaSizeAction(_ value5: NSString?) {
        if (value5 != "" && value5 != nil){
            teaSize = (value5! as NSString).doubleValue
            //print("Tea size: \(teaSize) ml")
        }else{
            print("leer")
        }
    }
    
    @IBAction func storeButton() {
        //result = (((age*weight)/divFormel)*unz)
        //resultRounded = ((result*1000).rounded()/1000)
        result = ((weight*unz)/1000)
        calculation(result: result)
        //print("WaterNeeds result rounded: \(result)")
    }
    
    @IBAction func refreshButton() {
        if (waterScore>=0||coffeeScore>=0||teaScore>=0){
            waterScore=0
            coffeeScore=0
            teaScore=0
        }
    }
    
    @IBAction func waterActionView() {
        presentController(withName: "ThirdInterfaceController", context:[mathView5, self])
    }
    @IBAction func coffeeActionView() {
        presentController(withName: "ThirdInterfaceController", context:[mathView5, self])
    }
    @IBAction func teaActionView() {
        presentController(withName: "ThirdInterfaceController", context:[mathView5, self])
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        //Animate the Progress Bar //
        //imageView.setImageNamed("Steps-")
        //imageView.startAnimatingWithImages(in: NSMakeRange(0, 10), duration: 2, repeatCount: 1)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
