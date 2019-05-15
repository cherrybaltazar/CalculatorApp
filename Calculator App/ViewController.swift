//
//  ViewController.swift
//  Calculator App
//
//  Created by ADMIN on 4/29/19.
//  Copyright © 2019 Cherrylyn Baltazar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtViewResult: UITextView!
    //Symbols
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnPositiveNegativeIntegers: UIButton!
    @IBOutlet weak var btnPercent: UIButton!
    @IBOutlet weak var btnPoint: UIButton!
    @IBOutlet weak var btnEquals: UIButton!
    
    //Operators
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnMultipy: UIButton!
    @IBOutlet weak var btnSubtract: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    var arrSymbols = ["AC","=","+/-","%","."]
    var arrOperators = ["/","x","-","+"]
    var result = Double()
    var firstOperand = Int()
    var secondOperand = Int()
    var operatorValue = String()
    var arrCollectedStrings = [String]()
    var percentValue = Double()
    var negativeCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func calculate(_ sender: UIButton) {
        if txtViewResult.text.isEmpty {
            //Clear all the collections in array and display a number in the first element of array

            arrCollectedStrings.append((sender.titleLabel?.text)!)
            firstOperand = Int(arrCollectedStrings.joined()) ?? 0
            txtViewResult.text = arrCollectedStrings.joined()
            
            if arrSymbols.contains((sender.titleLabel?.text)!) || arrOperators.contains((sender.titleLabel?.text)!) {
                //POINT
                if arrCollectedStrings.last == arrSymbols.last {
                    arrCollectedStrings.insert("0", at: 0)
                    firstOperand = Int(arrCollectedStrings.joined()) ?? 0
                    txtViewResult.text = arrCollectedStrings.joined()
                    sender.tag = 5
                } else {
                    arrCollectedStrings.removeAll()
                    firstOperand = 0
                    secondOperand = 0
                    result = 0
                    operatorValue = ""
                    txtViewResult.text = ""
                }
            }
        } else {
            switch sender.titleLabel?.text {
                
            //Clear the screen when AC is tapped
            case arrSymbols.first:
                arrCollectedStrings.removeAll()
                firstOperand = 0
                secondOperand = 0
                result = 0
                operatorValue = ""
                txtViewResult.text = ""
                
            //OPERATORS & EQUALS
            //STORE THE FIRST OPERAND AND OPERATOR
            case arrOperators.first, arrOperators[1], arrOperators[2], arrOperators.last, arrSymbols[1]:
                //TO DO: FIX HERE :(
                firstOperand = operand(sender: sender, firstOpernd: firstOperand)
                arrCollectedStrings.removeAll()
                //EQUALS
                if arrSymbols[1] != sender.titleLabel?.text {
                    operatorValue = (sender.titleLabel?.text)!
                }

                txtViewResult.text = performOperation(sender: sender)
                
                
            //POSITIVE AND NEGATIVE
            case arrSymbols[2]:
                txtViewResult.text  = negativeOperation(sender: sender)
                
            //PERCENTAGE
            case arrSymbols[3]:
                //STORE THE VALUE OF THE PERCENT
                if arrOperators.contains(operatorValue) {
                    percentValue = Double(arrCollectedStrings.joined()) ?? 0
                    percentValue = percentValue / 100
                   // sender.tag = 4
                }
                firstOperand = operand(sender: sender, firstOpernd: arrOperators.contains(operatorValue) ? firstOperand : Int(arrCollectedStrings.joined()) ?? firstOperand)
                //1 TO DO: CREATE A STORAGE FOR THE PERCENT VALUE SO THAT
                //IT WILL NOT CLEAR THE SCREEN WHEN +/- IS TAPPED
                arrCollectedStrings.removeAll()
                txtViewResult.text = performOperation(sender: sender)
                
            default:
                //NUMBERS
                if sender.tag == 0 {
                    arrCollectedStrings.append((sender.titleLabel?.text)!)
                }
                txtViewResult.text = arrCollectedStrings.joined()
                
                //STORE THE SECOND OPERAND
                if !operatorValue.isEmpty {
                    secondOperand = arrSymbols[3] == sender.titleLabel?.text ? Int(percentValue) : Int(arrCollectedStrings.joined()) ?? Int(percentValue)
                }
                print("DEFAULT VALUE")
            }
        }
    }
    
    func operand(sender: UIButton, firstOpernd: Int) -> Int {
        //ADD VALUE TO FIRST OPERAND
        if sender.tag == 0  {
            firstOperand = firstOpernd
            txtViewResult.text = String(firstOpernd)
            arrCollectedStrings.removeAll()
            sender.tag = 1
        }
        return firstOpernd
    }
    
    func performOperation (sender: UIButton) -> String {
        
        switch operatorValue {
        //MULTIPLY
        case arrOperators[1]:
            result = Double(firstOperand * secondOperand)
        //DIVIDE && PERCENTAGE
        case arrOperators.first:
            result = Double(firstOperand / secondOperand)
        //ADDITION
        case arrOperators[3]:
            result = Double(firstOperand + secondOperand)
        //SUBTRACT
        case arrOperators[2]:
            result = Double(firstOperand - secondOperand)
        default:
            //PERCENT
            if sender.titleLabel?.text == arrSymbols[3] {
                result = Double(firstOperand) / 100
            }
        }
        firstOperand = Int(result)
        return String(result)
    }
    
    func negativeOperation (sender: UIButton) -> String {
        //2 THE CODE CLEARS THE COLLECTED STRING in the %
        if arrCollectedStrings.contains(arrOperators[2]) {
            arrCollectedStrings.removeFirst()
            print(" POSITIVE", arrCollectedStrings, negativeCount, sender.tag)
        } else {
            arrCollectedStrings.insert("-", at: 0)
            print("NEGATIVE", arrCollectedStrings, negativeCount, sender.tag)
            
        }
        firstOperand = Int(arrCollectedStrings.joined()) ?? 0
        return arrCollectedStrings.joined()
    }
}
