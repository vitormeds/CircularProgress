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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(circularProgress)
        circularProgress.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circularProgress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circularProgress.widthAnchor.constraint(equalToConstant: 100).isActive = true
        circularProgress.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        circularProgress.createCircularPath(size: CGSize(width: 100, height: 100))
        circularProgress.setProgressWithAnimation(duration: 1.0, value: 0.8)
    }


}

