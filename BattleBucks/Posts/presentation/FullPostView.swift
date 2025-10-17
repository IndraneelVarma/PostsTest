//
//  FullPostView.swift
//  BattleBucks
//
//  Created by Indraneel Varma on 17/10/25.
//

import SwiftUI

struct FullPostView: View {
    let post: PostModel
    @Binding var favPosts: Set<Int>
    @ObservedObject var viewModel: PostViewModel
    var body: some View {
        VStack{
            ScrollView{
                HStack(alignment: .top){
                    Text("\(post.id)")
                        .bold()
                    Text(post.title.capitalized)
                        .italic()
                    Spacer()
                    Button {
                        changeFavouriteStatus()
                    } label: {
                        Image(systemName: favPosts.contains(post.id) ? "heart.fill" : "heart")
                    }
                }
                
                AsyncImage(url: URL(string: "https://picsum.photos/200")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Color.red
                    } else {
                        ProgressView()
                    }
                }
                .padding()
                
                Text(post.body)
            }
            .padding()
        }
    }
    
    func changeFavouriteStatus() {
        if !favPosts.contains(post.id){
            favPosts.insert(post.id)
        } else {
            favPosts.remove(post.id)
        }
    }
}

