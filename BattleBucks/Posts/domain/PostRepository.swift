//
//  PostRepository.swift
//  BattleBucks
//
//  Created by Indraneel Varma on 17/10/25.
//

import Foundation


actor PostRepository: PostRepositoryProtocol {
    func getPosts() async throws -> [PostModel] {
        guard let baseUrl = URL(string: ApiConfig.baseUrl) else {
            throw ApiError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: baseUrl)
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw ApiError.invalidStatusCode
        }
        
        return try JSONDecoder().decode([PostModel].self, from: data)
    }
}
