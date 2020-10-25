//
//  GamePoseDetector.swift
//  FitMove
//
//  Created by Peter Andrew on 11/10/20.
//

import Foundation
import MLKitPoseDetection
import MLKitVision

class GamePoseDetector {
    private static var poseDetector:PoseDetector?
    private static func setPoseDetector() {
        GamePoseDetector.poseDetector =  setPoseDetectorOptions(PoseDetectorOptions())
    }
    
    private static func setPoseDetectorOptions(_ options:PoseDetectorOptions)->PoseDetector {
        options.detectorMode = .stream
        return PoseDetector.poseDetector(options: options)
    }
    
    private static func makeSurePoseDetectorAvail() {
        if GamePoseDetector.poseDetector == nil {
            GamePoseDetector.setPoseDetector()
        }
    }
    
    static func detectPose(image:VisionImage) -> [Pose]? {
        GamePoseDetector.makeSurePoseDetectorAvail()
        image.orientation = ImageProcessor.imageOrientation(
          deviceOrientation: UIDevice.current.orientation,
          cameraPosition: .front)
        var results: [Pose]?
        do {
            results = try GamePoseDetector.poseDetector!.results(in: image)
        } catch let error {
          print("Failed to detect pose with error: \(error.localizedDescription).")
          return nil
        }
        guard let detectedPoses = results, !detectedPoses.isEmpty else {
          print("Pose detector returned no results.")
          return nil
        }
        return results
    }
}

