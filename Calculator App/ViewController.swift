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
   
    //Numbers
    @IBOutlet weak var btnNine: UIButton!
    @IBOutlet weak var btnEight: UIButton!
    @IBOutlet weak var btnSeven: UIButton!
    @IBOutlet weak var btnSix: UIButton!
    @IBOutlet weak var btnFive: UIButton!
    @IBOutlet weak var btnFour: UIButton!
    @IBOutlet weak var btnThree: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnZero: UIButton!
    
    var arrSymbols = ["AC","=","+/-","%","."]
    var arrOperators = ["/","x","-","+"]
    var result = Double()
    var firstOperand = Double()
    var secondOperand = Double()
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
            firstOperand = 0
            arrCollectedStrings.append((sender.titleLabel?.text)!)
            txtViewResult.text = arrCollectedStrings[0]
            
            if arrSymbols.contains((sender.titleLabel?.text)!) || arrOperators.contains((sender.titleLabel?.text)!) {
                //POINT
                    if arrCollectedStrings.last == arrSymbols.last {
                        arrCollectedStrings.insert("0", at: 0)
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
            //AC
            if sender.titleLabel?.text == arrSymbols.first {
                arrCollectedStrings.removeAll()
                firstOperand = 0
                secondOperand = 0
                result = 0
                operatorValue = ""
                txtViewResult.text = ""
            } else {
                //OPERATORS
                if arrOperators.contains((sender.titleLabel?.text)!)  {
                    print(" OPERATOR",arrCollectedStrings, firstOperand)

                    firstOperand = operand(sender: sender, firstOpernd: !firstOperand.isZero ? firstOperand : Double(arrCollectedStrings.joined()) ?? firstOperand)
                
                //EQUALS
                } else if sender.tag <= 2 && arrSymbols[1] == sender.titleLabel?.text  {
                    //ADD VALUE TO SECOND OPERAND
                    txtViewResult.text = performOperation(sender: sender)
                    sender.tag = 2
                    
                //POSITIVE AND NEGATIVE
                } else if arrSymbols[2] == sender.titleLabel?.text {
                     txtViewResult.text  = negativeOperation(sender: sender)
                
                //PERCENTAGE
                } else if arrSymbols[3] == sender.titleLabel?.text {
                    //STORE THE VALUE OF THE PERCENT
                    if arrOperators.contains(operatorValue) {
                        percentValue = Double(arrCollectedStrings.joined()) ?? 0
                        percentValue = percentValue / 100
                    }
                    firstOperand = operand(sender: sender, firstOpernd: arrOperators.contains(operatorValue) ? firstOperand : Double(arrCollectedStrings.joined()) ?? firstOperand)
                    //1 TO DO: CREATE A STORAGE FOR THE PERCENT VALUE SO THAT
                    //IT WILL NOT CLEAR THE SCREEN WHEN +/- IS TAPPED
                    arrCollectedStrings.removeAll()
                    txtViewResult.text = performOperation(sender: sender)
                    print("PERCENT", arrCollectedStrings, firstOperand, operatorValue, result)
                } else {

                //NUMBERS & SYMBOLS
                    if sender.tag == 0 {
                        arrCollectedStrings.append((sender.titleLabel?.text)!)
                    }
                    txtViewResult.text = arrCollectedStrings.joined()
                }
            }
        }
    }
    
    func operand(sender: UIButton, firstOpernd: Double) -> Double {
        //ADD VALUE TO FIRST OPERAND
        if sender.tag == 0  {
            firstOperand = firstOpernd
            txtViewResult.text = String(firstOpernd)
            arrCollectedStrings.removeAll()
            operatorValue = (sender.titleLabel?.text)!
            sender.tag = 1
        }
        return firstOpernd
    }
    
    func performOperation (sender: UIButton) -> String {
        //ADD VALUE TO SECOND OPERAND
        secondOperand = arrSymbols[3] == sender.titleLabel?.text ? percentValue : Double(arrCollectedStrings.joined()) ?? percentValue
        
        switch operatorValue {
        //MULTIPLY
        case arrOperators[1]:
            result = firstOperand * secondOperand
            print(String(result), "MULTIPLY")
        //DIVIDE && PERCENTAGE
        case arrOperators.first:
            result = firstOperand / secondOperand
            print(String(result), "DIVIDE")
        //ADDITION
        case arrOperators[3]:
            result = firstOperand + secondOperand
            print(String(result), "ADD")
        //SUBTRACT
        case arrOperators[2]:
            result = firstOperand - secondOperand
            print(String(result), "SUBTRACT")
        default:
            //PERCENT
            if sender.titleLabel?.text == arrSymbols[3] {
                result = firstOperand / 100
            }
        }
        firstOperand = result
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
    return arrCollectedStrings.joined()
    }
}
