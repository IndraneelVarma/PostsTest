//
//  PostCardView.swift
//  BattleBucks
//
//  Created by Indraneel Varma on 17/10/25.
//

import SwiftUI

struct PostCardView: View {
    @ObservedObject var viewModel: PostViewModel
    let post: PostModel
    @Binding var favPosts: Set<Int>
    let geometry: GeometryProxy
    var body: some View {
                VStack(alignment: .center){
                    HStack{
                        HStack{
                            Text("\(post.id)")
                                .bold()
                            Text(post.title.capitalized)
                                .lineLimit(1)
                                .italic()
                        }
                        
                        Spacer()
                        
                        Button {
                            changeFavouriteStatus()
                        } label: {
                            Image(systemName: favPosts.contains(post.id) ? "heart.fill" : "heart")
                        }
                    }
                    .padding()

                    Spacer()
                    
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
                    
                    Spacer()
                    HStack{
                        Text(post.body)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                        Spacer()
                    }
                        .padding()
                }
                .frame(width: geometry.size.width * 0.85,height: geometry.size.height * 0.5)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.vertical)
    }
    
    func changeFavouriteStatus() {
        if !favPosts.contains(post.id){
            favPosts.insert(post.id)
        } else {
            favPosts.remove(post.id)
        }
    }
}

#Preview {
    PostsView()
}
