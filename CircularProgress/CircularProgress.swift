//
//  CircularProgress.swift
//  CircularProgress
//
//  Created by Vitor Mendes on 08/04/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class CircularProgress: UIView {
    
    var progressLayer = CAShapeLayer()
    var tracklayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var progressColor:UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor:UIColor = UIColor.white {
        didSet {
            tracklayer.strokeColor = trackColor.cgColor
        }
    }
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func createCircularPath(size: CGSize) {
        
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = size.width/2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: size.width / 2.0, y: size.height / 2.0), radius: (size.width - 1.5)/2, startAngle: CGFloat(-0.5 * Double.pi), endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        tracklayer.path = circlePath.cgPath
        tracklayer.fillColor = UIColor.clear.cgColor
        tracklayer.strokeColor = trackColor.cgColor
        tracklayer.lineWidth = 10.0;
        tracklayer.strokeEnd = 1.0
        layer.addSublayer(tracklayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10.0;
        progressLayer.strokeEnd = 0.0
        progressLayer.strokeStart = 0.0
        layer.addSublayer(progressLayer)
        
        addSubview(progressLabel)
        progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        progressLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        progressLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        progressLabel.textColor = trackColor
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateCircle")
        DispatchQueue.global(qos: .default).async {
            var i = Float(0)
            repeat {
                Thread.sleep(forTimeInterval: duration/100)
                i = i + (value * 100)/100
                DispatchQueue.main.async {
                    if i >= (value * 100) {
                        self.progressLabel.text = String(format: "%.1f", (value * 100)).description.replacingOccurrences(of: ".", with: ",") + " %"
                    }
                    else
                    {
                        self.progressLabel.text = String(format: "%.1f", i).description.replacingOccurrences(of: ".", with: ",") + " %"
                    }
                }
            }while(i < (value * 100))
        }
    }
    
    func setCountDownWithAnimation(duration: Double, value: Float) {
        progressLayer.strokeStart = 1.0
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateCircle")
        var runCount = 0.0
        self.progressLabel.text = Int(duration).description
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runCount += 1
            self.progressLabel.text = Int(duration - runCount).description
            if runCount == duration {
                timer.invalidate()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
