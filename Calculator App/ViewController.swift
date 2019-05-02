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
    
    var arrSymbols = ["AC","+/-","%","/","x","-","+","=","."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
    }
    @IBAction func calculate(_ sender: UIButton) {
  
        
       
        if txtViewResult.text.isEmpty {
            //Display the numbers
            txtViewResult.text = sender.titleLabel?.text
            
            //Checks the screen if it contains a symbol
            for symbol in arrSymbols {
                if txtViewResult.text == symbol {
                    //Check if it is equal to ".", it displays "0."
                    txtViewResult.text = txtViewResult.text == arrSymbols[8] ? "0." : ""
                }
            }
         
        } else {
            //Clears the screen if the symbol is AC
            if sender.titleLabel?.text == arrSymbols[0] {
                txtViewResult.text = ""
            } else {
                txtViewResult.text.append((sender.titleLabel?.text)!)
                for symbol in arrSymbols {
                    if txtViewResult.text.contains(symbol) {
                        txtViewResult.text = txtViewResult.text.contains(".") || txtViewResult.text.contains("=") ? "0." : ""
                    }
                }
            }
            
          
        }
        
    }
    
  
}
