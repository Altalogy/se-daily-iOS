//
//  Comment.swift
//  SEDaily-IOS
//
//  Created by jason on 2/1/18.
//  Copyright © 2018 Koala Tea. All rights reserved.
//

import Foundation
import Down
public struct Comment: Codable {
    let author: Author
    let _id: String
    let content: String
    let dateCreated: String
    let deleted: Bool
    let rootEntity: String
    let replies: [Comment]?
    let score: Int
    let upvoted: Bool?
    let downvoted: Bool?
    let parentComment: String?
}

extension Comment {
    
    // This is too slow for a cell collection view call
    func getPostedDate() -> Date? {
        return Date(iso8601String: self.dateCreated)
    }
    
    func commentBody() -> NSAttributedString {
        // This should be done on the server
        if self.deleted {
            return NSAttributedString(string: "This post has been deleted.")
        } else {
            let down = Down(markdownString: self.content)
            if let content = try? down.toAttributedString() {
                print("return NEW content")
                return content
            } else {
                print("return old content")
                return NSAttributedString(string: self.content)
            }
        }
    }
}
