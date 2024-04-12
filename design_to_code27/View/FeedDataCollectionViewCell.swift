//
//  FeedDataCollectionViewCell.swift
//  design_to_code27
//
//  Created by Dheeraj Kumar Sharma on 15/02/21.
//

import UIKit
import AVKit

protocol feedDataCellDelegate {
    func hideWhenLongPressBegan()
    func showWhenLongPressEnded()
}

class FeedDataCollectionViewCell: UICollectionViewCell {
    
    // MARK:- PROPERTIES
    
    var data: FeedDataModel?{
        didSet{
            manageData()
        }
    }
    
    var avQueuePlayer: AVQueuePlayer?
    var avPlayerLayer: AVPlayerLayer?
    var delegate: feedDataCellDelegate?
    
    let playerView: UIView = {
        let pv = UIView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let detailView:FeedDetailView = {
        let v = FeedDetailView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // MARK:- MAIN
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- FUNCTIONS
    
    func setUpViews() {
        addSubview(playerView)
        addSubview(detailView)
        // Adding long press gesture to cell
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        addGestureRecognizer(longTap)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            playerView.topAnchor.constraint(equalTo: playerView.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor),
            
            detailView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: bottomAnchor),
            detailView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func addPlayer(for url: URL , bounds: CGRect) {
        avQueuePlayer = AVQueuePlayer(url: url)
        avPlayerLayer = AVPlayerLayer(player: self.avQueuePlayer!)
        avPlayerLayer?.frame = bounds
        avPlayerLayer?.fillMode = .both
        avPlayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerView.layer.addSublayer(self.avPlayerLayer!)
    }
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer , _ index: IndexPath){
        if gesture.state == .began {
            avQueuePlayer?.pause()
            delegate?.hideWhenLongPressBegan()
            UIView.animate(withDuration: 0.3) {
                self.detailView.alpha = 0
            }
        }
        if gesture.state == .ended {
            avQueuePlayer?.play()
            delegate?.showWhenLongPressEnded()
            UIView.animate(withDuration: 0.3) {
                self.detailView.alpha = 1
            }
        }
    }
    
    func manageData(){
        guard let data = data else {return}
        detailView.profileImage.image = UIImage(named: data.userImage)
        
        let attributedText = NSMutableAttributedString(string:"\(data.userName)  ", attributes:[NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        if data.isVerified {
            let font = UIFont.systemFont(ofSize: 14, weight: .bold)
            let verifiyImg = UIImage(named:"verify")?.withRenderingMode(.alwaysTemplate)
                let verifiedImage = NSTextAttachment()
                verifiedImage.image = verifiyImg?.withTintColor(.white)
                verifiedImage.bounds = CGRect(x: 0, y: (font.capHeight - 13).rounded() / 2, width: 13, height: 13)
                verifiedImage.setImageHeight(height: 13)
                let imgString = NSAttributedString(attachment: verifiedImage)
                attributedText.append(imgString)
        }
        detailView.userName.attributedText = attributedText
        detailView.songMarqueeLabel.text = data.songTitle
        detailView.likeBtn.imageView?.tintColor = data.isLiked ? .white : UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        
        // LikeCount
        let renderedLikeImage = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate).withTintColor(.white)
        detailView.likeCountBtn.setAttributedTitle(detailView.setAttributes(withTitle: data.likeCount, withImage: renderedLikeImage, withTextColor: .white), for: .normal)
        
        // MessageCount
        let renderedMessageImage = UIImage(named: "message")?.withRenderingMode(.alwaysTemplate).withTintColor(.white)
        detailView.commentCountBtn.setAttributedTitle(detailView.setAttributes(withTitle: data.messageCount, withImage: renderedMessageImage, withTextColor: .white), for: .normal)
    }
    
}
