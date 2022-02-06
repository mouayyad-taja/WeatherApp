//
//  WeatherDetailsDataSource.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation
import UIKit
import SwifterSwift


class WeatherDetailsDataSource: GenericDataSource<WeatherInfo>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var mainInfo: WeatherMainInfo?
    
    //MARK: Initialization
    init(mainInfo: WeatherMainInfo?) {
        super.init()
        self.mainInfo = mainInfo
    }
    
    func updateMainInfo(mainInfo: WeatherMainInfo?){
        self.mainInfo = mainInfo
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let mainInfo = mainInfo {
                let cell = collectionView.dequeueReusableCell(withClass: WeatherDetailsMainInfoCVC.self, for: indexPath)
                cell.configCellUI()
                cell.item = mainInfo
                return cell
            }
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withClass: WeatherDetailsInfoCVC.self, for: indexPath)
        let item = self.data.value[indexPath.row]
        cell.configCellUI()
        cell.item = item
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.width, height: 275)
        }
        
        let padding = 16.0
        var width = (collectionView.width - 2*padding) / 2.0
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            width = (collectionView.width - layout.minimumInteritemSpacing - 2*padding) / 2.0
        }
        return CGSize(width: width , height: 125)
    }
    
}
