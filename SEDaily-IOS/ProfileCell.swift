//
//  ProfileCell.swift
//  SEDaily-IOS
//
//  Created by Dawid Cedrych on 5/7/19.
//  Copyright © 2019 Koala Tea. All rights reserved.
//

import UIKit
import Reusable

class ProfileCell: UITableViewCell, Reusable {
	
	var avatarImage: UIImageView!
	var nameLabel: UILabel!
	var bioLabel: UILabel!
	var linkLabel: UILabel!
	
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}

extension ProfileCell {
	private func setupLayout() {
		func setupAvatarImage(){
			avatarImage = UIImageView()
			contentView.addSubview(avatarImage)
			avatarImage.contentMode = .scaleAspectFill
			avatarImage.clipsToBounds = true
			avatarImage.borderWidth = UIView.getValueScaledByScreenWidthFor(baseValue: 5)
			avatarImage.borderColor = Stylesheet.Colors.base
			avatarImage.cornerRadius = UIView.getValueScaledByScreenWidthFor(baseValue: 50)
			avatarImage.kf.indicatorType = .activity
		}
		func setupLabels(){
			nameLabel = UILabel()
			contentView.addSubview(nameLabel)
			nameLabel.textColor = Stylesheet.Colors.dark
			nameLabel.numberOfLines = 3
			nameLabel.font = UIFont(name: "Roboto-Bold", size: UIView.getValueScaledByScreenWidthFor(baseValue: 30))
			
			
			bioLabel = UILabel()
			contentView.addSubview(bioLabel)
			nameLabel.textColor = Stylesheet.Colors.dark
			nameLabel.numberOfLines = 0
			nameLabel.font = UIFont(name: "OpenSans", size: UIView.getValueScaledByScreenWidthFor(baseValue: 13))
			
			linkLabel = UILabel()
			contentView.addSubview(linkLabel)
			nameLabel.textColor = Stylesheet.Colors.base
			nameLabel.numberOfLines = 0
			nameLabel.font = UIFont(name: "OpenSans", size: UIView.getValueScaledByScreenWidthFor(baseValue: 13))
		}
		
		func setupConstraints() {
			avatarImage.snp.makeConstraints { (make) -> Void in
				make.top.equalToSuperview()
				make.width.equalTo(UIView.getValueScaledByScreenWidthFor(baseValue: 100.0))
				make.height.equalTo(UIView.getValueScaledByScreenWidthFor(baseValue: 100.0))
				make.center.equalToSuperview()
			}
			nameLabel.snp.makeConstraints { (make) -> Void in
				make.top.equalTo(avatarImage.snp_bottom).offset(UIView.getValueScaledByScreenWidthFor(baseValue: 10.0))
				make.center.equalToSuperview()
				make.rightMargin.leftMargin.equalToSuperview().inset(UIView.getValueScaledByScreenWidthFor(baseValue: 15.0))
			}
			bioLabel.snp.makeConstraints { (make) -> Void in
				make.left.equalToSuperview().offset(UIView.getValueScaledByScreenWidthFor(baseValue: 15.0))
				make.top.equalTo(nameLabel.snp_bottom).offset(UIView.getValueScaledByScreenWidthFor(baseValue: 15.0))
				make.bottom.equalToSuperview().inset(UIView.getValueScaledByScreenWidthFor(baseValue: 15.0))
			}
			linkLabel.snp.makeConstraints { (make) -> Void in
				make.left.equalTo(bioLabel)
				make.top.equalTo(bioLabel.snp_bottom).offset(UIView.getValueScaledByScreenWidthFor(baseValue: 15.0))
			}
		}
		setupAvatarImage()
		setupLabels()
		setupConstraints()
		
	}
}
