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

struct HomeView: View {
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
    }
}

#Preview {
    HomeView(league: League(teams: sampleTeams))
}
