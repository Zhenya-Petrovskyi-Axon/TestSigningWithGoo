//
//  UITextFieldForPickerView.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 08.06.2021.
//

import UIKit

extension UITextField {
    func loadDropdownData(_ data: [String]) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self)
    }}
