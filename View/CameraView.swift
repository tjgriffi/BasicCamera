//
//  CameraView.swift
//  BasicCamera
//
//  Created by Terrance Griffith on 1/24/26.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @Binding var imageData: Data?
    @Binding var showCamera: Bool
    
    let controlButtonWidth: CGFloat = 120
    let controlBarFrameHeight: CGFloat = 90
    
    var isLandscape: Bool { verticalSizeClass == .compact }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
                
            if !isLandscape {
                VStack {
                    cameraPreview
                    horizontalControlBar
                        .frame(height: controlBarFrameHeight)
                }
            } else {
                HStack {
                    cameraPreview
                    verticalControlBar
                        .frame(width: controlBarFrameHeight)
                }
            }
        }
    }
    
    private var cameraPreview: some View {
        Color.yellow
            .ignoresSafeArea()
    }
    
}

#Preview {
    CameraView(imageData: .constant(nil), showCamera: .constant(true))
}
