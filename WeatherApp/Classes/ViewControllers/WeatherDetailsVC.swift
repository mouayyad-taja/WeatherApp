//
//  WeatherDetailsVC.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import UIKit

class WeatherDetailsVC: BaseVC {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView?
    
    //Properties
    private var viewModel : WeatherDetailsViewModel?
    
    private lazy var dataSource : WeatherDetailsDataSource = {
        return WeatherDetailsDataSource(mainInfo: nil)
    }()
    
    //MARK: Initialize view model
    func initialize(weatherCollection: WeatherForecastCollection, weatherDayForecast: WeatherForecast){
        self.viewModel = WeatherDetailsViewModel(dataSource: self.dataSource, weatherCollection: weatherCollection, weatherDayForecast: weatherDayForecast)
    }
    
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
        //Set navigation title
        self.navigationItem.title = "Weather Details"
        
        setupCollectionView()
        setupUI()
    }
    
    //Prepare collection view properities
    func setupCollectionView(){
        guard let view = collectionView else {return}
        view.delegate = self.dataSource
        view.dataSource = self.dataSource
        view.register(nibWithCellClass: WeatherDetailsMainInfoCVC.self)
        view.register(nibWithCellClass: WeatherDetailsInfoCVC.self)
        let padding = 16.0
        if let layout = view.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 16
        }
        view.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: padding, right: padding)
    }
    
    //Observe data
    func setupObservable(){
        //observe items changes from view model
        self.viewModel?.data.addAndNotify(self) {
            [weak self]  (data) in
            guard let self = self, let data = data else {return}
            
            self.dataSource.updateMainInfo(mainInfo: data.0)
            self.dataSource.data.value = data.1
            self.collectionView?.reloadData()
        }
        
        //observe error change from view model
        self.viewModel?.error.addObserver(self) {
            [weak self] (error) in
            guard let self = self else {return}
            
            //show error alert
            self.showAlert(title: "Error", message: error?.localizedDescription)
        }
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor.Colors.primaryBackGroundColor
        self.collectionView?.backgroundColor = .clear
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
    func pushWeatherDetailVC(weatherCollection: WeatherForecastCollection, weatherDayForecast: WeatherForecast){
        let vc = ControllerManager.main.weatherDetailsVC
        vc.initialize(weatherCollection: weatherCollection, weatherDayForecast: weatherDayForecast)
        self.navigationController?.pushViewController(vc, completion: nil)
    }
}
