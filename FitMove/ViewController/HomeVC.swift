//
//  HomeVC.swift
//  FitMove
//
//  Created by Peter Andrew on 14/10/20.
//

import UIKit
import youtube_ios_player_helper

class HomeVC: UIViewController {

    @IBOutlet weak var youtubeViewer: YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        youtubeViewer.load(withVideoId: "HSOtku1j600")
        youtubeViewer.delegate = self
    }

}

extension HomeVC: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.black
    }
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let customLoadingView = UIView()
        return customLoadingView
    }
}

// Exception    NSException *    "Your app is missing support for the following URL schemes: "    0x000060000361db00
