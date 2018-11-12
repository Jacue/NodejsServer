//
//  RecommendNovel.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/12.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit

struct RecommendNovel: Codable {
    let bid: String?
    let bookname: String?
    let introduction: String?
    let book_Info: String?
    let chapterid: String?
    let topic: String?
    let topic_first: String?
    let date_updated: Double?
    let author: String?
    let author_name: String?
    let top_class: String?
    let state: String?
    
    let readCount: String?
    let praiseCount: String?
    let stat_name: String?
    let class_name: String?
    let size: String?
    let book_cover: String?
    let chapterid_first: String?
    let chargeMode: String?
    let digest: String?
    let price: String?
    let tag: [String]?
    let is_new: Int?
    
    let discountNum: Int?
    let quick_price: Int?
    let formats: String?
    let audiobook_playCount: String?
    let chapterNum: String?
    let isShortStory: Bool?
    let userid: String?
    let search_heat: String?
    let num_click: String?
    let recommend_num: String?
    let first_cate_id: String?
    let first_cate_name: String?
    let reason: String?
}
