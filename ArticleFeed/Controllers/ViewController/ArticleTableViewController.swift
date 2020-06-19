//
//  ArticleTableViewController.swift
//  ArticleFeed
//
//  Created by iljoo Chae on 6/18/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    var articles : [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticle()
    }

    func fetchArticle() {
        ArticleController.fetchArticle { (result) in
            switch result {
            case .success(let articles):
//                self.articles.append(article)
                self.articles = articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.presentErrorToUser(error: error)
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else {return UITableViewCell()}
        let article = articles[indexPath.row]
        cell.article = article
        cell.delegate = self
        // Configure the cell...

        return cell
    }
    

}

extension ArticleTableViewController: PresentErrorToUserDelegate {
    func presentErrorToUser(error: LocalizedError) {
        self.presentErrorToUser(localizedError: error)
    }
}
