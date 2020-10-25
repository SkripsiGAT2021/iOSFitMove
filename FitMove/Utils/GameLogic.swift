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

class GameLogic: GameServerWebsocketDelegate {
    let id: UUID = UUID.init()
    var gameState:GameState = .notReady
    var webSocket = GameServerWebsocket.getInstance()
    var gameMechanic:GameMechanics
    init(gameMode: GameMode) {
        gameMechanic = GameMechanicsImpl()
    }
    
    func runGameWithPose(pose:Pose) {
        switch gameState {
            case .notReady:
                notReady(pose)
            case .ready: break
                // Waiting to get Ready Message
            case .started:
                started()
        }
    }
    
    private func notReady(_ pose: Pose) {
        if (ImageProcessor.isAccurate(firstLandmark: pose.landmark(ofType: .leftShoulder),
                       midLandmark: pose.landmark(ofType: .leftElbow),
                       lastLandmark: pose.landmark(ofType: .leftWrist))) {
            let leftElbowAngle = ImageProcessor.angle(
            firstLandmark: pose.landmark(ofType: .leftShoulder),
            midLandmark: pose.landmark(ofType: .leftElbow),
            lastLandmark: pose.landmark(ofType: .leftWrist))
            let leftShoulderAngle = ImageProcessor.angle(
                firstLandmark: pose.landmark(ofType: .leftElbow),
                midLandmark: pose.landmark(ofType: .leftShoulder),
                lastLandmark: pose.landmark(ofType: .rightShoulder))
            if (leftElbowAngle <= 100 && leftShoulderAngle > 90) {
                self.gameState = .ready
                print("ready")
                webSocket.send("READY")
            }
        }
    }
    
    private func started() {
        gameMechanic.start()
        print("recipes")
    }
    
    func didReceiveMessage(_ message: String) {
        if message == "START" {
            gameState = .started
        }
    }
    
    func onDisconnect() {
        print("GAME STOPPED")
    }
    
}
