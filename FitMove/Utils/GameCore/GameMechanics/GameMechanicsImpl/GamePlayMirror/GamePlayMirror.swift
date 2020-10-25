//
//  GamePlayMirror.swift
//  FitMove
//
//  Created by Peter Andrew on 25/10/20.
//

import Foundation
import MLKit

class GamePlayMirror: GameCoreMechanic, GamePlay {
    let id:UUID = UUID.init()

    func onGamePlay(pose: Pose) {
        if ImageProcessor.checkPose(pose: pose, wantedPose: getCurrentPoses()) {
            pushCorrectToServer()
            deactiveTimer()
            if isNoPosesLeft() {
                pushDoneToServer()
            } else {
                timerStart()
                currentPoses = nil
            }
        }
        
    }
    
    private func pushCorrectToServer() {
        // Websokcet.push correct
        // websocket.send("")
    }
    
    private func pushDoneToServer() {
        // Websocket push done server
    }
    
    func timerStart() {
        guard timer == nil else { return }
        timer = settingTimer()
    }
    
    @objc func onTimerEnd() {
        print("Time Condition")
    }
    
    func settingTimer() -> Timer {
        return Timer.scheduledTimer(
            timeInterval: TimeInterval(3.0),
            target: self,
            selector: #selector(self.onTimerEnd),
            userInfo: nil,
            repeats: true)
    }
    
    func deactiveTimer() {
        timer?.invalidate()
        timer = nil
    }
}
