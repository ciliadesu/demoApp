//
//  DemoAppTests.swift
//  DemoAppTests
//
//  Created by Cecilia Valenti on 2020-12-15.
//

import XCTest
@testable import DemoApp

class DemoAppTests: XCTestCase {

    var dto: ManagerDTO!

    override func setUpWithError() throws {
        try dto = TestDataLoader().loadDecodableFrom("employees")
    }

    func testDecode() {
        
        XCTAssertNotNil(dto)
    }

    func testMakeDataModel() {

        let dataModel = ManagerDataModel(dto: dto)
        XCTAssertEqual(dataModel.managers.count, 9)

    }

    func testEmailsExist() {

        let dataModel = ManagerDataModel(dto: dto)

        for manager in dataModel.managers {
            XCTAssertNotNil(manager.email)
        }
    }

    func testCorrectEmail() {

        let dataModel = ManagerDataModel(dto: dto)
        let manager = dataModel.managers.filter { $0.name == "Harriet Banks"}.first
        XCTAssertEqual(manager?.email, "harriet.banks@kinetar.com")
    }

}
