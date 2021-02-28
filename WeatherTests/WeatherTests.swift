//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Priya Gongal on 27/02/21.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    
    // var weatherResponse = [WeatherReport]()
    
    override class func setUp() {
    }
    override class func tearDown() {
        
    }
    func testWeatherResponse() {
        let weatherResponse = WeatherReport(main: "Clear", description: "clear sky", dt_txt: "2021-02-28 09:00:00", temp: "27.64")
        // let weatherReportModel = Weather(weatherResponse)
        XCTAssertNotNil(weatherResponse.main)
        XCTAssertNotNil(weatherResponse.description)
        XCTAssertNotNil(weatherResponse.dt_txt)
        XCTAssertNotNil(weatherResponse.temp)
    }
    func testWeatherDetails() {
        let temp = 23
        XCTAssertEqual(temp, 23)
    }
    
    func testSetCityName() {
        let cityName = "Nagpur"
        XCTAssertNotNil(cityName)
    }
    func testTourAnnotationModel() {
        let annotation = TourAnnotation(0, 0, title: "Mumbai", subtitle: "Thane", color: "red")
        XCTAssertEqual(annotation.title, "Mumbai")
        XCTAssertEqual(annotation.subtitle, "Thane")
        XCTAssertNotNil(annotation.color)
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
