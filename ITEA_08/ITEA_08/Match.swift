//
//  Match.swift
//  ITEA_08
//
//  Created by Oleksandr Kurtsev on 19/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

public class Matches: NSObject, NSCoding {
    
    public var matches = [Match]()
    
    enum Key: String {
        case matches = "matches"
    }
    
    init(matches: [Match]) {
        self.matches = matches
    }

    public func encode(with coder: NSCoder) {
        coder.encode(matches, forKey: Key.matches.rawValue)
    }
    
    required convenience public init?(coder: NSCoder) {
        let mMatches = coder.decodeObject(forKey: Key.matches.rawValue) as! [Match]
        
        self.init(matches: mMatches)
    }
}

public class Match: NSObject, NSCoding {

    public var firstTeamName = ""
    public var secondTeamName = ""
    public var firstTeamGoals = 0
    public var seconTeamGols = 0
    public var timeMatch = Date()
    
    enum Key: String {
        case firstTeamName = "firstTeamName"
        case secondTeamName = "secondTeamName"
        case firstTeamGoals = "firstTeamGoals"
        case seconTeamGols = "seconTeamGols"
        case timeMatch = "timeMatch"
    }
    
    init(firstTeamName: String, secondTeamName: String, firstTeamGoals: Int, seconTeamGols: Int, timeMatch: Date) {
        self.firstTeamName = firstTeamName
        self.secondTeamName = secondTeamName
        self.firstTeamGoals = firstTeamGoals
        self.seconTeamGols = seconTeamGols
        self.timeMatch = timeMatch
    }
    
    override init() {
        super.init()
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(firstTeamName, forKey: Key.firstTeamName.rawValue)
        coder.encode(secondTeamName, forKey: Key.secondTeamName.rawValue)
        coder.encode(firstTeamGoals, forKey: Key.firstTeamGoals.rawValue)
        coder.encode(seconTeamGols, forKey: Key.seconTeamGols.rawValue)
        coder.encode(timeMatch, forKey: Key.timeMatch.rawValue)
    }
    
    required convenience public init?(coder: NSCoder) {
        let mFirstTeamName = coder.decodeObject(forKey: Key.firstTeamName.rawValue) as! String
        let mSecondTeamName = coder.decodeObject(forKey: Key.secondTeamName.rawValue) as! String
        let mFirstGoals = coder.decodeInteger(forKey: Key.firstTeamGoals.rawValue)
        let mSecondGoals = coder.decodeInteger(forKey: Key.seconTeamGols.rawValue)
        let mTimeMatch = coder.decodeObject(forKey: Key.timeMatch.rawValue) as! Date

        self.init(firstTeamName: mFirstTeamName, secondTeamName: mSecondTeamName, firstTeamGoals: mFirstGoals, seconTeamGols: mSecondGoals, timeMatch: mTimeMatch)
    }
}
