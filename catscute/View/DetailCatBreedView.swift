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
    
    var body: some View {
        List(viewModel.images) { image in
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
            .frame(height: 200)
        }
        .navigationTitle(viewModel.breedName)
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
