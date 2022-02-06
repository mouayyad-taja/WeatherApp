//
//  SettingsVC.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import UIKit
import SwifterSwift

class SettingsVC: BaseVC {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView?
    
    //Properties
    private lazy var viewModel : SettingsViewModel = {
        return SettingsViewModel(dataSource: self.dataSource)
    }()
    
    private lazy var dataSource : SettingsDataSource = {
        return SettingsDataSource(onSelectItem: self.updateSelectedUnit(forUnit:), settings: nil)
    }()
    
    //MARK: Initialize view model
    func prepareViewModel(){
        //Observe data
        setupObservable()
    }
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareViewModel()
    }
    
    //MARK: Setup UI
    override func setupViews(){
        setupTableView()
        setupNavigation()
        setupUI()
    }

    //Prepare table view properities
    func setupTableView(){
        guard let tableView = tableView else {return}
        tableView.delegate = self.dataSource
        tableView.dataSource = self.dataSource
        tableView.register(nibWithCellClass: SettingsTVC.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //Observe data
    func setupObservable(){
        self.dataSource.settings = self.viewModel
        
        //observe items changes from view model
        self.viewModel.dataSource?.data.addAndNotify(self) {
            [weak self]  (items) in
            guard let self = self else {return}

            if items.isEmpty {
                //Show state view empty
                self.stateView?.setStateNoDataFound()
            }else {
                //hide state view
                self.stateView?.setDataAvailable()
            }
            self.tableView?.reloadData()
        }
    }

    func setupNavigation(){
        //Set navigation title
        self.navigationItem.title = "Settings"
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItems = [saveBtn]

        let canelBtn = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissViewController))
        self.navigationItem.leftBarButtonItems = [canelBtn]
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor.Colors.primaryBackGroundColor
        self.tableView?.backgroundColor = .clear
    }
    
    // MARK: - Methods
    func updateSelectedUnit(forUnit unit: UnitKey) {
        self.viewModel.updateSelectedUnit(unit: unit)
    }
    
    @objc func saveAction(){
        self.viewModel.saveSelectedUnit()
        self.dismissViewController()
    }
    
    @objc func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}


extension UIViewController {
    func presentSettingsVC(){
        let vc = ControllerManager.main.settingsVC
        let nav = UINavigationController(rootViewController: vc)
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: true, completion: nil)
    }
}
