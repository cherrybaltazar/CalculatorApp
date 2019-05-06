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
                if (arrOperators.contains((sender.titleLabel?.text)!)){
                    print(arrCollectedStrings, "= nil( /, x, - +)")
                    operatorValue = (sender.titleLabel?.text)!
                    //ADD VALUE TO FIRST OPERAND
                    if sender.tag <= 1  {
                        firstOperand = Double(arrCollectedStrings.joined()) ?? 0
                        txtViewResult.text = String(firstOperand)
                        arrCollectedStrings.removeAll()
                        print(firstOperand, "FIRST OPERAND")
                        sender.tag = 1
                    }
                  
                //EQUALS
                } else if (sender.tag <= 2 && arrSymbols[1] == sender.titleLabel?.text) {
                    //ADD VALUE TO SECOND OPERAND
                    secondOperand = Double(arrCollectedStrings.joined())!
                   
                    switch operatorValue {
                    //DIVIDE
                    case arrOperators.first:
                        result = Double(firstOperand) / Double(arrCollectedStrings.joined())!
                        print(String(result), "DIVIDE")
                    //MULTIPLY
                    case arrOperators[1]:
                        result = Double(firstOperand) * Double(arrCollectedStrings.joined())!
                        print(String(result), "MULTIPLY")
                    //SUBTRACT
                    case arrOperators[2]:
                        result = Double(firstOperand) - Double(arrCollectedStrings.joined())!
                        print(String(result), "SUBTRACT")
                    //ADDITION
                    case arrOperators[3]:
                        result = firstOperand + secondOperand
                        print(String(result), "ADD")
                    default:
                       // txtViewResult.text = arrCollectedStrings.joined()
                        print(String(result), "NONE")
                    }
                    secondOperand = firstOperand
                    firstOperand = result
                    txtViewResult.text = String(result)
                    sender.tag = 2
                    
                    
                //NUMBERS & SYMBOLS
                } else {
                    if sender.tag == 0 {
                    arrCollectedStrings.append((sender.titleLabel?.text)!)
                        print("APPEND A NUMBER")
                    }
                    txtViewResult.text = arrCollectedStrings.joined()
                }
            }
        }
    }
}
