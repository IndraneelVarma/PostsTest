//
//  ApiError.swift
//  BattleBucks
//
//  Created by Indraneel Varma on 17/10/25.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidStatusCode
    case invalidResponse
    case networkError
}
