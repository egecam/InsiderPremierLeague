//
//  Match.swift
//  InsiderPremierLeague
//
//  Created by Ege Çam on 16.05.2024.
//

import Foundation

struct Match: Identifiable {
    let id: UUID
    let homeTeam: Team
    let awayTeam: Team
    var homeTeamGoals: Int?
    var awayTeamGoals: Int?
}
