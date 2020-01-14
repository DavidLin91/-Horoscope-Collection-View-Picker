//
//  CollectionViewCell.swift
//  HoroscopeUserDefaultLab
//
//  Created by David Lin on 1/13/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var horoscopeImage: UIImageView!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    
    func configureCell(horoscope: Horoscopes) {
        birthdayLabel.text = horoscope.date
        horoscopeImage.image = UIImage(named: "\(horoscope.sunsign.lowercased())")
    }
}
