//
//  Character.swift
//  breakingbadapi
//
//  Created by David Martin on 8/12/20.
//

import Foundation

struct Character: Codable, Equatable {
    var chatId: Int? = nil
    var name: String? = nil
    var birthday: String? = nil
    var occupation: [String]? = nil
    var img: String? = nil
    var status: Status? = nil
    var nickName: String? = nil
    var appearance: [Int]? = nil
    var portrayed: String? = nil
    var category: String? = nil
    var betterCallSaulAppearance: [Int]? = nil

    init(name: String?) {
        self.name = name
    }

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

    func getCategories() -> [CharacterCategory]? {
        guard let category = self.category else { return nil }
        return category.split(separator: ",").compactMap { CharacterCategory(rawValue: String($0.trimmingCharacters(in: .whitespacesAndNewlines))) }
    }

    enum Status: String, Codable {
        case alive = "Alive"
        case deceased = "Deceased"
        case presumedDead = "Presumed dead"
        case unknown = "Unknown"
    }
}

enum CharacterCategory: String {
    case breakingBad
    case betterCallSaul
}
