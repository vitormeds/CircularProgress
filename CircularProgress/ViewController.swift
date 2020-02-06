//
//  ViewController.swift
//  CircularProgress
//
//  Created by Vitor Mendes on 08/04/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var circularProgress: CircularProgress = {
        let circularProgress = CircularProgress()
        circularProgress.progressColor = UIColor.blue
        circularProgress.trackColor = UIColor.blue.withAlphaComponent(0.6)
        circularProgress.translatesAutoresizingMaskIntoConstraints = false
        return circularProgress
    }()
    
    var circularCountDownProgress: CircularProgress = {
        let circularProgress = CircularProgress()
        circularProgress.progressColor = UIColor.red
        circularProgress.trackColor = UIColor.red.withAlphaComponent(0.6)
        circularProgress.translatesAutoresizingMaskIntoConstraints = false
        return circularProgress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(circularProgress)
        circularProgress.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        circularProgress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circularProgress.widthAnchor.constraint(equalToConstant: 100).isActive = true
        circularProgress.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        circularProgress.createCircularPath(size: CGSize(width: 100, height: 100))
        circularProgress.setProgressWithAnimation(duration: 1.0, value: 0.8)
        
        view.addSubview(circularCountDownProgress)
        circularCountDownProgress.topAnchor.constraint(equalTo: circularProgress.bottomAnchor, constant: 32).isActive = true
        circularCountDownProgress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circularCountDownProgress.widthAnchor.constraint(equalToConstant: 100).isActive = true
        circularCountDownProgress.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        circularCountDownProgress.createCircularPath(size: CGSize(width: 100, height: 100))
        circularCountDownProgress.setCountDownWithAnimation(duration: 20, value: 1)
    }


}

