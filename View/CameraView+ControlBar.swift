//
//  CameraView+ControlBar.swift
//  BasicCamera
//
//  Created by Terrance Griffith on 1/27/26.
//
import SwiftUI

extension CameraView {
    
    var horizontalControlBar: some View {
        horizontalControlBarPrePhoto
//        horizontalControlBarPostPhoto
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
    
    var verticalControlBar: some View {
        verticalControlBarPrePhoto
//        verticalControlBarPostPhoto
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
