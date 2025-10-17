//
//  PostViewModel.swift
//  BattleBucks
//
//  Created by Indraneel Varma on 17/10/25.
//

import Foundation
import Combine

final class PostViewModel: ObservableObject {
    @Published var postResponse: [PostModel]? = nil
    @Published var isLoading = false
    @Published var errorMEssage = ""
    
    let postRepo: PostRepositoryProtocol
    
    init(postRepo: PostRepositoryProtocol) {
        self.postRepo = postRepo
    }
    
    func getPosts() async {
        do {
            postResponse?.removeAll()
            errorMEssage = ""
            isLoading = true
            postResponse = try await postRepo.getPosts()
            isLoading = false
        } catch {
            errorMEssage = error.localizedDescription
            isLoading = false
        }
    }
}
