//
//  VideoUtils.swift
//  FitMove
//
//  Created by Peter Andrew on 11/10/20.
//

import Foundation
import UIKit
import AVFoundation

class VideoUtils {
    
    var session = AVCaptureSession()
    init(_ delegate:AVCaptureVideoDataOutputSampleBufferDelegate) {
        if let input = self.createVideoInput(AVCaptureDevice.default(.builtInTrueDepthCamera, for: .video, position: .front)!) {
            if session.canAddInput(input) {
                session.addInput(input)
            }
        }
        
        let videoOutput = settingVideoOutput(AVCaptureVideoDataOutput())
        videoOutput.setSampleBufferDelegate(delegate, queue: DispatchQueue(label: "video-frame"))
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            if let connection = videoOutput.connection(with: .video) {
                connection.videoOrientation = videoOrientationFromInterfaceOrientation()
                if connection.isVideoStabilizationSupported {
                    connection.preferredVideoStabilizationMode = .auto
                }
            }
        }
    }
    
    private func createVideoInput(_ device:AVCaptureDevice) -> AVCaptureDeviceInput? {
        do{
            return try AVCaptureDeviceInput(device: device)
        }
        catch{
            return nil
        }
    }
    
    private func settingVideoOutput(_ videoOutput: AVCaptureVideoDataOutput) -> AVCaptureVideoDataOutput {
        videoOutput.videoSettings = [
            String(kCVPixelBufferPixelFormatTypeKey): NSNumber(value: kCVPixelFormatType_32BGRA)
        ]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        return videoOutput
    }
    
    
    private func videoOrientationFromInterfaceOrientation() -> AVCaptureVideoOrientation {
        return AVCaptureVideoOrientation(rawValue: UIApplication.shared.windows.first!.windowScene!.interfaceOrientation.rawValue)!
    }
    
    func startSession() {
        session.startRunning()
    }
    
    func stopSession() {
        session.stopRunning()
    }
    
    func setVideoViewSubLayer(_ view:UIView) {
        let videoLayer = AVCaptureVideoPreviewLayer(session: session)
        videoLayer.frame.size = view.frame.size
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(videoLayer)
    }
}
