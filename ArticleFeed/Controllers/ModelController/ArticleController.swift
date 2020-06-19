//
//  ArticleController.swift
//  ArticleFeed
//
//  Created by iljoo Chae on 6/18/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ArticleController {
    
    static let finalURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=ae910eac68e44996a3e949c1458b8138")
    
    static func fetchArticle(completion: @escaping (Result<[Article], ArticleError>) -> Void) {
        guard let finalURL = finalURL else {return completion(.failure(.invalidURL))}
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do{
                let topLevel = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let articles = topLevel.articles
                return completion(.success(articles))
            }catch{
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(article: Article, completion: @escaping (Result <UIImage, ArticleError>) -> Void) {
        guard let finalURL = article.urlToImage else {return}
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let urlToImage = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            return completion(.success(urlToImage))
        }.resume()
    }
    
}
