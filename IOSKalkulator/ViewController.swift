//
//  ViewController.swift
//  IOSKalkulator
//
//  Created by Branko Keleuva on 02/11/2016.
//  Copyright © 2016 Branko Keleuva. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
   
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    
    var runningNumber = ""
    
    var leftValStr = ""
    var rightValStr = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    @IBAction func numberPressd(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(_ sender: UIButton) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPresses(_ sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubstractPressed(_ sender: Any) {
        processOperation(operation: .Substract)
    }
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(_ sender: Any) {
        processOperation(operation: .Empty)
        
        outputLbl.text = "0"
        
    }
   /* @IBAction func onDividePressed(sender: Any) {
        
    }
    @IBAction func onMultiplyPressed(sender: Any) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubstractPressed(sender: Any) {
        processOperation(operation: .Substract)
    }
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(operation: currentOperation)
    }*/

    func playSound() {
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\( Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\( Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\( Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\( Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            currentOperation = operation
        } else {
            //this is the first time an opertaor has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }

}

