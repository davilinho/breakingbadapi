//
//  Character.swift
//  breakingbadapi
//
//  Created by David Martin on 8/12/20.
//

import Foundation

struct Character: Codable, Equatable {
    let chatId: Int?
    let name: String?
    let birthday: String?
    let occupation: [String]?
    let img: String?
    let status: String?
    let nickName: String?
    let appearance: [Int]?
    let portrayed: String?
    let category: String?
    let betterCallSaulAppearance: [Int]?

    public enum CodingKeys: String, CodingKey {
        case chatId = "chat_id"
        case name
        case birthday
        case occupation
        case img
        case status
        case nickName = "nickname"
        case appearance
        case portrayed
        case category
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }

    func getCategories() -> [Category]? {
        guard let category = self.category else { return nil }
        return category.split(separator: ",").compactMap { Category(rawValue: String($0)) }
    }
}

enum Category: String {
    case breakingBad
    case betterCallSaul
}
