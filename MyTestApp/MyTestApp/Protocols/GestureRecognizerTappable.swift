//
//  GestureRecognizerTappable.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 27.05.2021.
//

import UIKit

/// Protocol used to handle gestures
protocol GestureRecognizerTappable { }
/// Which view can handle with gestures & which is not. Further usage by returning true or false by gestureRecognizer delegate.
class GestureRecognizerTappableView: UIView, GestureRecognizerTappable { }
