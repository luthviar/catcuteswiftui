//
//  DetailCatBreedView.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import SwiftUI

struct DetailCatBreedView: View {
    let breedId: String
    let breedName: String
    
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
                }
                
            }
        }
        .navigationTitle(breedName)
        .task {
            try? await viewModel.loadImages(for: breedId)
        }
    }
}

struct DetailCatBreedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCatBreedView(breedId: "abys", breedName: "abbb")
    }
}
