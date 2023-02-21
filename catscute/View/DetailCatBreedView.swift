//
//  DetailCatBreedView.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import SwiftUI

struct DetailCatBreedView: View {
    let breed: CatBreed
    
    @StateObject private var viewModel = DetailCatBreedViewModel()
    
    private let heightImageCarousel: CGFloat = 250
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.images, id: \.id) { image in
                            AsyncImage(url: URL(string: image.url ?? "")) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(
                                            width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 20 / 100),
                                            height: heightImageCarousel
                                        )
                                        .cornerRadius(8)
                                        .scaledToFit()
                                case .success(let image):
                                    NavigationLink(destination: ImageZoomView(image: image)) {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(
                                                width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 20 / 100),
                                                height: heightImageCarousel
                                            )
                                            .cornerRadius(8)
                                    }
                                case .failure:
                                    Image(systemName: "exclamationmark.icloud.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(
                                            width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 20 / 100),
                                            height: heightImageCarousel
                                        )
                                        .cornerRadius(8)
                                @unknown default:
                                    fatalError()
                                }
                            }
                        }
                    }
                    .frame(minHeight: heightImageCarousel)
                }
                .padding(.leading, 10)
                Text("you can tap the image above to view more detail and zoom it")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 10)
                
                Text(breed.description ?? "")
                    .padding()
                
                Divider()
                
                Text(breed.temperament ?? "")
                    .font(.title3)
                    .bold()
                    .padding()
                    .multilineTextAlignment(.center)
                
                Divider()
                
                VStack(alignment: .center, spacing: 5) {
                    Text("Adaptability: \(breed.adaptability ?? 0)")
                    Text("Affection Level: \(breed.affectionLevel ?? 0)")
                    Text("Child Frienldy: \(breed.childFriendly ?? 0)")
                    Text("Grooming: \(breed.grooming ?? 0)")
                    Text("Intelligence: \(breed.intelligence ?? 0)")
                    Text("Health Issues: \(breed.healthIssues ?? 0)")
                    Text("Social Needs: \(breed.socialNeeds ?? 0)")
                    Text("Stranger Friendly: \(breed.strangerFriendly ?? 0)")
                }
            }
        }
        .navigationTitle(breed.name ?? "")
        .navigationBarItems(
            trailing:
                Link(destination: URL(string: breed.wikipediaUrl ?? "")!, label: {
                    HStack {
                        Text("Wiki")
                        Image(systemName: "globe")
                    }
                })
        )
        .task {
            try? await viewModel.loadImages(for: breed.id ?? "")
        }
    }
}
