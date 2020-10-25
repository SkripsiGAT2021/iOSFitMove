//
//  GameCoreMechanics.swift
//  FitMove
//
//  Created by Peter Andrew on 12/10/20.
//

import Foundation
import MLKit

class GameCoreMechanic {
    let websocket = GameServerWebsocket.getInstance()
    private var poses:[GamePose] = []
    var currentPoses:GamePose?
    
    func setGamePoses(posed:[GamePose]) {
        self.poses = posed
    }
    
    func nextPose() -> GamePose {
        return poses.removeFirst()
    }
    
    func isNoPosesLeft() -> Bool {
        return poses.count < 1
    }
    
    func getCurrentPoses() -> GamePose {
        if let current = currentPoses {
            return current
        } else {
            currentPoses = nextPose()
            return getCurrentPoses()
        }
    }
}


 
