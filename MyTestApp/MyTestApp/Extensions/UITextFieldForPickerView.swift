//
//  UITextFieldForPickerView.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 08.06.2021.
//

import UIKit

extension UITextField {
    func loadDropdownData(data: [String], selectionHandler : @escaping (_ selectedText: String) -> Void) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self, onSelect: selectionHandler)
    }
}
