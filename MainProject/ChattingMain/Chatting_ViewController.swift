//
//  Chatting_ViewController.swift
//  MainProject
//
//  Created by 신예진 on 2021/12/03.
//

import UIKit
import PagingKit

class Chatting_ViewController: UIViewController {
    
    @IBOutlet weak var ChattingMenuView: UIView!
    @IBOutlet weak var topView: UIView!
    
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

        // Do any additional setup after loading the view.
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        
        menuViewController.cellAlignment = .left
        
        menuViewController.reloadData()
        contentViewController.reloadData()
        
        self.ChattingMenuView.layer.shadowOpacity = 0.1
        self.ChattingMenuView.layer.shadowColor = UIColor.black.cgColor
        self.ChattingMenuView.layer.shadowRadius = 10
        self.ChattingMenuView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
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
                let vc = UIStoryboard(name: "Chatting_Main", bundle: nil).instantiateViewController(identifier: "FirstVC") as! FirstVC
                return (menu: title, content: vc)
            case "구인":
                let vc = UIStoryboard(name: "Chatting_Main", bundle: nil).instantiateViewController(identifier: "SecondVC") as! SecondVC
                return (menu: title, content: vc)
            default:
                let vc = UIStoryboard(name: "Chatting_Main", bundle: nil).instantiateViewController(identifier: "FirstVC") as! FirstVC
                return (menu: title, content: vc)
            }
        }
    }
    
}

//메뉴 데이터 소스
extension Chatting_ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 195
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        cell.titleLabel.text = dataSource[index].menu
        return cell
    }
}

//메뉴 컨트롤 델리게이트
extension Chatting_ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

//컨텐트 데이터 소스 (내용)
extension Chatting_ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

//컨텐트 컨트롤 델리게이트
extension Chatting_ViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        //내용이 스크롤 되면 메뉴를 스크롤 한다.
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
