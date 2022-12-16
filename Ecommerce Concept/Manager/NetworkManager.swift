//
//  NetworkManager.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    typealias HomeScreenResponseCompletion = (Result<ApiResponse, Error>) -> Void
    typealias DetailsResponseCompletion = (Result<PhoneDetails, Error>) -> Void
    
    let homeScreenApiString = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    let detailsScreenApiString = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
    let cartScreenApiString = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
    
    /// Requests data for the home screen
    /// - TODO: add custom error to pass in completion block if url equals nil
    /// - Parameter completion: A closure to be executed once the request has finished
    func requestHomeScreenData(completion: @escaping HomeScreenResponseCompletion) {
        guard let url = URL(string: homeScreenApiString) else {
            return
        }
        
        AF.request(url).responseDecodable(of: ApiResponse.self, queue: .main) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Requests data for the details screen
    /// - TODO: add custom error to pass in completion block if url equals nil
    /// - Parameter completion: A closure to be executed once the request has finished
    func requestPhoneDetailsData(completion: @escaping DetailsResponseCompletion) {
        guard let url = URL(string: detailsScreenApiString) else {
            return
        }
        
        AF.request(url).responseDecodable(of: PhoneDetails.self, queue: .main) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
