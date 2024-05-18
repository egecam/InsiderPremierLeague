Insider Premier League is a simple model of Premier League with 4 teams. The application is built with Swift and SwiftUI. It runs on **macOS**.

1. Sample Data
2. Logic
6. Screenshots

## Sample Data
The application uses sample data defined as `sampleTeams`which can be found in `SampleData.swift`. Each team with different strengths may be manipulated in this file for test cases.

## Models
The project has 3 models: Team, Match and League.
### Team
Team is an Identifiable structure with 10 properties and a method called `goalDifference`which calculates the goal difference using `goalsFor`and `goalsAgainst`.

### Match
Match is also an Identifiable structure with 5 properties.

### League
League class has 5 methods which form the main structure of the application: `createFixtures`, `simulateMatch`, `simulateWeek`, `calculateChampionshipPossibilities` and `getChampion`. Let's have a look at these five methods.

#### createFixtures
The method applies a round-robin distribution to create a fixture logic. First, it checks whether the `teams.count`is an even number or not to simplify working with round-robin. Then, rounds every team for each round by fixing the first team. Lastly, defines the second half by reversing the order.

#### simulateMatch
This method applies `Int.random` to generate goals per team by their strengths.
After defining goals for each team, checks win, loss and draw.

#### simulateWeek
This method sets two matches each week and appends the match results. Also, at the end calculates championship possibilities.

#### calculateChampionshipPossibilities
The method collects each team's total points and then calculates the possibility over 100.

#### getChampion
Considering team points, or goal differences for teams with same points as the Premier League rules say, returns the leader team using `Array.max`.

## Screenshots
##### Before the first week
![[Screenshot 2024-05-18 at 14.24.08.png]]
#### 4th Week
![[Screenshot 2024-05-18 at 14.25.16.png | 4th week]]
#### 5th Week
![[Screenshot 2024-05-18 at 14.26.43.png | 5th week]]
#### Final week, after the End of Season button clicked
![[Screenshot 2024-05-18 at 14.27.42.png | Final week]]
