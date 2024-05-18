//
//  ChampionshipPredictionView.swift
//  InsiderPremierLeague
//
//  Created by Ege Çam on 18.05.2024.
//

import SwiftUI

struct ChampionshipPredictionView: View {
    var team: Team
    
    var body: some View {
        HStack {
            Image(systemName: "star")
                .resizable()
                .frame(width: 24, height: 24)
                .padding()
            VStack(alignment: .leading) {
                Text(team.name)
                    .font(.headline)
                Text("Odds: \(String(format: "%.2f", team.championshipPossibility))%")
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}
