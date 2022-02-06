//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

protocol SettingsProtocol{
    func isSelectedUnit(unit: UnitKey)->Bool
}

class SettingsViewModel {
    
    //Unit dataSource
    private(set) weak var dataSource : GenericDataSource<UnitKey>?
    
    //Observable data
    private(set) var selectedUnit : DynamicValue<UnitKey?> = DynamicValue<UnitKey?>(nil)
    
    //MARK: Initialization
    init(dataSource : GenericDataSource<UnitKey>?) {
        self.dataSource = dataSource
        self.selectedUnit.value = UnitManager.shared.currentUnit
        prepareSettingList()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(onUpdateUnit(_:)), name: .didUpdateUnit, object: nil)
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    //Get setting list
    func prepareSettingList(){
        let listSettings :[UnitKey] = UnitKey.tempUnits
        self.dataSource?.data.value = listSettings
    }
    
    func updateSelectedUnit(unit: UnitKey){
        self.selectedUnit.value = unit
        self.dataSource?.data.forceNotify()
    }
    
    func saveSelectedUnit(){
        guard let unit = self.selectedUnit.value else {return}
        UnitManager.shared.updateUnit(unit: unit)
    }
    
//    //Hanlde updated unit
//    @objc func onUpdateUnit(_ notification:Notification){
//        if let product = notification.object as? UnitKey {
//            self.selectedUnit.value = product
//            self.dataSource?.data.forceNotify()
//        }
//    }
}

extension SettingsViewModel: SettingsProtocol {
    func isSelectedUnit(unit: UnitKey) -> Bool {
        return self.selectedUnit.value?.rawValue == unit.rawValue
    }
}
