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
                NavigationLink(
                    destination: DetailCatBreedView(breed: breed)
                ) {
                    HStack {
                        AsyncImage(url: URL(string: breed.imageUrl ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(
                                        width: 80,
                                        height: 80
                                    )
                                    .cornerRadius(8)
                                    .scaledToFit()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: 80,
                                        height: 80
                                    )
                                    .background(Color.black)
                                    .cornerRadius(20)
                                    .padding(.trailing, 4)
                            case .failure:
                                Image(systemName: "exclamationmark.icloud.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: 80,
                                        height: 80
                                    )
                                    .background(Color.black)
                                    .cornerRadius(20)
                                    .padding(.trailing, 4)
                            @unknown default:
                                fatalError()
                            }
                        }
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(breed.name ?? "")
                                .font(.system(size: 25, weight: .bold))
                            
                            Text(breed.description ?? "")
                                .lineLimit(2)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Cat Breeds")
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Text("About Me")
                            Image(systemName: "info.circle")
                        }
                    }
            )
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
