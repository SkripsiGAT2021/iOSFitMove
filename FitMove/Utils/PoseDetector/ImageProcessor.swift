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

extension ImageProcessor {
    // function to check if the pose correct
    static func checkPose(pose: Pose, wantedPose: GamePose) -> Bool {
        if wantedPose.isAllNil() {
            return true
        }
        if let wantedAngle = wantedPose.leftElbowAngle {
            if !leftElbowAngleChecker(pose: pose, wantedAngle: wantedAngle) {
                return false
            }
        }
        if let wantedAngle = wantedPose.leftShoulderAngle {
            if !leftShoulderAngleChecker(pose: pose, wantedAngle: wantedAngle) {
                return false
            }
        }
        if let wantedAngle = wantedPose.leftKneeAngle {
            if !leftKneeAngleChecker(pose: pose, wantedAngle: wantedAngle) {
                return false
            }
        }
        if let wantedAngle = wantedPose.leftHipAngle {
            if !leftHipAngleChecker(pose: pose, wantedAngle: wantedAngle) {
                return false
            }
        }
        if let wantedAngle = wantedPose.rightElbowAngle {
            if !rightElbowAngleChecker(pose: pose, wantedAngle: wantedAngle) {
                return false
            }
        }
        if let wantedAngle = wantedPose.rightShoulderAngle {
            if !rightShoulderAngleChecker(pose: pose, wantedAngle: wantedAngle) {
                return false
            }
        }
        if let wantedAngle = wantedPose.rightKneeAngle {
            if !rightKneeAngleChecker(pose: pose, wantedAngle: wantedAngle) {
                return false
            }
        }
        if let wantedAngle = wantedPose.rightHipAngle {
            if !rightHipAngleChecker(pose: pose, wantedAngle: wantedAngle) {
                return false
            }
        }
        return true
    }
    
    // MARK: - Function to check Angle Point
    private static func leftElbowAngleChecker(pose:Pose, wantedAngle:Float) -> Bool {
        return checkPoseWithLandmark(firstLandmark: pose.getLeftWrist(), midLandmark: pose.getLeftElbow(), lastLandmark: pose.getLeftShoulder(), wantedAngle: wantedAngle)
    }
    
    private static func leftShoulderAngleChecker(pose:Pose, wantedAngle:Float) -> Bool {
        return checkPoseWithLandmark(firstLandmark: pose.getLeftElbow(), midLandmark: pose.getLeftShoulder(), lastLandmark: pose.getLeftHip(), wantedAngle: wantedAngle)
    }
    
    private static func leftHipAngleChecker(pose:Pose, wantedAngle:Float) -> Bool {
        return checkPoseWithLandmark(firstLandmark: pose.getLeftWrist(), midLandmark: pose.getLeftHip(), lastLandmark: pose.getLeftShoulder(), wantedAngle: wantedAngle)
    }
    
    private static func leftKneeAngleChecker(pose:Pose, wantedAngle:Float) -> Bool {
        return checkPoseWithLandmark(firstLandmark: pose.getLeftWrist(), midLandmark: pose.getLeftKnee(), lastLandmark: pose.getLeftAnkle(), wantedAngle: wantedAngle)
    }
    
    private static func rightElbowAngleChecker(pose:Pose, wantedAngle:Float) -> Bool {
        return checkPoseWithLandmark(firstLandmark: pose.getRightWrist(), midLandmark: pose.getRightElbow(), lastLandmark: pose.getRightShoulder(), wantedAngle: wantedAngle)
    }
    
    private static func rightShoulderAngleChecker(pose:Pose, wantedAngle:Float) -> Bool {
        return checkPoseWithLandmark(firstLandmark: pose.getRightElbow(), midLandmark: pose.getRightShoulder(), lastLandmark: pose.getRightHip(), wantedAngle: wantedAngle)
    }
    
    private static func rightHipAngleChecker(pose:Pose, wantedAngle:Float) -> Bool {
        return checkPoseWithLandmark(firstLandmark: pose.getRightWrist(), midLandmark: pose.getRightHip(), lastLandmark: pose.getRightShoulder(), wantedAngle: wantedAngle)
    }
    
    private static func rightKneeAngleChecker(pose:Pose, wantedAngle:Float) -> Bool {
        return checkPoseWithLandmark(firstLandmark: pose.getRightWrist(), midLandmark: pose.getRightKnee(), lastLandmark: pose.getRightAnkle(), wantedAngle: wantedAngle)
    }
    
    // MARK: - Check Pose With the landmark
    private static func checkPoseWithLandmark(firstLandmark: PoseLandmark,midLandmark: PoseLandmark,lastLandmark: PoseLandmark, wantedAngle:Float) -> Bool {
        if (isAccurate(firstLandmark: firstLandmark, midLandmark: midLandmark, lastLandmark: lastLandmark)) {
            let poseAngle = angle(firstLandmark: firstLandmark, midLandmark: midLandmark, lastLandmark: lastLandmark)
            return CGFloat(wantedAngle + 20) > poseAngle && CGFloat(wantedAngle - 20) < poseAngle
        }
        return false
    }
}

