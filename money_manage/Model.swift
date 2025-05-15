//
//  Model.swift
//  money_manage
//
//  Created by aru on 2025/05/15.
//

import SwiftUI


struct ChatTemplates: Decodable {
    let weekly_spending_forecast: [[String]]
    let tomorrow_forecast: [[String]]
    let chitchat: [[String]]
    let advice: [[String]]
}
