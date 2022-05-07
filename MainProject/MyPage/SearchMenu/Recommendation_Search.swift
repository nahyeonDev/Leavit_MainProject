//
//  Recommendation_Search.swift
//  MainProject
//
//  Created by 신예진 on 2022/04/27.
//

import UIKit
import PagingKit

class Recommendation_Search: UIViewController {
    
    @IBOutlet weak var rsMenuView: UIView!
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    static var viewController: (UIColor) -> UIViewController = { (color) in
           let vc = UIViewController()
            vc.view.backgroundColor = color
            return vc
        }
        
    var dataSource = [(menu: String, content: UIViewController)]() {
        didSet{
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        menuViewController.register(nib: UINib(nibName: "MenuCell_RS", bundle: nil), forCellWithReuseIdentifier: "MenuCell_RS")
        menuViewController.registerFocusView(nib: UINib(nibName: "Focus_RS", bundle: nil))
        
        menuViewController.reloadData()
        contentViewController.reloadData()
        
        self.rsMenuView.layer.shadowOpacity = 0.1
        self.rsMenuView.layer.shadowColor = UIColor.black.cgColor
        self.rsMenuView.layer.shadowRadius = 10
        self.rsMenuView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        dataSource = makeDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self
            menuViewController.delegate = self // <- set menu delegate
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
        }
    }
    
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)] {
        let myMenuArray = ["발급 받은 추천서", "발급한 추천서"]
        
        return myMenuArray.map{
            let title = $0
            
            switch title {
            case "발급 받은 추천서":
                let vc = UIStoryboard(name: "MyPage_Main", bundle: nil).instantiateViewController(identifier: "RSFirstVC") as! RSFirstVC
                return (menu: title, content: vc)
            case "발급한 추천서":
                let vc = UIStoryboard(name: "MyPage_Main", bundle: nil).instantiateViewController(identifier: "RSSecondVC") as! RSSecondVC
                return (menu: title, content: vc)
            default:
                let vc = UIStoryboard(name: "MyPage_Main", bundle: nil).instantiateViewController(identifier: "RSFirstVC") as! RSFirstVC
                return (menu: title, content: vc)
            }
        }
    }
}

extension Recommendation_Search: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 195
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell_RS", for: index) as! MenuCell_RS
        cell.titleLabel.text = dataSource[index].menu
        return cell
    }
}

extension Recommendation_Search: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

extension Recommendation_Search: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

extension Recommendation_Search: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
