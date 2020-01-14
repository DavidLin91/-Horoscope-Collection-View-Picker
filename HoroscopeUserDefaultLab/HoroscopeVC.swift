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
    @IBOutlet weak var horoscopeDescriptionLabel: UIImageView!
    @IBOutlet weak var descriptionSunSignLabel: UILabel!
    @IBOutlet weak var sunSignDescription: UILabel!
    @IBOutlet weak var birthdayTextBox: UITextField!
    
    
    
    
    private var horoscopes = [Horoscopes]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        enterNameButton.layer.cornerRadius = 5.0
        horoscopeDescriptionLabel.layer.cornerRadius = 10.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        loadData()
    }
    
    
    func loadData() {
        HoroscopeAPIClient.getHoroscope { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                self.horoscopes = data
            }
        }
    }
    
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        nameLabel.text = "Name: \(userLabel.text ?? "") - Birthday: \(birthdayTextBox.text ?? "")"
    }
    
}

extension HoroscopeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        horoscopes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horoscopeImage", for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        let horoscope = horoscopes[indexPath.row]
        cell.configureCell(horoscope: horoscope)
        descriptionSunSignLabel.text = horoscope.sunsign
        sunSignDescription.text = horoscope.horoscope
        return cell
    }
}
