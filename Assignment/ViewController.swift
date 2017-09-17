//
//  ViewController.swift
//  Assignment
//
//  Created by Mahmoud El Sharkawy on 9/16/17.
//  Copyright © 2017 Mahmoud El Sharkawy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    var pickerCountry: UIPickerView! = UIPickerView()
    var pickerAge: UIDatePicker! = UIDatePicker()
    
    @IBOutlet weak var textFieldCountry: UITextField!
    @IBOutlet weak var textFieldAge: UITextField!
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var showNameSwitch: UISwitch!
    
    let countriesData =
        ["Egypt","Itay","Spain","England","Lebnan"]

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerCountry.delegate = self
        pickerCountry.dataSource = self
        textFieldCountry.inputView = pickerCountry
        textFieldCountry.text = countriesData[0]
        
        textFieldAge.inputView = pickerAge
        pickerAge.addTarget(self, action: #selector(ViewController.handleDatePicker), for: UIControlEvents.valueChanged)
        pickerAge.datePickerMode = .date
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesData.count
    }

    func pickerView(_
        pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        
        return countriesData[row]
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int){

        textFieldCountry.text = countriesData[row]
        self.view.endEditing(false)
    }
    
    
    func handleDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        textFieldAge.text = dateFormatter.string(from: pickerAge.date)
        textFieldAge.resignFirstResponder()
    }
    
    @IBAction func submit(){
        print("Submit clicked")
        if(validate()){
            let user : User = User (name: textFieldName.text!, showName: showNameSwitch.isOn, email: textFieldEmail.text!, age: textFieldAge.text!, country: textFieldCountry.text!, gender: gender.selectedSegmentIndex)
            
            let nextScreen = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
            nextScreen.user = user
    
            self.navigationController?.pushViewController(nextScreen, animated: true)
        }
    }
    
    func showAlertMessage(title: String ,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func validate() -> Bool {
        if(textFieldName.text?.isEmpty)!{
            showAlertMessage(title: "Name", message: "name can't be empty")
            return false
        }
        
        if(textFieldEmail.text!.isEmpty || !(isValidEmail(testEmailFormate: textFieldEmail.text!))){
            showAlertMessage(title: "Email", message: "not a valid email format")
            return false
        }
        
        if(textFieldAge.text?.isEmpty)!{
            showAlertMessage(title: "Age", message: "age can't be empty")
            return false
        }
        
        return true
    }
    
    func isValidEmail(testEmailFormate:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testEmailFormate)
    }
    
}

