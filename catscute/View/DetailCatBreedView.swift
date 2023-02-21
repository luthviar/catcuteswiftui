//
//  DetailCatBreedView.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import SwiftUI

struct DetailCatBreedView: View {
    let breedId: String
    @StateObject private var viewModel = DetailCatBreedViewModel()
    
    var arrayImageUrl: [CatImage] {
        get {
            return viewModel.images
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(viewModel.images.prefix(10), id: \.id) { image in
                            AsyncImage(url: URL(string: image.url ?? "")) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable().scaledToFit()
                                case .failure:
                                    Image(systemName: "exclamationmark.icloud.fill")
                                @unknown default:
                                    fatalError()
                                }
                            }
                            .frame(width: 200, height: 200)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .task {
            try? await viewModel.loadImages(for: breedId)
        }
    }
}

struct DetailCatBreedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCatBreedView(breedId: "abys")
    }
}
