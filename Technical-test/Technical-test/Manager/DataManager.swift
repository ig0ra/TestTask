//
//  DataManager.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

protocol IDataManager {
    func fetchQuotes() async throws -> [Quote]
    func modifyFavoriteStatus(of quote: Quote?, completion: @escaping () -> ())
    func isFavorite(quote: Quote?) -> Bool
}

final class DataManager: IDataManager {
    
    func fetchQuotes() async throws -> [Quote] {
        guard let url = URL(string: NameSpace.path) else {
            throw FetchError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.requestFailed
        }
        
        let decodedQuotes = try decode(data)
        
        return decodedQuotes
    }
    
    func modifyFavoriteStatus(of quote: Quote?, completion: @escaping () -> ())  {
        guard let name = quote?.name else { return }
        let isFavorite = UserDefaults.standard.bool(forKey: name)

        UserDefaults.standard.set(isFavorite ? false : true, forKey: name)
        
        completion()
    }
    
    func isFavorite(quote: Quote?) -> Bool {
        guard let name = quote?.name else {
            return false
        }
        
        return UserDefaults.standard.bool(forKey: name)
    }
}

private extension DataManager {
    func decode(_ data: Data) throws -> [Quote] {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode([Quote].self, from: data) else {
            throw FetchError.invalidData
        }
        
        return decodedData
    }
}

