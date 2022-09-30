//
//  HeroStatsResponseModel.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

struct HeroStatsDataResponseModel: Decodable {
    let id: Int
    let name: String
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let roles: [String]
    let img: String
    let icon: String
    let base_health: Int
    let base_mana: Int
    let base_armor: Int
    let base_attack_min: Int
    let base_attack_max: Int
    let move_speed: Int
}

struct HeroStatsResponseModel: Decodable {
    let data: [HeroStatsDataResponseModel]
}
