//
//  WeatherForecastListVC.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import UIKit
import SwifterSwift

class WeatherForecastListVC: BaseVC {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView?
    
    //Properties
    private lazy var viewModel : WeatherForecastViewModel = {
        return WeatherForecastViewModel(dataSource: self.dataSource)
    }()
    
    private lazy var dataSource : WeatherDataSource = {
        return WeatherDataSource(onSelectItem: self.openWeatherForecastDetails)
    }()
    
    //MARK: Initialize view model
    func prepareViewModel(){
        //Observe data
        setupObservable()
        
        //Get data
        getData()
    }
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareViewModel()
        setupUI()
    }
    
    //MARK: Setup UI
    override func setupViews(){
        setupTableView()
        createStateView(view: tableView)
    }

    //Prepare table view properities
    func setupTableView(){
        guard let tableView = tableView else {return}
        tableView.delegate = self.dataSource
        tableView.dataSource = self.dataSource
        tableView.register(nibWithCellClass: WeatherForecastDayTVC.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.refreshControl = self.ref
    }
    
    //Observe data
    func setupObservable(){
        //observe items changes from view model
        self.viewModel.dataSource?.data.addObserver(self) {
            [weak self]  (items) in
            guard let self = self else {return}
            self.tableView?.refreshControl?.endRefreshing()
            if items.isEmpty {
                //Show state view empty
                self.stateView?.setStateNoDataFound()
            }else {
                //hide state view
                self.stateView?.setDataAvailable()
            }
            self.tableView?.reloadData()
        }
        
        //observe total product collection changes from view model
        self.viewModel.data.addObserver(self) { [weak self] (item) in
            self?.setupNavigation()
        }
        
        //observe error change from view model
        self.viewModel.error.addObserver(self) {
            [weak self] (error) in
            guard let self = self else {return}

            self.tableView?.refreshControl?.endRefreshing()
            
            if self.dataSource.data.value.isEmpty {
                //show error state view
                if let message = error?.localizedDescription {
                    self.stateView?.setServerError(title: "Error", message: message, retryAction: self.getData)
                }
            }else {
                //show error alert
                self.showAlert(title: "Error", message: error?.localizedDescription)
            }
        }
    }

    func setupNavigation(){
        guard let item = self.viewModel.data.value else {return}
        
        //Set navigation title
        self.navigationItem.title = item.cityName
        
        let settingBtn = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(openSettingPage))
        self.navigationItem.rightBarButtonItems = [settingBtn]
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor.Colors.primaryBackGroundColor
        self.tableView?.backgroundColor = .clear
    }
    
    // MARK: - Methods
    func openWeatherForecastDetails(forWeather weatherForecast: WeatherForecast) {
        guard let weatherCollection = self.viewModel.data.value else {return}
        self.pushWeatherDetailVC(weatherCollection: weatherCollection, weatherDayForecast: weatherForecast)
    }
    
    @objc func openSettingPage(){
        //TODDO
    }
    
    // MARK: - GetData
    func getData(){
        
        if !self.ref.isRefreshing {
            //Show loading
            self.stateView?.setStateLoading()
        }
        
        //fetch list items
        self.viewModel.getWeatherForecastList()
    }
    
    override func getRefreshing() {
        self.getData()
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
