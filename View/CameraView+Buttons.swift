//
//  CameraView+Buttons.swift
//  BasicCamera
//
//  Created by Terrance Griffith on 1/27/26.
//
import SwiftUI

extension CameraView {
    var retakeButton: some View {
        ControlButtonView(label: "Retake") {
            // Retake the photo
            cameraViewModel.retakePhoto()
        }
    }
    
    var usePhotoButton: some View {
        ControlButtonView(label: "Use Photo") {
            // Use the photo that was taken
            imageData = cameraViewModel.photoData
            showCamera = false
        }
    }
    
    var cancelButton: some View {
        ControlButtonView(label: "Cancel") {
            showCamera = false
        }
    }
    
    var photoCaptureButton: some View {
        Button {
            // Take Photo
            cameraViewModel.takePhoto()
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 65)
                Circle()
                    .stroke(.white, lineWidth: 3)
                    .frame(width: 75)
            }
        }
        
    }
}
