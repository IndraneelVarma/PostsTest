//
//  PostsView.swift
//  BattleBucks
//
//  Created by Indraneel Varma on 17/10/25.
//

import SwiftUI

struct PostsView: View {
    private enum Category: String, CaseIterable {
        case all
        case favs
    }
    @State private var selectedCetegory: Category = .all
    @State private var favPosts = Set<Int>()
    @StateObject private var viewModel = PostViewModel(postRepo: PostRepository())
    @State private var searchText = ""
    // Computed property for favorite posts
    private var filteredFavoritePosts: [PostModel] {
    viewModel.postResponse?.filter { favPosts.contains($0.id) } ?? []
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                //category filter
                Picker("Category", selection: $selectedCetegory){
                    Text("All").tag(Category.all)
                    Text("Favourites").tag(Category.favs)
                }
                .pickerStyle(.palette)
                .padding()
                
                //posts list
                ScrollView {
                    LazyVStack{
                        if selectedCetegory == .all {
                            if let posts = viewModel.postResponse {
                                ForEach(posts) { post in
                                    if searched(post, searchText: searchText){
                                        NavigationLink(value: post){
                                            PostCardView(
                                                viewModel: viewModel,
                                                post: post, favPosts: $favPosts,
                                                geometry: geo
                                            )
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            } else {
                                if viewModel.isLoading {
                                    ProgressView()
                                } else {
                                    Text(viewModel.errorMEssage)
                                        .foregroundStyle(.red)
                                }
                            }
                        } else {
                            if !filteredFavoritePosts.isEmpty{
                                ForEach(filteredFavoritePosts) { post in
                                    if searched(post, searchText: searchText){
                                        NavigationLink(value: post){
                                            PostCardView(
                                                viewModel: viewModel,
                                                post: post, favPosts: $favPosts,
                                                geometry: geo
                                            )
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            else {
                                Text("No Favourites Added")
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
                .refreshable {
                    Task{
                        await getPosts()
                    }
                }
                .task {
                    await getPosts()
                }
                .navigationTitle("Posts")
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationDestination(for: PostModel.self){ post in
                FullPostView(
                    post: post,
                    favPosts: $favPosts,
                    viewModel: viewModel
                )
            }
        }
    }
    
    func getPosts() async {
        await viewModel.getPosts()
    }
    
    func searched(_ post: PostModel,searchText: String) -> Bool {
        if searchText.isEmpty {
            return true
        }
        else if post.title
            .lowercased()
            .contains(searchText.lowercased()) || post.body
            .lowercased()
            .contains(searchText.lowercased()) {
            return true
        }
        
        return false
    }
}

#Preview {
    PostsView()
}
