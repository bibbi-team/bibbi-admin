//
//  APIConfig.swift
//  BibbiAdmin
//
//  Created by 김건우 on 4/20/24.
//

import Foundation

struct APIConfig: APIConfigType {
    var hostApi: String {
        Bundle.main.baseUrl
    }
}
