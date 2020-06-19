//
//  ArticleError.swift
//  ArticleFeed
//
//  Created by iljoo Chae on 6/18/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
enum ArticleError: LocalizedError {
    //what we see as developer
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    
    //what user see
    var errorDescription: String? {
        switch self {
            
        case .invalidURL:
            return "Unable to reach deckofcardsapi.com"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "The server resoponded with bad data"
        }
    }
}
