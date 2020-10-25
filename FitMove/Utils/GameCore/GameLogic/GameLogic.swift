//
//  GameLogic.swift
//  FitMove
//
//  Created by Peter Andrew on 12/10/20.
//

import Foundation
import MLKitPoseDetection

enum GameState {
    case notReady
    case ready
    case started
}

enum GameMode {
    case normal
    case mirror
}

class GameLogic {
    
    var gameState:GameState = .notReady
    var webSocket = GameServerWebsocket.getInstance()
    var gameMechanic:GamePlay
    init(gameMode: GameMode) {
        gameMechanic = GamePlayMirror()
    }
    
    func runGameWithPose(pose:Pose) {
        switch gameState {
            case .notReady:
                notReady(pose)
            case .ready: break
                // Waiting to get Ready Message
            case .started:
                started(pose)
        }
    }
    
    private func notReady(_ pose: Pose) {
        let readyPose = GamePose(leftShoulderAngle: 90, leftElbowAngle: 90, leftHipAngle: nil, leftKneeAngle: nil, rightShoulderAngle: nil, rightElbowAngle: nil, rightHipAngle: nil, rightKneeAngle: nil)
        if ImageProcessor.checkPose(pose: pose, wantedPose: readyPose) {
            print("\n\nndetected\n\n"); // READY
            
        }
    }
    
    private func started(_ pose:Pose) {
        
    }
    
    private func readyGame() {

    }
}
