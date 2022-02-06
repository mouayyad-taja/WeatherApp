//
//  WeatherDataSourceTests.swift
//  WeatherAppTests
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import XCTest
@testable import WeatherApp

class WeatherDataSourceTests: XCTestCase {

    var dataSource : WeatherDataSource!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dataSource = WeatherDataSource(onSelectItem: nil)
    }
    
    override func tearDownWithError() throws {
        dataSource = nil
        try super.tearDownWithError()
    }
    
    func testEmptyValueInDataSource() {
        
        // giving empty data value
        dataSource.data.value = []
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected zero cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
    func testValueInDataSource() {
        
        // giving data value
        let weather1 = WeatherForecast()
        let weather2 = WeatherForecast()
        dataSource.data.value = [weather1, weather2]

        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected two cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    //
    func testValueCell() {
        
        // giving data value
        let dummyProducts = WeatherForecast()
        dataSource.data.value = [dummyProducts]

        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(nibWithCellClass: WeatherForecastDayTVC.self)
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected WishlistItemTVC class
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? WeatherForecastDayTVC else {
            XCTAssert(false, "Expected WeatherForecastDayTVC class")
            return
        }
    }
    

}
