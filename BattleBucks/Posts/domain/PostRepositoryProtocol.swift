//
//  PostRepositoryProtocol.swift
//  BattleBucks
//
//  Created by Indraneel Varma on 17/10/25.
//

import Foundation


protocol PostRepositoryProtocol {
    func getPosts() async throws -> [PostModel]
}
