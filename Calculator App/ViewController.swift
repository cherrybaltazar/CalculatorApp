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
            
              //It checks the collected string if it is a number or a symbol. If it is a symbol it will proceed. If the symbol is a point, it will insert 0 in the first element of array. Otherwise, it will clear the screen.
            if arrSymbols.contains((sender.titleLabel?.text)!) || arrOperators.contains((sender.titleLabel?.text)!) {
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
                if arrOperators.contains((sender.titleLabel?.text)!) {
                    print(arrCollectedStrings, "OPERATOR")
                    firstOperand = operand(sender: sender, firstOpernd: Double(arrCollectedStrings.joined()) ?? firstOperand)
                    operatorValue = (sender.titleLabel?.text)!
                

                //EQUALS
                } else if sender.tag <= 2 && arrSymbols[1] == sender.titleLabel?.text  {
                    //ADD VALUE TO SECOND OPERAND
                txtViewResult.text = performOperation(sender: sender)
                    sender.tag = 2
                    
                //PERCENTAGE
                } else if arrSymbols[3] == sender.titleLabel?.text {
                    //STORE THE VALUE OF THE PERCENT
                    if arrOperators.contains(operatorValue) {
                        percentValue = Double(arrCollectedStrings.joined()) ?? 0
                        percentValue = percentValue / 100
                    }
                    firstOperand = operand(sender: sender, firstOpernd: arrOperators.contains(operatorValue) ? firstOperand : Double(arrCollectedStrings.joined()) ?? firstOperand)
                    txtViewResult.text = performOperation(sender: sender)
                    print("PERCENT", firstOperand, operatorValue, result)
                    
                //NUMBERS & SYMBOLS
                } else {
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
        if sender.tag <= 1  {
           // firstOperand = Double(arrCollectedStrings.joined()) ?? 0
            firstOperand = firstOpernd
            txtViewResult.text = String(firstOpernd)
            arrCollectedStrings.removeAll()
            print("FIRST OPERAND")
            sender.tag = 1
        }
        return firstOpernd
    }
    
    func performOperation (sender: UIButton) -> String {
        //ADD VALUE TO SECOND OPERAND
        //ADDED first Operand so it won't get an error msg when tapping the % and = at the same time e.g 100/10% = .1
        secondOperand = arrSymbols[3] == sender.titleLabel?.text ? percentValue : Double(arrCollectedStrings.joined()) ?? percentValue //100
        
        print(secondOperand, "SECOND OPERAND")
        switch operatorValue {
        //DIVIDE && PERCENTAGE
        case arrOperators.first:
            result = firstOperand / secondOperand
            print(String(result), "DIVIDE")
        //MULTIPLY
        case arrOperators[1]:
            result = firstOperand * secondOperand
            print(String(result), "MULTIPLY")
        //SUBTRACT
        case arrOperators[2]:
            result = firstOperand - secondOperand
            print(String(result), "SUBTRACT")
        //ADDITION
        case arrOperators[3]:
            result = firstOperand + secondOperand
            print(String(result), "ADD")
        default:
            //PERCENT ONLY
            if sender.titleLabel?.text == arrSymbols[3] {
                result = firstOperand / 100
                print(String(result), "PERCENT AT FIRST RUN")
            }
        }
        firstOperand = result
        print("PERFORM OPERATION", secondOperand, result)
        return String(result)
    }
}
