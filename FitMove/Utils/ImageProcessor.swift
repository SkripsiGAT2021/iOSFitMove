//
//  ImageProcessor.swift
//  PoseDetectionApp
//
//  Created by Peter Andrew on 10/10/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MLKitPoseDetection

class ImageProcessor{
    static func imageOrientation(
      deviceOrientation: UIDeviceOrientation,
      cameraPosition: AVCaptureDevice.Position
    ) -> UIImage.Orientation {
      switch deviceOrientation {
      case .portrait:
        return cameraPosition == .front ? .leftMirrored : .right
      case .landscapeLeft:
        return cameraPosition == .front ? .downMirrored : .up
      case .portraitUpsideDown:
        return cameraPosition == .front ? .rightMirrored : .left
      case .landscapeRight:
        return cameraPosition == .front ? .upMirrored : .down
      case .faceDown, .faceUp, .unknown:
        return .up
      @unknown default:
        return .down
      }
    }
    
    static func angle(
        firstLandmark: PoseLandmark,
          midLandmark: PoseLandmark,
          lastLandmark: PoseLandmark
      ) -> CGFloat {
          let radians: CGFloat =
              atan2(lastLandmark.position.y - midLandmark.position.y,
                        lastLandmark.position.x - midLandmark.position.x) -
                atan2(firstLandmark.position.y - midLandmark.position.y,
                        firstLandmark.position.x - midLandmark.position.x)
          var degrees = radians * 180.0 / .pi
          degrees = abs(degrees) // Angle should never be negative
          if degrees > 180.0 {
              degrees = 360.0 - degrees // Always get the acute representation of the angle
          }
          return degrees
      }
    
    static func isAccurate(
          firstLandmark: PoseLandmark,
          midLandmark: PoseLandmark,
          lastLandmark: PoseLandmark
    ) -> Bool {
        return firstLandmark.inFrameLikelihood > 0.5 && midLandmark.inFrameLikelihood > 0.5 && lastLandmark.inFrameLikelihood > 0.5
    }
}
