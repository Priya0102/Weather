//
//  QueryLIDownload.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import Foundation

class QueryTour {
    
    // MARK: - Variable -
    private let repository: DBManager<TourDetails>
    
    // MARK: - Initiallize -
    init(with repo: DBManager<TourDetails>) {
        repository = repo
    }
}

// MARK: - Query setup -
extension QueryTour {
    
    func insertList(response: TourDetails) {
        let predicate = NSPredicate(format: "self.city = %@", response.city.lowercased())
        
        let filter: [TourDetails] = try! repository.getAll(where: predicate)
        if filter.isEmpty {
            try? repository.insert(item: response)
        } else {
            try? repository.delete(item: response, with: predicate)
            try? repository.insert(item: response)
        }
    }
    
    func getList(where predicate: NSPredicate?) -> [TourDetails] {
        let items: [TourDetails] = try! repository.getAll(where: predicate)
        return items
    }
    
    func deleteList(response: TourDetails) {
        let predicate = NSPredicate(format: "self.city = %@", response.city.lowercased())
        try? repository.delete(item: response, with: predicate)
    }
}
