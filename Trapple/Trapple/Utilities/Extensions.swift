//
//  Extensions.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 29/08/22.
//

import Foundation
import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
