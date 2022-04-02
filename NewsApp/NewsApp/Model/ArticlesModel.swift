//
//  ArticlesModel.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 01/04/22.
//

struct ArticleResponse: Codable {
//    let status: String?
//    let totalResults: Int?
    let articles: [Article]
}

struct Article: Codable {
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
