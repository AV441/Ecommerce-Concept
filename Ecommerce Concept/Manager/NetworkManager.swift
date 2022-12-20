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
    
    typealias HomeScreenResponseCompletion = (Result<ShopItem, Error>) -> Void
    typealias DetailsScreenResponseCompletion = (Result<PhoneDetails, Error>) -> Void
    typealias CartScreenResponseCompletion = (Result<CartItem, Error>) -> Void
    
    private let homeScreenApiString = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    private let detailsScreenApiString = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
    private let cartScreenApiString = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
    private let urlError = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error: failed to create URL"])
    
    /// Requests data for the home screen
    func requestHomeScreenData(completion: @escaping HomeScreenResponseCompletion) {
        guard let url = URL(string: homeScreenApiString) else {
            completion(.failure(urlError))
            return
        }
        
        AF.request(url).responseDecodable(of: ShopItem.self, queue: .main) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Requests data for the details screen
    func requestDetailsScreenData(completion: @escaping DetailsScreenResponseCompletion) {
        guard let url = URL(string: detailsScreenApiString) else {
            completion(.failure(urlError))
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
    
    /// Requests data for the cart screen
    func requestCartScreenData(completion: @escaping CartScreenResponseCompletion) {
        guard let url = URL(string: cartScreenApiString) else {
            completion(.failure(urlError))
            return
        }
        
        AF.request(url).responseDecodable(of: CartItem.self, queue: .main) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
