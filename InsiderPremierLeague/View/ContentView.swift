//
//  ContentView.swift
//  InsiderPremierLeague
//
//  Created by Ege Çam on 16.05.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var league: League
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Text("League Table")
                            .font(.headline)
                        List {
                            ForEach(league.teams.sorted(by: { $0.points > $1.points })) { team in
                                TeamView(team: team)
                            }
                        }
                    }
                    VStack {
                        Text("Match Results")
                            .font(.headline)
                            .padding(.top)
                        
                        List {
                            ForEach(league.matches.filter { match in
                                league.fixtures[league.currentWeek - 1].contains(where: { (homeIndex, awayIndex) in
                                    league.teams[homeIndex].id == match.homeTeam.id && league.teams[awayIndex].id == match.awayTeam.id
                                })
                            }) { match in
                                MatchResultView(match: match)
                            }
                        }
                    }
                    
                    
                    VStack {
                        Text("Championship Odds")
                            .font(.headline)
                        List {
                            ForEach(league.teams.sorted(by: { $0.championshipPossibility > $1.championshipPossibility })) { team in
                                ChampionshipPredictionView(team: team)
                            }
                        }
                    }
                }
                HStack {
                    Button(action: {
                        league.simulateWeek()
                    }) {
                        Text("Simulate Week")
                    }
                    .disabled(league.currentWeek >= league.fixtures.count)
                    .padding()
                }
                
                Button(action: {
                    if league.currentWeek >= league.fixtures.count {
                        print("Season Finished. The champion is \(league.getChampion()?.name ?? "unknown").")
                    }
                }) {
                    Text("End of Season")
                }
                .disabled(league.currentWeek < league.fixtures.count)
                .padding()
            }
            
        }
        .navigationTitle("Insider Champions League")
    }
}

#Preview {
    ContentView(league: League(teams: sampleTeams))
}
