//
//  PodcastPageViewController.swift
//  SEDaily-IOS
//
//  Created by Keith Holliday on 7/26/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class PodcastPageViewController: TabmanViewController, PageboyViewControllerDataSource {
    
    var viewControllers = [GeneralCollectionViewController]()
    var barItems = [TabmanBar.Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        self.loadViewControllers()
        
        // configure the bar
        self.bar.style = .scrollingButtonBar
        
        self.bar.items = barItems
        
        self.reloadPages()
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func loadViewControllers() {
        let layout = UICollectionViewLayout()
        
        let child_1 = GeneralCollectionViewController(collectionViewLayout: layout, type: API.Types.new)
        child_1.tabTitle = L10n.tabTitleAll
        viewControllers.append(child_1)
        
        let child_2 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1068, type: API.Types.new)
        child_2.tabTitle = L10n.tabTitleBusinessAndPhilosophy
        viewControllers.append(child_2)
        
        let child_3 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1082, type: API.Types.new)
        child_3.tabTitle = L10n.tabTitleBlockchain
        viewControllers.append(child_3)

        let child_4 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1079, type: API.Types.new)
        child_4.tabTitle = L10n.tabTitleCloudEngineering
        viewControllers.append(child_4)

        let child_5 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1081, type: API.Types.new)
        child_5.tabTitle = L10n.tabTitleData
        viewControllers.append(child_5)

        let child_6 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1084, type: API.Types.new)
        child_6.tabTitle = L10n.tabTitleJavaScript
        viewControllers.append(child_6)

        let child_7 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1080, type: API.Types.new)
        child_7.tabTitle = L10n.tabTitleMachineLearning
        viewControllers.append(child_7)

        let child_8 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1078, type: API.Types.new)
        child_8.tabTitle = L10n.tabTitleOpenSource
        viewControllers.append(child_8)

        let child_9 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1083, type: API.Types.new)
        child_9.tabTitle = L10n.tabTitleSecurity
        viewControllers.append(child_9)

        let child_10 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1085, type: API.Types.new)
        child_10.tabTitle = L10n.tabTitleHackers
        viewControllers.append(child_10)

        let child_11 = GeneralCollectionViewController(collectionViewLayout: layout, tagId: 1069, type: API.Types.new)
        child_11.tabTitle = L10n.tabTitleGreatestHits
        viewControllers.append(child_11)
        
        viewControllers.forEach { (controller) in
            barItems.append(Item(title: controller.tabTitle))
        }
    }
}
