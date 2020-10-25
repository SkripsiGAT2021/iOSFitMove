//
//  DummyViewController.swift
//  FitMove
//
//  Created by Peter Andrew on 11/10/20.
//

import UIKit

class DummyViewController: UIViewController {
    
    var timerDone = 0
    var timerTest : Timer?
    var state = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickButton(_ sender: Any) {
        print("clicked")
        if state {
            stopTimerTest()
        } else {
            state = true
            startTimer()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    @IBAction func unwind( _ seg: UIStoryboardSegue) {

    }
    
    func startTimer () {
      guard timerTest == nil else { return }
        
      timerTest =  Timer.scheduledTimer(
        timeInterval: TimeInterval(3.0),
          target      : self,
            selector    : #selector(DummyViewController.timerActionTest),
          userInfo    : nil,
          repeats     : true)
    }
    
    @objc func timerActionTest() {
        timerDone += 1
        print(" timer condition \(timerDone)")
    }
    
    func stopTimerTest() {
      timerTest?.invalidate()
      timerTest = nil
        state = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
