//
//  FilterViewModel.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 02/10/22.
//

enum HeroFilter: String, Decodable, Encodable {
    case `default`
    case baseAttack = "Base Attack (Lower Limit)"
    case baseHealt = "Base Health"
    case baseMana = "Base Mana"
    case baseSpeed = "Base Speed"
}

final class FilterViewModel {
    
    let heroFilter: [HeroFilter] = [
        .baseAttack,
        .baseHealt,
        .baseMana,
        .baseSpeed
    ]
}
