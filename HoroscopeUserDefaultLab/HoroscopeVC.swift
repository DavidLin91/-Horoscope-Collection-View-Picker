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
        nameLabel.text = "\(userLabel.text ?? "") - Birthday: \(birthdayTextBox.text ?? "")"
        
        let userBirthdayString = birthdayTextBox.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let date = dateFormatter.date(from:userBirthdayString)!
        print(date)
        
        
        switch date {
        case HoroscopeDates.AquariusStart.days()...HoroscopeDates.AquariusEnd.days():
            collectionView.scrollToItem(at: NSIndexPath(item: 10, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.PiscesStart.days()...HoroscopeDates.PiscesEnd.days():
            collectionView.scrollToItem(at: NSIndexPath(item: 11, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.AriesStart.days()...HoroscopeDates.AriesEnd.days():
            collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.TaurusStart.days()...HoroscopeDates.TaurusEnd.days():
            collectionView.scrollToItem(at: NSIndexPath(item: 1, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.GeminiStart.days()...HoroscopeDates.GeminiEnd.days():
            collectionView.scrollToItem(at: NSIndexPath(item: 2, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.CancerStart.days()...HoroscopeDates.CancerEnd.days():
            collectionView.scrollToItem(at: NSIndexPath(item: 3, section: 0 ) as IndexPath, at: [],animated: false)
            
        case HoroscopeDates.LeoStart.days()...HoroscopeDates.LeoEnd.days():
            collectionView.scrollToItem(at: NSIndexPath(item: 4, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.VirgoStart.days()...HoroscopeDates.VirgoEnd.days():
        collectionView.scrollToItem(at: NSIndexPath(item: 5, section: 0 ) as IndexPath, at: [],animated: false)
            
        case HoroscopeDates.LibraStart.days()...HoroscopeDates.LibraEnd.days():
        collectionView.scrollToItem(at: NSIndexPath(item: 7, section: 0 ) as IndexPath, at: [],animated: false)
            
        case HoroscopeDates.ScorpioStart.days()...HoroscopeDates.ScorpioEnd.days():
        collectionView.scrollToItem(at: NSIndexPath(item: 8, section: 0 ) as IndexPath, at: [],animated: false)
            
        case HoroscopeDates.SagittariusStart.days()...HoroscopeDates.SagittariusEnd.days():
        collectionView.scrollToItem(at: NSIndexPath(item: 9, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.CapricornStart.days()...HoroscopeDates.CapricornEnd.days():
        collectionView.scrollToItem(at: NSIndexPath(item: 10, section: 0 ) as IndexPath, at: [],animated: false)
            
        default:
            break
        }
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
        print(indexPath.row)
        cell.configureCell(horoscope: horoscope)
        return cell
    }
    
    
}
