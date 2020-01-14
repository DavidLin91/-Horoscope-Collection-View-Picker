//
//  ViewController.swift
//  HoroscopeUserDefaultLab
//
//  Created by David Lin on 1/13/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class HoroscopeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLabel: UITextField!
    
    
    override func viewDidLayoutSubviews() {
        enterNameButton.layer.cornerRadius = 5.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func enterButtonPressed(_ sender: UIButton) {
        nameLabel.text = "Welcome \(userLabel.text ?? "")!"
    }
    

}

