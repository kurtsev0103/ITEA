//
//  NetworkManager.swift
//  ITEA_12
//
//  Created by Oleksandr Kurtsev on 03/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
        
    private let headers: HTTPHeaders = [
        "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
        "x-rapidapi-key": apiKey
    ]
    
    func fetchStatisticsTeam(withTeamID id: Int,
                             completionHandler: @escaping (_ statistics: Statistics) -> Void) {
        AF.request("https://api-football-v1.p.rapidapi.com/v2/statistics/2/\(id)", headers: headers).responseJSON { response in
            guard let data = response.data else { return }
            
            if let statistics = self.parseStatistics(withData: data) {
                completionHandler(statistics)
            }
        }
    }
    
    func fetchCurrentTeams(completionHandler: @escaping (_ teams: [Team]) -> Void) {
        AF.request("https://api-football-v1.p.rapidapi.com/v2/teams/league/2", headers: headers).responseJSON { response in
            guard let data = response.data else { return }
            
            if let teams = self.parseTeams(withData: data) {
                completionHandler(teams)
            }
        }
    }
    
    func downloadImage(withURL url: String, completionHandler: @escaping (_ image: UIImage) -> Void) {
        AF.request(url).responseJSON { response in
            guard let data = response.data else { return }
            guard let image = UIImage(data: data) else { return }
            completionHandler(image)
        }
    }
    
    private func parseTeams(withData data: Data) -> [Team]? {
        do {
            let currentData = try JSONDecoder().decode(CurrentData.self, from: data)
            guard let teamsData = currentData.api.teams else { return nil }
            var array = [Team]()
            
            for teamElement in teamsData {
                guard let team = Team(teamData: teamElement) else { return nil }
                array.append(team)
            }
            return array
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func parseStatistics(withData data: Data) -> Statistics? {
        do {
            let currentData = try JSONDecoder().decode(CurrentData.self, from: data)
            guard let statisticsData = currentData.api.statistics else { return nil }
            guard let statistics = Statistics(statisticsData: statisticsData) else { return nil }
            return statistics
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
