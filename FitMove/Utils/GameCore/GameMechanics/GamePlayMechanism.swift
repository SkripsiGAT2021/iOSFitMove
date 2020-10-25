//
//  GamePlayMechanism.swift
//  FitMove
//
//  Created by Peter Andrew on 25/10/20.
//

import Foundation
import MLKit

@objc protocol GamePlay {
    func onGamePlay(pose: Pose)
    func settingTimer()->Timer
    func timerStart()
    func deactiveTimer()
    @objc func onTimerEnd()
}
