//
//  VariationColor.swift
//  Technical-test
//
//  Created by Ihor Obrizko on 12.04.2023.
//

import UIKit

enum VariationColor: String {
    case green, red
    
    func uiColor() -> UIColor {
        switch self {
        case .green: return .green
        case .red: return .red
        }
    }
}
