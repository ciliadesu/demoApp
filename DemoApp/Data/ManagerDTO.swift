//
//  Managers.swift
//  DemoApp
//
//  Created by Cecilia Valenti on 2020-12-15.
//

import Foundation

struct ManagerDTO: Codable {
    
    let data: [ManagerData]
    let included: [AccountsData]
    
    struct ManagerData: Codable {

        let attributes: Attributes
        let relationships: Relationships

        struct Attributes: Codable {
            let firstName: String
            let lastName: String
            let name: String
        }

        struct Relationships: Codable {
            let account: Relationships.Data

            struct Data: Codable {
                let data: Data.Accounts

                struct Accounts: Codable {
                    let id: String
                }
            }
        }
    }

    struct AccountsData: Codable {
        let id: String
        let type: String
        let attributes: AccountsData.Attributes

        struct Attributes: Codable {
            let email: String?
        }
    }
}
