//
//  MockData.swift
//  NM-Movies
//
//  Created by Nikola on 24.3.21..
//

import Foundation

class MockData {
    static let mockArray = [
    Movie(id: 0,
          title: "One",
          original_title: "The One",
          original_language: "en",
          overview: "Some description about the one movie.", homepage: "https://one.com",
          release_date: "2021-12-13",
          vote_average: 9.8,
          vote_count: 1021,
          poster_path: "/6XYLiMxHAaCsoyrVo38LBWMw2p8.jpg",
          genres: [
            Genre(id: 1,
                  name: "Action"
            )
          ]
    ),
        Movie(id: 0,
              title: "One",
              original_title: "The One",
              original_language: "en",
              overview: "Some description about the one movie.",
              homepage: "https://one.com",
              release_date: "2021-12-13",
              vote_average: 9.8,
              vote_count: 1021,
              poster_path: "/6XYLiMxHAaCsoyrVo38LBWMw2p8.jpg",
              genres: [
                Genre(id: 1,
                      name: "Action"
                )
              ]
        )
    ]
}
