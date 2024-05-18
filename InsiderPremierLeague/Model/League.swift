//
//  League.swift
//  InsiderPremierLeague
//
//  Created by Ege Çam on 16.05.2024.
//

import Foundation

class League: ObservableObject {
    @Published var teams: [Team]
    @Published var matches: [Match]
    @Published var currentWeek: Int = 0
    @Published var fixtures: [[(Int, Int)]]
    
    init(teams: [Team], matches: [Match] = []) {
        self.teams = teams
        self.matches = matches
        self.fixtures = League.createFixtures(for: teams.count)
    }
    
    static func createFixtures(for teamCount: Int) -> [[(Int, Int)]] {
        guard teamCount % 2 == 0 else { return [] }
        
        var fixtures: [[(Int, Int)]] = []
        let totalRounds = (teamCount - 1) * 2
        let matchesPerRound = teamCount / 2
        
        var teams = Array(0..<teamCount)
        
        for round in 0..<totalRounds {
            var roundFixtures: [(Int, Int)] = []
            for match in 0..<matchesPerRound {
                let home = teams[match]
                let away = teams[teamCount - 1 - match]
                
                if round >= teamCount - 1 {
                    roundFixtures.append((away, home))
                } else {
                    roundFixtures.append((home, away))
                }
            }
            fixtures.append(roundFixtures)
            teams.insert(teams.remove(at: 1), at: teamCount - 1)
        }
        
        return fixtures
    }
    
    func simulateMatch(homeTeam: inout Team, awayTeam: inout Team) -> Match {
        let homeGoals = Int.random(in: 0...(homeTeam.strength + 1))
        let awayGoals = Int.random(in: 0...(awayTeam.strength + 1))
        
        let match = Match(id: UUID(), homeTeam: homeTeam, awayTeam: awayTeam, homeTeamGoals: homeGoals, awayTeamGoals: awayGoals)
        
        homeTeam.goalsFor += homeGoals
        homeTeam.goalsAgainst += awayGoals
        awayTeam.goalsFor += awayGoals
        awayTeam.goalsAgainst += homeGoals
        
        if homeGoals > awayGoals {
            homeTeam.points += 3
            homeTeam.wins += 1
            awayTeam.losses += 1
        } else if homeGoals < awayGoals {
            awayTeam.points += 3
            awayTeam.wins += 1
            homeTeam.losses += 1
        } else {
            homeTeam.points += 1
            awayTeam.points += 1
            homeTeam.draws += 1
            awayTeam.draws += 1
        }
        
        return match
    }
    
    func simulateWeek(){
        if currentWeek < fixtures.count {
            for match in fixtures[currentWeek] {
                var homeTeam = teams[match.0]
                var awayTeam = teams[match.1]
                let matchResult = simulateMatch(homeTeam: &homeTeam, awayTeam: &awayTeam)
                matches.append(matchResult)
                teams[match.0] = homeTeam
                teams[match.1] = awayTeam
            }
            currentWeek += 1
            calculateChampionshipPossibilities()
        }
    }
    
    func calculateChampionshipPossibilities() {
        let totalPoints = teams.reduce(0) { $0 + $1.points }
        for i in 0..<teams.count {
            teams[i].championshipPossibility = totalPoints == 0 ? 0 : (Double(teams[i].points) / Double(totalPoints)) * 100
        }
    }
    
    func getChampion() -> Team? {
        return teams.max { (team1, team2) -> Bool in
            if team1.points != team2.points {
                return team1.points < team2.points
            } else if team1.goalDifference != team2.goalDifference {
                return team1.goalDifference < team2.goalDifference
            } else {
                return team1.goalsFor < team2.goalsFor
            }
        }
    }
}
