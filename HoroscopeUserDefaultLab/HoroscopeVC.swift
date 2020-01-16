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
   
    let defaults = UserDefaults.standard
    
    
    private var horoscopes = [Horoscopes]() {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        enterNameButton.layer.cornerRadius = 5.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        
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
    
    func updateUI() {
        //reloads all data in collectionView
        collectionView.reloadData()
        // Use this method to force the view to update its layout immediately.
        self.collectionView.layoutIfNeeded()
        let savedName = UserDefaults.standard.object(forKey: "nameLabel") as? String
        //persists on saved nameLabel
        nameLabel.text = savedName

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        // persists on saved birthdate in date format
        let savedDate = dateFormatter.date(from:(UserDefaults.standard.object(forKey: "savedDate") as? String ?? ""))
        // uses persisted date on switch birthday function to find proper horoscope
       
        if savedDate != nil {
        switchBirthday(date: savedDate!)
        }
    }
    
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        nameLabel.text = "\(userLabel.text ?? "") - Birthday: \(birthdayTextBox.text ?? "")"
        UserDefaults.standard.set("\(nameLabel.text!)", forKey: "nameLabel")
        // TODO:
        // save date to user defaults
        UserDefaults.standard.set(birthdayTextBox.text, forKey:"savedDate")
        let userBirthdayString = birthdayTextBox.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let date = dateFormatter.date(from:userBirthdayString)!
        switchBirthday(date: date)
        
    }
    
    func switchBirthday(date: Date) {
        //self.collectionView.layoutIfNeeded()

        switch date {
        case HoroscopeDates.AquariusStart.days()...HoroscopeDates.AquariusEnd.days():
            collectionView.scrollToItem(at: NSIndexPath(item: 10, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.PiscesStart.days()...HoroscopeDates.PiscesEnd.days():
            collectionView.layoutIfNeeded()
            collectionView.scrollToItem(at: NSIndexPath(item: 1, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.AriesStart.days()...HoroscopeDates.AriesEnd.days():
            collectionView.layoutIfNeeded()
            collectionView.scrollToItem(at: NSIndexPath(item: 6, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.TaurusStart.days()...HoroscopeDates.TaurusEnd.days():
                collectionView.scrollToItem(at: IndexPath(item: 5, section: 0), at: .centeredHorizontally, animated: true)
        
        case HoroscopeDates.GeminiStart.days()...HoroscopeDates.GeminiEnd.days():
            collectionView.layoutIfNeeded()
            collectionView.scrollToItem(at: NSIndexPath(item: 7, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.CancerStart.days()...HoroscopeDates.CancerEnd.days():
            collectionView.layoutIfNeeded()
            collectionView.scrollToItem(at: NSIndexPath(item: 2, section: 0 ) as IndexPath, at: [],animated: false)
            
        case HoroscopeDates.LeoStart.days()...HoroscopeDates.LeoEnd.days():
            collectionView.layoutIfNeeded()
            collectionView.scrollToItem(at: NSIndexPath(item: 3, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.VirgoStart.days()...HoroscopeDates.VirgoEnd.days():
            collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: NSIndexPath(item: 9 , section: 0 ) as IndexPath, at: [],animated: false)
            
        case HoroscopeDates.LibraStart.days()...HoroscopeDates.LibraEnd.days():
            collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: NSIndexPath(item: 4, section: 0 ) as IndexPath, at: [],animated: false)
            
        case HoroscopeDates.ScorpioStart.days()...HoroscopeDates.ScorpioEnd.days():
            collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: NSIndexPath(item: 8, section: 0 ) as IndexPath, at: [],animated: false)
            
        case HoroscopeDates.SagittariusStart.days()...HoroscopeDates.SagittariusEnd.days():
            collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: NSIndexPath(item: 11, section: 0 ) as IndexPath, at: [],animated: false)
        
        case HoroscopeDates.CapricornStart1.days()...HoroscopeDates.CapricornEnd1.days():
            collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0 ) as IndexPath, at: [],animated: false)
            
        case HoroscopeDates.CapricornStart2.days()...HoroscopeDates.CapricornEnd2.days():
            collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0 ) as IndexPath, at: [],animated: false)
        
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
        cell.configureCell(horoscope: horoscope)
        return cell
    }
    
    
}
