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
        VStack {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.images.prefix(10), id: \.id) { image in
                            AsyncImage(url: URL(string: image.url ?? "")) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(
                                            width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 20 / 100),
                                            height: 160
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
                                                height: 160
                                            )
                                            .cornerRadius(8)
                                    }
                                case .failure:
                                    Image(systemName: "exclamationmark.icloud.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(
                                            width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 20 / 100),
                                            height: 160
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
        .task {
            try? await viewModel.loadImages(for: breedId)
        }
    }
}

struct ImageZoomView: View {
    @State private var zoomScale: CGFloat = 1.0
    @State private var currentDrag: CGSize = .zero
    @State private var previousDrag: CGSize = .zero
    
    var image: Image
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center) {
                Spacer()
                image
                    .resizable()
                    .scaledToFit()
                    .offset(x: currentDrag.width + previousDrag.width, y: currentDrag.height + previousDrag.height)
                    .scaleEffect(zoomScale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { scale in
                                withAnimation {
                                    zoomScale = scale.magnitude
                                }
                            }
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation {
                                    currentDrag = CGSize(width: value.translation.width / zoomScale, height: value.translation.height / zoomScale)
                                }
                            }
                            .onEnded { value in
                                withAnimation {
                                    previousDrag = CGSize(width: previousDrag.width + value.translation.width / zoomScale, height: previousDrag.height + value.translation.height / zoomScale)
                                    currentDrag = .zero
                                }
                            }
                    )
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .navigationTitle("Zoomed Image")
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
}

struct DetailCatBreedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCatBreedView(breedId: "abys")
    }
}
