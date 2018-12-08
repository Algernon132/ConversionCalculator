//
//  ConversionViewController.swift
//  ConversionUI
//
//  Created by Chaz on 10/26/18.
//  Copyright © 2018 Chaz. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet weak var inputDisplay: UITextField!
    @IBOutlet weak var outputDisplay: UITextField!
    //MARK: Properties
    
    struct Conversion{
        var label: String
        var inputUnit: String
        var outputUnit: String
    }
    var conversions = [Conversion]()
    var currentConversion: Conversion!  //will be set in the viewDidLoad
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversions = [
        Conversion(label: "fahrenheit to celsius", inputUnit: "°F", outputUnit: "°C"),
        Conversion(label: "celsius to fahrenheit", inputUnit: "°C", outputUnit: "°F"),
        Conversion(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"),
        Conversion(label: "kilometers to miles" , inputUnit: "km", outputUnit: "mi")
        ]
        
        currentConversion = conversions[0]
        print(currentConversion)
        ChangeInputOutput(input: currentConversion.inputUnit , output: currentConversion.outputUnit)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    
    @IBAction func ConvertButton(_ sender: Any) {
    let alert = UIAlertController(title:"Choose conversion",message:"", preferredStyle: UIAlertController.Style.actionSheet)
        for x in conversions{
            //Will add an action to the actionSheet for every entry in the conversions array and populate the actionSheet with the correct information
            alert.addAction(UIAlertAction(title: x.label , style: UIAlertAction.Style.default, handler: {
                (alertAction) -> Void in
                self.ChangeInputOutput(input: x.inputUnit , output: x.outputUnit)
                self.currentConversion = x;
            }))
        }
        self.present(alert, animated:true, completion: nil)
    }
    
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        inputDisplay.text?.append(sender.currentTitle!)
        convert()
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        inputDisplay.text = ""
        outputDisplay.text = ""
    }
    
    @IBAction func decimalPressed(_ sender: UIButton) {
        if let inputString = inputDisplay.text{
            if !inputString.contains("."){
                //only append a decimal if there is not already one in the number.
                inputDisplay.text?.append(".")
                convert()
            }
        }
    }
    
    @IBAction func changePosNeg(_ sender: Any) {
        if let currentInput = inputDisplay.text{
            if var currentInputDouble = Double(currentInput){
                currentInputDouble = currentInputDouble * -1
                inputDisplay.text = String(currentInputDouble)
                convert()
            }else{
                //if there is nothing currently in the input text field, start it with a "-"
                inputDisplay.text = "-"
            }
        }
    }
    
    
    func ChangeInputOutput(input: String, output: String){
        inputDisplay.placeholder = input
        outputDisplay.placeholder = output
    }
    
    func celsiusToFahrenheit(_ celsius: Double) -> Double{
        return celsius * (9/5) + 32
    }
    
    func fahrenheitToCelsius(_ fahrenheit: Double) -> Double{
        return (fahrenheit - 32) * (5/9)
    }
    
    func milesToKilometers(_ miles : Double) -> Double{
        return miles * 1.61
    }
    
    func kilometersToMiles(_ kilometers : Double) -> Double{
        return kilometers * 0.62;
    }
    
    func convert(){
        if let inputText = inputDisplay.text,
            let input = Double(inputText){
            var output : Double
            switch currentConversion.inputUnit{
            case "°F":
                output = fahrenheitToCelsius(input)
            case "°C":
                output = celsiusToFahrenheit(input)
            case "mi":
                output = milesToKilometers(input)
            case "km":
                output = kilometersToMiles(input)
            default:
                return
            }
            outputDisplay.text = String(format: "%.3f" , output) + " " + currentConversion.outputUnit
        }
    }

}
