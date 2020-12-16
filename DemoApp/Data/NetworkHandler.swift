//
//  NetworkHandler.swift
//  DemoApp
//
//  Created by Cecilia Valenti on 2020-12-15.
//

import Foundation

class NetworkHandler {

    let urlString = "https://gist.githubusercontent.com/daviferreira/41238222ac31fe36348544ee1d4a9a5e/raw/5dc996407f6c9a6630bfcec56eee22d4bc54b518/employees.json"

    var callback: ((ManagerDTO) -> Void)?

    public func fetch() {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let request = URLRequest(url: url)

            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let result = try decoder.decode(ManagerDTO.self, from: safeData)
                            DispatchQueue.main.async {
                                self.callback?(result)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
