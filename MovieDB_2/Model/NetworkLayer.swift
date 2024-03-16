//
//  NetworkLayer.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 15/3/24.
//

import Foundation

struct NetworkLayer {
    func fetchData(name: String, completion: @escaping (MoviesResponse) -> Void) {
        if let urlString = "https://www.omdbapi.com/?apikey=87341a3d&s=\(name)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            print(url)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Network Error:", error.localizedDescription)
                    return
                }
                guard let data = data else {
                    print("No se recibieron datos")
                    return
                }
                do {
                    let parsingData = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    completion(parsingData)
                } catch {
                    print("Parsing Error:", error)
                }
            }
            dataTask.resume()
        } else {
            print("URL inválida")
        }
    }
}
