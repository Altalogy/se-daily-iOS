//
//  EpisodeViewController.swift
//  SEDaily-IOS
//
//  Created by Dawid Cedrych on 4/30/19.
//  Copyright © 2019 Altalogy. All rights reserved.
//

protocol WebViewCellDelegate {
	func updateWebViewHeight(didCalculateHeight height: CGFloat)
}
import UIKit
import WebKit

class EpisodeViewController: UIViewController {
	
	weak var delegate: PodcastDetailViewControllerDelegate?
	private weak var audioOverlayDelegate: AudioOverlayDelegate?
	
	var loaded: Bool = false // to check if HTML content has loaded
	var webView: WKWebView = WKWebView()
	let networkService: API = API()
	
	var webViewHeight: CGFloat = 600
	
	var viewModel = PodcastViewModel()
	
	var tableView = UITableView()
	
	var upvoteService: UpvoteService?
	var bookmarkService: BookmarkService?
	
	required init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, audioOverlayDelegate: AudioOverlayDelegate?) {
		self.audioOverlayDelegate = audioOverlayDelegate
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		self.view.addSubview(tableView)
		tableView.snp.makeConstraints { (make) -> Void in
			make.top.equalToSuperview()
			make.bottom.equalToSuperview()
			make.right.equalToSuperview()
			make.left.equalToSuperview()
		}
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(cellType: EpisodeHeaderCell.self)
		tableView.register(cellType: WebViewCell.self)
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 50.0
		//tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		tableView.backgroundColor = .white
		var htmlString = self.removePowerPressPlayerTags(html: viewModel.encodedPodcastDescription)
		htmlString = self.addStyling(html: htmlString)
		//htmlString = self.addHeightAdjustment(html: htmlString, height: headerView.height)
		htmlString = self.addScaleMeta(html: htmlString)
		webView.loadHTMLString(htmlString, baseURL: nil)
		//webView.navigationDelegate = self
		
		
		// Do any additional setup after loading the view.
	}
	func commentsButtonPressed(_ viewModel: PodcastViewModel) {
		Analytics2.podcastCommentsViewed(podcastId: viewModel._id)
		let commentsStoryboard = UIStoryboard.init(name: "Comments", bundle: nil)
		guard let commentsViewController = commentsStoryboard.instantiateViewController(
			withIdentifier: "CommentsViewController") as? CommentsViewController else {
				return
		}
		if let thread = viewModel.thread {
			commentsViewController.rootEntityId = thread._id
			self.navigationController?.pushViewController(commentsViewController, animated: true)
		}
	}	
	
	
}




extension EpisodeViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		switch indexPath.row {
		case 0:
			let cell: EpisodeHeaderCell = tableView.dequeueReusableCell(for: indexPath)
			cell.selectionStyle = .none
			cell.bookmarkService = bookmarkService
			cell.upvoteService = upvoteService
			
			cell.viewModel = viewModel
			//cell.layoutIfNeeded()
			return cell
			
		default:
			let cell: WebViewCell = tableView.dequeueReusableCell(for: indexPath)
			cell.webViewHeight = webViewHeight
			
			//cell.delegate = self
			//cell.webView = webView
			var htmlString = self.removePowerPressPlayerTags(html: viewModel.encodedPodcastDescription)
			htmlString = self.addStyling(html: htmlString)
			//htmlString = self.addHeightAdjustment(html: htmlString, height: headerView.height)
			htmlString = self.addScaleMeta(html: htmlString)
		htmlString = HtmlHelper.removeImage(html: htmlString)
			print(viewModel.encodedPodcastDescription)
			cell.webView.loadHTMLString(htmlString, baseURL: nil)
			//cell.webView.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 2000.0)
			//cell.webView.scrollView.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 2000.0)
			cell.webView.navigationDelegate = cell
			cell.delegate = self

			//print(cell.webView.frame)
			//cell.delegate = self
			
			return cell
			
		}
		
	}
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
}

extension EpisodeViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
}



extension EpisodeViewController: WebViewCellDelegate {
	func updateWebViewHeight(didCalculateHeight height: CGFloat) {
		if !loaded {
			webViewHeight = height
			tableView.reloadData()
			loaded = true
		} else { return }
	}
}


