//
//  ArticleTableViewCell.swift
//  ArticleFeed
//
//  Created by iljoo Chae on 6/18/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol PresentErrorToUserDelegate: class {
    func presentErrorToUser(error: LocalizedError)
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleTextLabel: UILabel!
    @IBOutlet weak var articleContentLabel: UILabel!
    
    var article: Article? {
        //as soon as get the Post and
        didSet{
            updateViews()
        }
    }
    
    weak var delegate: PresentErrorToUserDelegate?
    
    func updateViews() {
        guard let article = article else {return}
        
        articleTitleTextLabel.text = article.title
        articleContentLabel.text = article.description
        articleImageView.image = nil
        
        ArticleController.fetchImage(article: article) {(result) in
            switch result {
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.articleImageView.image = image
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.presentErrorToUser(error: error)
                }
                print(error.localizedDescription)
            }
        }
    }
    
    
}
