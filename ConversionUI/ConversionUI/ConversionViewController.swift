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
    var currentConversion = 0   //will be set in the viewDidLoad
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversions = [
        Conversion(label: "fahrenheit to celsius", inputUnit: "°F", outputUnit: "°C"),
        Conversion(label: "celsius to fahrenheit", inputUnit: "°C", outputUnit: "°F"),
        Conversion(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"),
        Conversion(label: "kilometers to miles" , inputUnit: "km", outputUnit: "mi")
        ]
        
        currentConversion = conversions.index(where: {$0.label == "fahrenheit to celsius"}) ?? 0    //could just set to 0, this makes modifying conversion table simpler
        print(currentConversion)
        ChangeInputOutput(input: conversions[currentConversion].label , output: conversions[currentConversion].label)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    @IBAction func ConvertButton(_ sender: Any) {
        let alert = UIAlertController(title:"Choose conversion",message:"", preferredStyle: UIAlertController.Style.actionSheet)
        for x in 1...conversions.count{
            //Will add an action to the actionSheet for every entry in the conversions array and populate the actionSheet with the correct information
            alert.addAction(UIAlertAction(title: conversions[x].label , style: UIAlertAction.Style.default, handler: {
                (alertAction) -> Void in
                self.ChangeInputOutput(input: self.conversions[x].inputUnit , output: self.conversions[x].outputUnit)
                self.currentConversion = x;
            }))
        }
        self.present(alert, animated:true, completion: nil)
    }
    
    func ChangeInputOutput(input: String, output: String){
        inputDisplay.text = input
        outputDisplay.text = output
    }

}
