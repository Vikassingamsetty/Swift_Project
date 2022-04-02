//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 02/04/22.
//

import Foundation

class ArticleViewModel{
    let title: String?
    let description: String?
    let publishedAt: String?
    let imageURL: URL?
    var imageData: Data? = nil
    var likeStatus : Bool?
    
    init(title: String?, description: String?, publishedAt: String?, imageURL: URL?){
        self.title = title
        self.description = description
        self.publishedAt = publishedAt
        self.imageURL = imageURL
    }
}
