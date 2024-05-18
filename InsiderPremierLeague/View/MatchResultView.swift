//
//  MatchResultView.swift
//  InsiderPremierLeague
//
//  Created by Ege Çam on 18.05.2024.
//

import SwiftUI

struct MatchResultView: View {
    var match: Match
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(match.homeTeam.name) vs \(match.awayTeam.name)")
                    .font(.headline)
                
                if let homeGoals = match.homeTeamGoals, let awayGoals = match.awayTeamGoals {
                    Text("\(homeGoals) - \(awayGoals)")
                        .font(.subheadline)
                } else {
                    Text("TBD")
                        .font(.subheadline)
                }
            }
            Spacer()
        }
    }
}
