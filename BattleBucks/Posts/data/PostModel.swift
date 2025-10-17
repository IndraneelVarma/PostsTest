//
//  PostModel.swift
//  BattleBucks
//
//  Created by Indraneel Varma on 17/10/25.
//

import Foundation


nonisolated struct PostModel: Codable, Equatable, Hashable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
