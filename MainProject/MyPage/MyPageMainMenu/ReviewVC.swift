//
//  ReviewVC.swift
//  MainProject
//
//  Created by 신예진 on 2022/04/28.
//

import UIKit
import PagingKit

class ReviewVC: UIViewController {
    
    @IBOutlet weak var reviewMenuView: UIView!
    
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

        menuViewController.register(nib: UINib(nibName: "MenuCell_ReviewVC", bundle: nil), forCellWithReuseIdentifier: "MenuCell_ReviewVC")
        menuViewController.registerFocusView(nib: UINib(nibName: "Focus_ReviewVC", bundle: nil))
        
        menuViewController.reloadData()
        contentViewController.reloadData()
        
        self.reviewMenuView.layer.shadowOpacity = 0.1
        self.reviewMenuView.layer.shadowColor = UIColor.black.cgColor
        self.reviewMenuView.layer.shadowRadius = 10
        self.reviewMenuView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
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
        let myMenuArray = ["구직", "구인"]
        
        return myMenuArray.map{
            let title = $0
            
            switch title {
            case "구직":
                let vc = UIStoryboard(name: "MyPage_Main", bundle: nil).instantiateViewController(identifier: "ReviewFirstVC") as! ReviewFirstVC
                return (menu: title, content: vc)
            case "구인":
                let vc = UIStoryboard(name: "MyPage_Main", bundle: nil).instantiateViewController(identifier: "ReviewSecondVC") as! ReviewSecondVC
                return (menu: title, content: vc)
            default:
                let vc = UIStoryboard(name: "MyPage_Main", bundle: nil).instantiateViewController(identifier: "ReviewFirstVC") as! ReviewFirstVC
                return (menu: title, content: vc)
            }
        }
    }
}

extension ReviewVC: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 195
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell_ReviewVC", for: index) as! MenuCell_ReviewVC
        cell.titleLabel.text = dataSource[index].menu
        return cell
    }
}

extension ReviewVC: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

extension ReviewVC: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

extension ReviewVC: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
