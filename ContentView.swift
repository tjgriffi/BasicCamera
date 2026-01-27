//
//  ContentView.swift
//  BasicCamera
//
//  Created by Terrance Griffith on 1/24/26.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var imageData: Data? = nil
    @State private var showCamera = false
    
    var body: some View {
        VStack {
            if let imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
            Button {
                showCamera = true
            } label: {
                Rectangle()
                    .overlay {
                        Text("Take Photo")
                            .foregroundStyle(.white)
                    }
                    .cornerRadius(8)
                    .frame(width: 100, height: 40)
                    .shadow(radius: 8)
            }

        }
        .padding()
        .fullScreenCamera(isPresented: $showCamera, imageData: $imageData)
    }
}

#Preview {
    ContentView()
}

extension View {
    func fullScreenCamera(isPresented: Binding<Bool>, imageData: Binding<Data?>) -> some View {
        self.fullScreenCover(isPresented: isPresented) {
            CameraView(imageData: imageData, showCamera: isPresented)
        }
    }
}
