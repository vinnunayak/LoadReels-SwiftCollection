//
//  FeedDetailView.swift
//  design_to_code27
//
//  Created by Dheeraj Kumar Sharma on 16/02/21.
//

import UIKit
import MarqueeLabel
import Lottie

class FeedDetailView: UIView {

    // MARK:- PROPERTIES
    
    var topColor: UIColor = UIColor.clear 
    var bottomColor: UIColor = UIColor.black.withAlphaComponent(0.8)
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    let likeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints  = false
        let renderedImage = UIImage(named:"like")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(renderedImage, for: .normal)
        btn.imageView?.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        return btn
    }()
    
    let commentBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints  = false
        let renderedImage = UIImage(named:"message")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(renderedImage, for: .normal)
        btn.imageView?.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        return btn
    }()
    
    let shareBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints  = false
        let renderedImage = UIImage(named:"share")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(renderedImage, for: .normal)
        btn.imageView?.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        return btn
    }()
    
    let moreBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let renderedImage = UIImage(named:"more")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(renderedImage, for: .normal)
        btn.imageView?.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        return btn
    }()
    
    let countView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var likeCountBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var commentCountBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var equalizerView: AnimationView = {
        let v = AnimationView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.animation = Animation.named("equaliser")
        v.loopMode = LottieLoopMode.loop
        v.play()
        return v
    }()
    
    let songMarqueeLabel: MarqueeLabel = {
        let l = MarqueeLabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: .footnote)
        l.type = .continuous
        l.animationCurve = .linear
        l.fadeLength = 10.0
        l.leadingBuffer = 0.0
        l.trailingBuffer = 15.0
        return l
    }()
    
    let captionLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: .footnote)
        l.text = "When the car is hot 😱 😂"
        return l
    }()
    
    let profileView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .white
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        return img
    }()
    
    let userName:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
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
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
    }
    
    // MARK:- FUNCTIONS
    
    func setUpViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(likeBtn)
        stackView.addArrangedSubview(commentBtn)
        stackView.addArrangedSubview(shareBtn)
        stackView.addArrangedSubview(moreBtn)
        addSubview(countView)
        countView.addSubview(commentCountBtn)
        countView.addSubview(likeCountBtn)
        addSubview(equalizerView)
        addSubview(songMarqueeLabel)
        addSubview(captionLabel)
        addSubview(profileView)
        profileView.addSubview(profileImage)
        profileView.addSubview(userName)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 35),
            stackView.widthAnchor.constraint(equalToConstant: 164),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            countView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            countView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            countView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            countView.heightAnchor.constraint(equalToConstant: 35),
            
            commentCountBtn.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            commentCountBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            likeCountBtn.trailingAnchor.constraint(equalTo: commentCountBtn.leadingAnchor, constant: -15),
            likeCountBtn.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            
            equalizerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            equalizerView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -6),
            equalizerView.widthAnchor.constraint(equalToConstant: 35),
            equalizerView.heightAnchor.constraint(equalToConstant: 35),
            
            songMarqueeLabel.leadingAnchor.constraint(equalTo: equalizerView.trailingAnchor, constant: -5),
            songMarqueeLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -15),
            songMarqueeLabel.widthAnchor.constraint(equalToConstant: 180),
            
            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            captionLabel.bottomAnchor.constraint(equalTo: songMarqueeLabel.topAnchor, constant: -10),
            captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            profileView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            profileView.bottomAnchor.constraint(equalTo: captionLabel.topAnchor, constant: -10),
            profileView.heightAnchor.constraint(equalToConstant: 35),
            
            profileImage.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            profileImage.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 30),
            profileImage.heightAnchor.constraint(equalToConstant: 30),
            
            userName.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
        ])
    }
    
    public func setAttributes( withTitle title:String, withImage image:UIImage? , withTextColor textColor:UIColor , withImageSize size:CGFloat = UIFont.smallSystemFontSize, withFont font:UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: .semibold)) -> NSAttributedString {
        
        let attributedText = NSMutableAttributedString(string:"")
        
        if let image = image {
            let font = font
            let img = image.withRenderingMode(.alwaysTemplate).withTintColor(textColor)
            let image = NSTextAttachment()
            image.image = img
            image.bounds = CGRect(x: 0, y: (font.capHeight - size).rounded() / 2, width: size, height: size)
            image.setImageHeight(height: size)
            let imgString = NSAttributedString(attachment: image)
            attributedText.append(imgString)
            
            if title != "" {
                attributedText.append(NSAttributedString(string: " "))
            }
        }
        
        attributedText.append(NSAttributedString(string: "\(title)" , attributes:[NSAttributedString.Key.font:font , NSAttributedString.Key.foregroundColor:textColor]))
        
        return attributedText
    }

}
