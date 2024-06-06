//
//  BoxOffice.swift
//  Assignment_240605
//
//  Created by 김상규 on 6/6/24.
//

import Foundation

struct Boxoffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [DailyBoxOfficeInfo]
    
}

struct DailyBoxOfficeInfo: Decodable {
    var rank: String
    var movieNm: String
    var openDt: String
}
