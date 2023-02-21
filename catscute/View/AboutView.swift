//
//  AboutView.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image("luthfiprofilepicture")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: 150,
                        height: 150
                    )
                    .clipShape(Circle())
                
                Text("Luthfi Abdur Rahim")
                    .font(.title)
                
                Text("luthfi.abdurrahim.2014@alumni.ui.ac.id")
                                
                Spacer(minLength: 30)
                
                Button(action: {
                    if let url = URL(string: "https://www.linkedin.com/in/luthfi-ar") {
                       UIApplication.shared.open(url)
                    }
                }) {
                    Text("My Linkedin").font(.title2)
                }
                
                Spacer(minLength: 30)
                
                Text("This is the app for showing all cat breeds in the world. I hope it will fun and add to your new knowledge. Thank you.")
            }
            .padding()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
