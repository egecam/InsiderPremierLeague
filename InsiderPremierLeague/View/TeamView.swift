//
//  TeamView.swift
//  InsiderPremierLeague
//
//  Created by Ege Çam on 18.05.2024.
//

import SwiftUI

struct TeamView: View {
    var team: Team
    
    var body: some View {
        HStack {
            Image(systemName: "shield")
                .resizable()
                .frame(width: 24, height: 24)
                .padding()
            VStack(alignment: .leading) {
                Text(team.name)
                    .font(.headline)
                Text("Strength: \(team.strength)")
                    .font(.subheadline)
            }
            Spacer()
            Text("\(team.points) pts")
            Text("(\(team.goalDifference))")
        }
    }
}

