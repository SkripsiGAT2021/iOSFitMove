//
//  GamePlayMirror.swift
//  FitMove
//
//  Created by Peter Andrew on 25/10/20.
//

import Foundation
import MLKit

class GamePlayMirror: GameCoreMechanic, GamePlay {
    func onGamePlay(pose: Pose) {
        // IF Message from server start game, init timer
        if ImageProcessor.checkPose(pose: pose, wantedPose: getCurrentPoses()) {
            pushCorrectToServer()
            deactiveTimer()
            if isNoPosesLeft() {
                pushDoneToServer()
                deactiveTimer()
            } else {
                timerStart()
                currentPoses = nil
            }
        }
        
    }
    
    private func pushCorrectToServer() {
        // Websokcet.push correct
    }
    
    private func pushDoneToServer() {
        // Websocket push done server
    }
    
    func reInit() {
        
    }
    
    func timerStart() {
        
    }
    
    func settingTimer() {
        
    }
    
    func deactiveTimer() {
        
    }
    
}
