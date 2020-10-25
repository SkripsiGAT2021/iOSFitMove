//
//  GamePose.swift
//  FitMove
//
//  Created by Peter Andrew on 24/10/20.
//

import Foundation
import MLKitPoseDetection

struct GamePose: Codable {
    var leftShoulderAngle:Float?
    var leftElbowAngle:Float?
    var leftHipAngle:Float?
    var leftKneeAngle:Float?
    var rightShoulderAngle:Float?
    var rightElbowAngle:Float?
    var rightHipAngle:Float?
    var rightKneeAngle:Float?
    func isAllNil() -> Bool {
        return leftHipAngle != nil && leftElbowAngle != nil && leftHipAngle != nil && leftKneeAngle != nil && rightHipAngle != nil && rightElbowAngle != nil && rightHipAngle != nil && rightKneeAngle != nil 
    }
}

