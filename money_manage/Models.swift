//
//  Models.swift
//  money_manage
//
//  Created by aru on 2025/06/12.
//

import Foundation
import SwiftData

//chatの型
struct ChatTemplates: Decodable {
    let weekly_spending_forecast: [[String]]
    let tomorrow_forecast: [[String]]
    let chitchat: [[String]]
    let advice: [[String]]
}

//swiftData
@Model
class Transaction {
    @Attribute(.unique) var id: UUID
    var date: Date
    var amount: Int
    var memo: String
    var type: Bool
    var createdAt: Date
    var updatedAt: Date

    @Relationship var category: Category

    init(
        id: UUID = UUID(),
        date: Date,
        amount: Int,
        memo: String,
        type: Bool,
        category: Category,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.date = date
        self.amount = amount
        self.memo = memo
        self.type = type
        self.category = category
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


@Model
class Category {
    @Attribute(.unique) var id: UUID
    var name: String
    var createdAt: Date
    var updatedAt: Date

    @Relationship(deleteRule: .cascade) var transactions: [Transaction]?

    init(
        id: UUID = UUID(),
        name: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
