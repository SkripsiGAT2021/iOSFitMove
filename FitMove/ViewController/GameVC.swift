//
//  ViewController.swift
//  FitMove
//
//  Created by Peter Andrew on 10/10/20.
//

import UIKit
import AVFoundation
import MLKitVision




class GameVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    // UI variable
    @IBOutlet weak var cameraView: UIView!
    
    // data variable
    var videoUtils:VideoUtils!
    var counter = 0;
//    var gameState:GameState = .notReady
    var image:VisionImage?
    var game:GameLogic?
    override func viewDidLoad() {
        super.viewDidLoad()
        setVideoStream()
        game = GameLogic(gameMode: .normal)
    }
    func setVideoStream() {
        videoUtils = VideoUtils(self)
        videoUtils.setVideoViewSubLayer(cameraView)
        videoUtils.startSession()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // pass your sampleBuffer to vision API
        // I recommend not to pass every frame however, skip some frames until camera is steady and focused
        if counter > 8 {
            let detectedPoses = GamePoseDetector.detectPose(image:  VisionImage(buffer: sampleBuffer))
            if let poses = detectedPoses {
                poses.forEach{ pose in
                    // GAME LOGIC By Passing pose
                    game!.runGameWithPose(pose: pose)
                }
            }
            counter = 0
        }
        counter+=1
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        videoUtils.stopSession()
    }
    
}


