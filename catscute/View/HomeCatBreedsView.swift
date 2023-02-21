//
//  HomeCatBreedsView.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import SwiftUI

struct HomeCatBreedsView: View {
    @StateObject private var viewModel = HomeCatBreedsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.breeds) { breed in
                NavigationLink(destination: DetailCatBreedView(breedId: breed.id ?? "")) {
                    Text(breed.name ?? "")
                }
            }
            .navigationTitle("Cat Breeds")
        }
        .task {
            try? await viewModel.loadBreeds()
        }
    }
}

struct HomeCatBreedsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCatBreedsView()
    }
}
