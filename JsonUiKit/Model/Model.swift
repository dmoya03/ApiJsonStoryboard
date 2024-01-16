//
//  Model.swift
//  JsonUiKit
//
//  Created by Daniel Moya on 15/1/24.
//

import Foundation

struct Model: Decodable {
    var data: [UserList]
}

struct User: Decodable {
    var data: UserList
}

struct UserList: Decodable {
    var id: Int
    var first_name: String
    var email: String
    var avatar: String
}
