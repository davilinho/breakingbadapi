//
//  CommonResponse.swift
//  breakingbadapi
//
//  Created by David Martin on 8/12/20.
//

import Foundation

struct CommonResponse<Response: Codable>: Codable {
    public enum CodingKeys: String, CodingKey {
        case data
    }

    let data: Response
}
