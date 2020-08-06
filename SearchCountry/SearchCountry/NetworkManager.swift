//
//  NetworkManager.swift
//  SearchCountry
//
//  Created by Murat Merekov on 03.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    public static let endpoint = "https://restcountries.eu/rest/v2/all"
    
    static func getCountries(completion: @escaping ([Detail])->Void){
        AF.request(endpoint, method: .get).validate().responseData { (response) in
          
            switch response.result{
            case .success(let data):
                
                let jsonDecoder = JSONDecoder()
                if let listofCountries = try? jsonDecoder.decode([Detail].self, from: data){
                
                   print(listofCountries)
                    
                    completion(listofCountries)
                }else{
                    print("errro")
                }
            case .failure(let error):
                print("salam")
                print(error.localizedDescription)
            }
        }
    }
}
