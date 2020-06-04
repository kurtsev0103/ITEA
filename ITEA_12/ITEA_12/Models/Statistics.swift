//
//  StatisticsData.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 03/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

struct Statistics {
    
    let homeMatchs: Int
    let awayMatchs: Int
    let totalMatchs: Int
    
    let homeWins: Int
    let awayWins: Int
    let totalWins: Int
    
    let homeDraws: Int
    let awayDraws: Int
    let totalDraws: Int
    
    let homeLoses: Int
    let awayLoses: Int
    let totalLoses: Int
    
    init?(statisticsData: TeamStatistics) {
        homeMatchs = statisticsData.matchs.matchsPlayed.home
        awayMatchs = statisticsData.matchs.matchsPlayed.away
        totalMatchs = statisticsData.matchs.matchsPlayed.total
        
        homeWins = statisticsData.matchs.wins.home
        awayWins = statisticsData.matchs.wins.away
        totalWins = statisticsData.matchs.wins.total
        
        homeDraws = statisticsData.matchs.draws.home
        awayDraws = statisticsData.matchs.draws.away
        totalDraws = statisticsData.matchs.draws.total
        
        homeLoses = statisticsData.matchs.loses.home
        awayLoses = statisticsData.matchs.loses.away
        totalLoses = statisticsData.matchs.loses.total
    }
}
