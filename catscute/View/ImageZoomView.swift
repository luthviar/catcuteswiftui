//
//  ImageZoomView.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import SwiftUI

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
    }
}
