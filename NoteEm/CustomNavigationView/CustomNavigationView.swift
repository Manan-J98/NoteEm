//
//  CustomNavigationView.swift
//  NoteEm
//
//  Created by Intern on 27/12/19.
//  Copyright © 2019 Intern. All rights reserved.
//

import UIKit

class CustomNavigationView: UIView {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var navigationTitle: UILabel!

    override func draw(_ rect: CGRect) {
        let gradient = CAGradientLayer()
        var bounds = navigationView.bounds
//        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        let gradientColor1 = UIColor(red: 185/255, green: 195/255, blue: 199/255, alpha: 1.0)
        let gradientColor2 = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        gradient.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        navigationView.layer.insertSublayer(gradient, at: 0)

    }

    @IBAction func leftButtonAction(_ sender: Any) {

    }

    @IBAction func rightButtonAction(_ sender: Any) {

    }
}
