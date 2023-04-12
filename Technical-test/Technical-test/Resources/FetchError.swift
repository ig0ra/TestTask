//
//  FetchError.swift
//  Technical-test
//
//  Created by Ihor Obrizko on 12.04.2023.
//

import Foundation

enum FetchError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}
