//
//  LocationListController.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit
import CoreData

private struct LocationListKeys {
    static let alertTitle = "Alert"
    static let ok = "Ok"
    static let bookmarked = "This city has been bookmarked successfully"
    static let apiError = "Something went wrong"
    static let bookmarkedDeleted = "This city has been removed from bookmarked list"
    static let apiKey = "21d9afdb6326e663657f830fb4e1c565"
    static let unit = "metric"
    static let apiPath = "http://api.openweathermap.org/data/2.5/forecast?lat="
    static let mockeyApiPath = "https://run.mocky.io/v3/4d4e95fe-0682-4511-b55c-010e93db2dc3"
}

class LocationListController: UIViewController {
    
    // MARK: - Variable -
    var isBookMarked = false
    var coordinate: CLLocationCoordinate2D?
    var time = ""
    private var country = ""
    private var city = ""
    private let header = [
        "Content-Type": "application/json"
    ]
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
}

// MARK: - List Delegate -
extension LocationListController: LocationListDelegate {
    
    func backNavigation() {
        navigationController?.popViewController(animated: true)
    }
    
    func addBookMark() {
        
        if let coordinate = coordinate {
            
            let detail = TourDetails(country: country,
                                     city: city,
                                     latitude: coordinate.latitude,
                                     longitude: coordinate.longitude,
                                     time: time.isEmpty ? Date().description: time)
            
            if isBookMarked {
                deleteBookmarked(detail)
            } else {
                setOfflineTour(detail)
            }
        }
    }
}

// MARK: - Prepare View -
private extension LocationListController {
    
    final private func prepareView() {
        
        if let coordinate = coordinate {
            getCityFromLocation(coordinate) { (city, country, error) in
                if error == nil {
                    self.city = city ?? ""
                    self.country = country ?? ""
                    self.setCityName(self.city + "," + self.country)
                }
            }
            
            getWeatherReport(coordinate.latitude,
                             longitude: coordinate.longitude) { (error) in
                self.alertOk(message: LocationListKeys.apiError)
                
            } successCompletion: { (response) in
                
                DispatchQueue.main.async {
                    self.setWeatherReport(response)
                }
            }
        }
        setBookMark()
    }
    
    final private func setCityName(_ cityName: String) {
        if let view = view as? LocationListView {
            view.cityName = cityName
        }
    }
    
    final private func setBookMark() {
        if let view = view as? LocationListView {
            view.isBookmarked = isBookMarked
        }
    }
    
    final private func setWeatherReport(_ report: [WeatherReport]) {
        if let view = view as? LocationListView {
            view.weatherForcast = report
        }
    }
    
    final private func getCityFromLocation(_ coordinate: CLLocationCoordinate2D,
                                           completion: @escaping (_ city: String?, _ country:  String?,_ error: Error?) -> ()) {
        
        let location = CLLocation(latitude: coordinate.latitude,
                                  longitude: coordinate.longitude)
        
        location.fetchCityAndCountry { city, country, error in
            guard let city = city,
                  let country = country,
                  error == nil else { return }
            completion(city, country, error)
        }
    }
    
    final private func setOfflineTour(_ tourDetails: TourDetails) {
        let viewModel = QueryTour(with: DBManager(persistentContainer: persistance))
        viewModel.insertList(response:tourDetails)
        
        alertOk(message: LocationListKeys.bookmarked) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    final private func deleteBookmarked(_ tourDetails: TourDetails) {
        let viewModel = QueryTour(with: DBManager(persistentContainer: persistance))
        viewModel.deleteList(response:tourDetails)
        
        alertOk(message: LocationListKeys.bookmarkedDeleted) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    final private func alertOk(message: String,
                               completionSucess: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: LocationListKeys.alertTitle,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocationListKeys.ok, style: .default, handler: { _ in
            completionSucess?()
        }))
        LIApplication.appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Get Weather Forecast -
private extension LocationListController {
    
    func getWeatherReport(_ latitude: Double,
                          longitude: Double,
                          failureCompletion: @escaping (_ failure: Error) -> Void,
                          successCompletion: @escaping (_ response: [WeatherReport]) -> Void) {
        
        // let apiPath = "\(LocationListKeys.apiPath)\(latitude)&lon=\(longitude)&appid=\(LocationListKeys.apiKey)&units=\(LocationListKeys.unit)"
        
        let apiPath = LocationListKeys.mockeyApiPath
        
        guard let path = apiPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
                                            
                                            if error != nil {
                                                failureCompletion(error!)
                                            } else {
                                                if let userData = data {
                                                    do {
                                                        let json = try JSONSerialization.jsonObject(with: userData, options: []) as? [String: Any]
                                                        
                                                        let weatherList = json?["list"] as? [[String: Any]]
                                                        plog(weatherList)
                                                        
                                                        var response = [WeatherReport]()
                                                        weatherList?.forEach({ (list) in
                                                            
                                                            let date =  list["dt_txt"] as! String
                                                            var temperature = ""
                                                            
                                                            if let tempList =  list["main"] as? [String: Any] {
                                                                let temp = tempList["temp"]
                                                                temperature = "\(temp ?? 0)"
                                                            }
                                                            
                                                            if let weatherTypeList = list["weather"] as? [[String: Any]],
                                                               let weather = weatherTypeList.first {
                                                                
                                                                let report = WeatherReport(main: weather["main"] as! String,
                                                                                           description: weather["description"] as! String,
                                                                                           dt_txt: date, temp: temperature)
                                                                
                                                                response.append(report)
                                                            }
                                                        })
                                                        successCompletion(response)
                                                        
                                                    } catch {
                                                        failureCompletion(error)
                                                    }
                                                }
                                            }
                                        })
        dataTask.resume()
    }
}
