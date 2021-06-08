//
//  UITextFieldForPickerView.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 08.06.2021.
//

import UIKit

extension UITextField {
    func loadDropdownData(_ data: [String], _ selectionHandler : @escaping (_ selectedText: String) -> Void) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self, onSelect: selectionHandler)
    }
    
    func unloadDropDown() {
        self.inputView?.removeFromSuperview()
    }
    
    func loadToSuperView() {
        
    }
}
