//
//  CameraPreview.swift
//  BasicCamera
//
//  Created by Terrance Griffith on 1/28/26.
//

import AVFoundation
import Foundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    
    @Binding var cameraViewModel: CameraViewModel
    let frame: CGRect
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        cameraViewModel.preview.frame = frame
        cameraViewModel.preview.connection?.videoRotationAngle = UIDevice.current.orientation.videoRotationAngle
    }
    
    
    func makeUIView(context: Context) -> UIView {
        let view = UIViewType(frame: frame)
        cameraViewModel.preview = AVCaptureVideoPreviewLayer(session: cameraViewModel.session)
        cameraViewModel.preview.frame = frame
        cameraViewModel.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(cameraViewModel.preview)
        
        return view
    }
    
}
