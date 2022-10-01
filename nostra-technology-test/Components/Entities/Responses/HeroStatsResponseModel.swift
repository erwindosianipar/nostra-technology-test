//
//  HeroStatsResponseModel.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

struct HeroStatsResponseModel: Decodable, Encodable {
    let id: Int
    let name: String
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let roles: [String]
    let img: String
    let icon: String
    let base_health: Float
    let base_mana: Float
    let base_armor: Float
    let base_attack_min: Float
    let base_attack_max: Float
    let move_speed: Float
}
