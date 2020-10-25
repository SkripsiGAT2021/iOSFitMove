//
//  GamePlayMechanism.swift
//  FitMove
//
//  Created by Peter Andrew on 25/10/20.
//

import Foundation
import MLKit

protocol GamePlay {
    func onGamePlay(pose: Pose)
    func settingTimer()
    func timerStart()
    func deactiveTimer()
}
