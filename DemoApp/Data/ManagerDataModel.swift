//
//  ManagerDataModel.swift
//  DemoApp
//
//  Created by Cecilia Valenti on 2020-12-15.
//

import Foundation

struct ManagerDataModel {
    let managers: [Manager]

    init(dto: ManagerDTO) {
        let mans: [Manager] = dto.data.map { man in
            //Look up correct email address in included data
            let email = dto.included.filter {
                $0.id == man.relationships.account.data.id
            }.first?.attributes.email

            return Manager(firstName: man.attributes.firstName,
                           lastName: man.attributes.lastName,
                           name: man.attributes.name,
                           email: email ?? "Email address not found")
        }
        self.managers = mans
    }

    struct Manager {
        let firstName: String
        let lastName: String
        let name: String
        let email: String
    }
}
