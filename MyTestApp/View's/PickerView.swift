//
//  PickerView.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 08.06.2021.
//

import UIKit

class MyPickerView: UIPickerView {
    var pickerData: [String]!
    var pickerTextField: UITextField!
    var selectionHandler: ((_ selectedText: String) -> Void)?
    
    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: CGRect.zero)
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        self.delegate = self
        self.dataSource = self
        DispatchQueue.main.async {
            if pickerData.count != 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
        if self.pickerTextField.text != nil && self.selectionHandler != nil {
            selectionHandler!(self.pickerTextField.text!)
        }
    }
    
    convenience init(pickerData: [String], dropdownField: UITextField, onSelect selectionHandler : @escaping (_ selectedText: String) -> Void) {
        self.init(pickerData: pickerData, dropdownField: dropdownField)
        self.selectionHandler = selectionHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:\(aDecoder) has not been implemented")
    }
}

extension MyPickerView: UIPickerViewDelegate {
    // Sets number of columns in picker view
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        1
    }
    // Sets the number of rows in the picker view
    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
        if self.pickerTextField.text != nil && self.selectionHandler != nil {
            selectionHandler!(self.pickerTextField.text!)
        }
    }
}

extension MyPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
}
