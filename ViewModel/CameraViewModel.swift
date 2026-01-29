//
//  CameraViewModel.swift
//  BasicCamera
//
//  Created by Terrance Griffith on 1/28/26.
//

import Foundation
import AVFoundation
import UIKit
import SwiftUI

@Observable
class CameraViewModel: NSObject {
    
    enum PhotoCaptureState {
        case idle
        case processing
        case finished(Data)
    }
    
    var session = AVCaptureSession()
    var preview = AVCaptureVideoPreviewLayer()
    var output = AVCapturePhotoOutput()
    
    var photoData: Data? {
        if case .finished(let data) = photoCaptureState {
            return data
        }
        
        return nil
    }
    
    var hasPhoto: Bool {
        photoData != nil
    }
    
    var photoCaptureState: PhotoCaptureState = .idle
    
    func requestAccess() {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { didAllowAccess in
                self.setup()
            }
        case .authorized:
            setup()
        default:
            print("Other status: \(AVCaptureDevice.authorizationStatus(for: .video))")
        }
    }
    
    private func setup() {
        
        session.beginConfiguration()
        session.sessionPreset = .photo
        
        do {
            guard let device = AVCaptureDevice.default(for: .video) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input) else { return }
            session.addInput(input)
            
            guard session.canAddOutput(output) else { return }
            session.addOutput(output)
                    
            session.commitConfiguration()
            
            Task.detached {
                print("detachedTask setup Thread.isMainThread:\(Thread.isMainThread)")
                await self.session.startRunning()
                
                await MainActor.run {
                    print("detachedTask MainActor setup Thread.isMainThread:\(Thread.isMainThread)")
                    self.preview.connection?.videoRotationAngle = UIDevice.current.orientation.videoRotationAngle
                }
            }
        } catch {
            print("error")
        }
    }
    
    func takePhoto() {
        // Make sure we havent taken a photo yet
        guard case .idle = photoCaptureState else { return }
        
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        withAnimation {
            self.photoCaptureState = .processing
        }
    }
    
    func retakePhoto() {
        Task.detached {
            print("detachedTask retakePhoto Thread.isMainThread:\(Thread.isMainThread)")
            await self.session.startRunning()
            
            await MainActor.run {
                print("detachedTask MainActor retakePhoto Thread.isMainThread:\(Thread.isMainThread)")
                self.photoCaptureState = .idle
            }
        }
    }
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let error {
            print(error.localizedDescription)
        }
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
//        guard let cgDataProvider = CGDataProvider(data: imageData as CFData) else { return }
//        guard let cgImage = CGImage(pngDataProviderSource: cgDataProvider, decode: nil, shouldInterpolate: true, intent: .defaultIntent) else { return }
         
        Task.detached {
            print("detachedTask photoOutput Thread.isMainThread:\(Thread.isMainThread)")
            await self.session.stopRunning()
            
            await MainActor.run {
                print("detachedTask MainActor photoOutput Thread.isMainThread:\(Thread.isMainThread)")
//                let image = UIImage(cgImage: cgImage, scale: 1, orientation: UIDevice.current.orientation.uiImageOrientation)
//                let imageData = image.pngData()
                
                withAnimation {
                    self.photoCaptureState = .finished(imageData)
//                    if let imageData {
//                        self.photoCaptureState = .finished(imageData)
//                    } else {
//                        print("Error with data conversion")
//                    }
                }
            }
        }
    }
}
