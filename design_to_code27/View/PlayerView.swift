//
//  PlayerView.swift
//  design_to_code27
//
//  Created by Dheeraj Kumar Sharma on 16/02/21.
//

import UIKit
import AVKit

class PlayerView: UIView {

    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
    
        set {
            playerLayer.player = newValue
        }
    }
}
