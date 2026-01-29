//
//  CameraView+ControlBar.swift
//  BasicCamera
//
//  Created by Terrance Griffith on 1/27/26.
//
import SwiftUI

extension CameraView {
    
    @ViewBuilder
    var horizontalControlBar: some View {
        if cameraViewModel.hasPhoto {
            horizontalControlBarPostPhoto
        } else {
            horizontalControlBarPrePhoto
        }
    }
    
    var horizontalControlBarPrePhoto: some View {
        HStack {
            cancelButton
                .frame(width: controlButtonWidth)
            Spacer()
            photoCaptureButton
            Spacer()
            Spacer()
                .frame(width: controlButtonWidth)
        }
    }
    
    var horizontalControlBarPostPhoto: some View {
        HStack {
            retakeButton
                .frame(width: controlButtonWidth)
            Spacer()
            usePhotoButton
                .frame(width: controlButtonWidth)
        }
    }
    
    @ViewBuilder
    var verticalControlBar: some View {
        if cameraViewModel.hasPhoto {
            verticalControlBarPostPhoto
        } else {
            verticalControlBarPrePhoto
        }
    }
    
    var verticalControlBarPrePhoto: some View {
        VStack {
            Spacer()
                .frame(height: controlButtonWidth)
            Spacer()
            photoCaptureButton
            Spacer()
            cancelButton
                .frame(height: controlButtonWidth)
        }
    }
    
    var verticalControlBarPostPhoto: some View {
        VStack(alignment: .center) {
            usePhotoButton
                .frame(height: controlButtonWidth)
            Spacer()
            retakeButton
                .frame(height: controlButtonWidth)
        }
    }
}
