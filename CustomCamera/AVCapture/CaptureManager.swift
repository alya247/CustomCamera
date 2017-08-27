//
//  CaptureManager.swift
//  CustomCamera
//
//  Created by Alya Filon on 27.08.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CaptureManager: NSObject {
    
    enum Result {
        case success(image: UIImage)
        case failure(errorMessage: String)
        case cancel
    }
    
    var session: AVCaptureSession?
    var deviceInput: AVCaptureDeviceInput?
    var photoOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    typealias Completion = (_ result: Result) -> Void
    fileprivate var completion: Completion?
    
    func configureSession(withView view: UIView) {
        
        session = AVCaptureSession()
        photoOutput = AVCapturePhotoOutput()
        
        let camera = getDevice(position: .back)
        do {
            deviceInput = try AVCaptureDeviceInput(device: camera)
        } catch let error {
            print(error)
            deviceInput = nil
        }
        
        if (session?.canAddInput(deviceInput) ?? false) {
            session?.addInput(deviceInput)
            if (session?.canAddOutput(photoOutput) ?? false) {
                session?.addOutput(photoOutput)
                previewLayer = AVCaptureVideoPreviewLayer(session: session)
                previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                previewLayer?.connection.videoOrientation = .portrait
                previewLayer?.frame = view.bounds
                view.layer.addSublayer(previewLayer!)
                session?.startRunning()
            }
        }
    }
    
    func getDevice(position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        
        if let device = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: position) {
            return device
        }
        return nil
    }
    
    func takePhoto(completion: @escaping Completion) {
        
        self.completion = completion
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160,
                             ]
        settings.previewPhotoFormat = previewFormat
        
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    func rotateCamera() {
        
        guard session != nil else {
            return
        }
        session?.stopRunning()
        
        let camera: AVCaptureDevice?
        if deviceInput?.device.position == .back {
            camera = getDevice(position: .front)
        } else {
            camera = getDevice(position: .back)
        }
        
        session?.removeInput(deviceInput)
        
        do {
            deviceInput = try AVCaptureDeviceInput(device: camera)
        } catch let error {
            print(error)
            deviceInput = nil
        }
        
        if (session?.canAddInput(deviceInput) ?? false) {
            session?.addInput(deviceInput)
            session?.startRunning()
        }
    }
}

extension CaptureManager: AVCapturePhotoCaptureDelegate {
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            completion?(.failure(errorMessage: error.localizedDescription))
            completion = nil
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer,
            let previewBuffer = previewPhotoSampleBuffer,
            let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            
            if let chosenImage = UIImage(data: dataImage) {
                UIImageWriteToSavedPhotosAlbum(chosenImage, self, nil, nil)
                completion?(.success(image: chosenImage))
                completion = nil
            } else {
                completion?(.cancel)
                completion = nil
            }
        }
    }
}
