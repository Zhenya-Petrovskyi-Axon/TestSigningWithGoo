//
//  GreenViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

class GenderViewController: BaseViewController, Storyboarded {
    @IBOutlet weak var pickerTextField: UITextField!
    @IBOutlet weak var genderDescriptionLabel: UILabel!
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("dismiss:")))
    let salutations = ["", "Mr.", "Ms.", "Mrs.", "Both"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerTextField.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Dissmiss popup on screen tap
    func dissmissRecogniser() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
    
    // MARK: - Dissmiss pop-up with tap on screen
    @objc func dismissView() {
        pickerTextField.text = nil
    }
    
    func setupDropDownPicker() {
        pickerTextField.loadDropdownData(salutations, pickedGender(selectedText:))
    }
    
    func pickedGender(selectedText: String) {
        if selectedText == "" {
            genderDescriptionLabel.text = selectedText
            pickerTextField.unloadDropDown()
        } else if selectedText == "Mr." {
            genderDescriptionLabel.text = selectedText
            pickerTextField.unloadDropDown()
        } else {
            genderDescriptionLabel.text = selectedText
            pickerTextField.unloadDropDown()
        }
    }
    func dismiss(gest: UITapGestureRecognizer){
        view.endEditing(true)
        pickerTextField.text = nil
    }
    
}

extension GenderViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupDropDownPicker()
    }
}
