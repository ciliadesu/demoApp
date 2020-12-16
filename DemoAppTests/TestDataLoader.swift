//
//  TestDataLoader.swift
//  DemoAppTests
//
//  Created by Cecilia Valenti on 2020-12-16.
//

import Foundation

class TestDataLoader {

    func loadDecodableFrom<T: Decodable>(_ filename: String) throws -> T {
        let filetype = "json"
        guard let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: filetype) else {
            fatalError("File not found")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(T.self, from: data)
    }
}
