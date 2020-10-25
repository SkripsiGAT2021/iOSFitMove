//
//  Pose+PointMechanism.swift
//  FitMove
//
//  Created by Peter Andrew on 24/10/20.
//

import Foundation
import MLKitPoseDetection

extension Pose {
    func getLeftWrist() -> PoseLandmark {
        return self.landmark(ofType: .leftWrist)
    }
    
    func getLeftAnkle() -> PoseLandmark {
        return self.landmark(ofType: .leftAnkle)
    }
    
    func getLeftShoulder() -> PoseLandmark {
        return self.landmark(ofType: .leftShoulder)
    }
    
    func getLeftElbow() -> PoseLandmark {
        return self.landmark(ofType: .leftElbow)
    }
    
    func getLeftHip() -> PoseLandmark {
        return self.landmark(ofType: .leftHip)
    }
    
    func getLeftKnee() -> PoseLandmark {
        return self.landmark(ofType: .leftKnee)
    }
    
    func getRightWrist() -> PoseLandmark {
        return self.landmark(ofType: .rightWrist)
    }
    
    func getRightAnkle() -> PoseLandmark {
        return self.landmark(ofType: .rightAnkle)
    }
    
    func getRightShoulder() -> PoseLandmark {
        return self.landmark(ofType: .rightShoulder)
    }
    
    func getRightElbow() -> PoseLandmark {
        return self.landmark(ofType: .rightElbow)
    }
    
    func getRightHip() -> PoseLandmark {
        return self.landmark(ofType: .rightHip)
    }
    
    func getRightKnee() -> PoseLandmark {
        return self.landmark(ofType: .rightKnee)
    }
}
