//
//  CommentTableViewCell.swift
//  SEDaily-IOS
//
//  Created by jason on 2/2/18.
//  Copyright © 2018 Koala Tea. All rights reserved.
//

import UIKit

protocol  CommentReplyTableViewCellDelegate: class {
    func replyToCommentPressed(comment: Comment)
}

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    weak var delegate: CommentReplyTableViewCellDelegate?
    var comment: Comment? {
        didSet {
            contentLabel.text = comment?.content
            if let username = comment?.author.username {
                usernameLabel.text = username
            }
            if let imageString = comment?.author.avatarUrl {
                let url = URL(string: imageString)
                avatarImage.kf.setImage(with: url)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func replyButtonPressed(_ sender: UIButton) {
        if let comment = comment {
            delegate?.replyToCommentPressed(comment: comment)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
