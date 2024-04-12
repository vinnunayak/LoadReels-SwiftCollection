//
//  FeedViewController.swift
//  design_to_code27
//
//  Created by Dheeraj Kumar Sharma on 15/02/21.
//

import UIKit
import AVKit

class FeedViewController: UIViewController {

    // MARK:- PROPERTIES
    
    var isPlayed: Bool = false
    var gradient : CAGradientLayer?
    
    let gradientView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let videoArr: [FeedDataModel] = [
        FeedDataModel(userImage: "demo3", userName: "dheeraj.iosdev", video: "demo3", caption: "Hi guys! This is my first reel and i want you to check out my design to code series where i try to convert design into code purely in swift using UIKit and i’m sure you will learn alot.", likeCount: "8", messageCount: "0", isVerified: false, isLiked: true, songTitle: "dheeraj.iosdev • Original Audio")
    ]
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        
        // Adds contraints to collectionview cell including safe area.
        cv.contentInsetAdjustmentBehavior = .never
        
        cv.setCollectionViewLayout(layout, animated: false)
        cv.delegate = self
        cv.dataSource = self
        cv.register(FeedDataCollectionViewCell.self, forCellWithReuseIdentifier: "FeedDataCollectionViewCell")
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        return cv
    }()
    
    // MARK:- MAIN
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpViews()
        setUpConstraints()
    }
    
    // MARK:- FUNCTIONS

    func setUpNavBar(){
        navigationItem.title = "Reels"
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setUpViews(){
        view.addSubview(collectionView)
    }
    
    func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
    
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedDataCollectionViewCell", for: indexPath) as! FeedDataCollectionViewCell
        let data = videoArr[indexPath.row]
        cell.data = data
        if let path = Bundle.main.url(forResource: data.video, withExtension: "mp4") {
            cell.addPlayer(for: path, bounds: collectionView.frame)
            if !isPlayed {
                cell.avQueuePlayer?.play()
                isPlayed = true
            }
        }
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        collectionView.visibleCells.forEach { cell in
            // TODO: write logic to stop the video before it begins scrolling
            let cell = cell as! FeedDataCollectionViewCell
            cell.avQueuePlayer?.pause()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionView.visibleCells.forEach { cell in
            // TODO: write logic to start the video after it ends scrolling
            let cell = cell as! FeedDataCollectionViewCell
            cell.avQueuePlayer?.seek(to: CMTime.zero)
            cell.avQueuePlayer?.play()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! FeedDataCollectionViewCell
        cell.avQueuePlayer?.pause()
    }
    
}

extension FeedViewController: feedDataCellDelegate {
    
    func hideWhenLongPressBegan() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func showWhenLongPressEnded() {
        navigationController?.navigationBar.isHidden = false
    }
    
}
