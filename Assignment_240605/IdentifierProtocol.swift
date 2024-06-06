//
//  IdentifierProtocol.swift
//  Assignment_240605
//
//  Created by 김상규 on 6/6/24.
//

import Foundation

protocol IdentifierProtocol {
    static var identifier: String { get }
}

extension BoxOfficeTableViewCell: IdentifierProtocol {
    static var identifier: String {
        String(describing: self)
    }
}
