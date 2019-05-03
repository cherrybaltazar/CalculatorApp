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
    
    var arrSymbols = ["AC","=","+/-","%","/","x","-","+","."]
    var arrCollectedStrings = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
    }
    @IBAction func calculate(_ sender: UIButton) {
  
        
       
        if txtViewResult.text.isEmpty {
            //Clear all the collections in array and display a number in the first element of array
            arrCollectedStrings.removeAll()
            arrCollectedStrings.append((sender.titleLabel?.text)!)
            txtViewResult.text = arrCollectedStrings[0]
            
              //It checks the collected string if it is a number or a symbol. If it is a symbol it will proceed. If the symbol is a point, it will insert 0 in the first element of array. Otherwise, it will clear the screen.
            for symbol in arrSymbols {
                if arrCollectedStrings.last == symbol {
                    if arrCollectedStrings.last == arrSymbols.last {
                        arrCollectedStrings.insert("0", at: 0)
                        txtViewResult.text = arrCollectedStrings.joined()
                    } else {
                        arrCollectedStrings.removeAll()
                        txtViewResult.text = ""
                    }
                }
            }
            
        } else {
            //Clears the screen if the symbol is AC
            if sender.titleLabel?.text == arrSymbols.first {
                arrCollectedStrings.removeAll()
                txtViewResult.text = ""
            } else if (arrCollectedStrings.last != nil) {
                arrCollectedStrings.append((sender.titleLabel?.text)!)
                txtViewResult.text = arrCollectedStrings.joined()
                
                //Checks if the symbol is the same with a point or equal, it will remove the last element if the point has been tapped
                if (arrSymbols.last == arrCollectedStrings.last) || arrCollectedStrings.last == arrSymbols[1] {
                    arrCollectedStrings.removeLast()
                    
                    if (arrSymbols[1] == sender.titleLabel?.text) {
                         arrCollectedStrings.removeLast()
                    }
                    
                    txtViewResult.text = arrCollectedStrings.joined()
                //Checks if the symbol is +/- or %, it will display zero
                } else if (arrSymbols[2] == sender.titleLabel?.text || arrSymbols[3] == sender.titleLabel?.text) {
                    arrCollectedStrings.removeAll()
                    arrCollectedStrings.insert("0", at: 0)
                    txtViewResult.text = arrCollectedStrings.joined()
                }
            } else {
                //Checks the point symbol if it exist on the screen when you first open the app
                if (sender.titleLabel?.text == arrSymbols.last) {
                    arrCollectedStrings.insert("0" + (sender.titleLabel?.text)!, at: 0)
                    txtViewResult.text = arrCollectedStrings.joined()
                }
            }
        }
    }
}
