//
//  LTAdvancedManagerDemo.swift
//  LTScrollView_Example
//
//  Created by 高刘通 on 2018/2/3.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//
//  如有疑问，请搜索并关注微信公众号"技术大咖社"并留言即可
//
//  ScrollView嵌套ScrolloView解决方案（初级、进阶)， 支持OC/Swift
//
//  github地址: https://github.com/gltwy/LTScrollView
//
//  clone地址:  https://github.com/gltwy/LTScrollView.git
//

import UIKit

class LTAdvancedManagerDemo: UIViewController {
    
    private lazy var viewControllers: [UIViewController] = {
        let oneVc = LTAdvancedTestOneVC()
        let twoVc = LTAdvancedTestOneVC()
        twoVc.count = 25
        let threeVc = LTAdvancedTestOneVC()
        let fourVc = LTAdvancedTestOneVC()
        return [oneVc, twoVc, threeVc, fourVc]
    }()
    
    private lazy var titles: [String] = {
        return ["热门", "精彩推荐", "科技控", "游戏"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 20
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private func managerReact() -> CGRect {
        let Y: CGFloat = GLT_NAVCHEIGHT
        let H: CGFloat = glt_iphoneX ? (view.bounds.height - Y - 34) : view.bounds.height - Y
        return CGRect(x: 0, y: Y, width: view.bounds.width, height: H)
    }
    
    private lazy var advancedManager: LTAdvancedManager = {
        let advancedManager = LTAdvancedManager(frame: managerReact(), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, /*itemViewClass: LTCustomTitleItemView.self*/ headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.testLabel()
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        
        /* 设置悬停位置 */
        //        advancedManager.hoverY = 64
        
        /* 点击切换滚动过程动画 */
        //        advancedManager.isClickScrollAnimation = true
        
        /* 代码设置滚动到第几个位置 */
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
        
        return advancedManager
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
    }
    
    deinit {
        print("LTAdvancedManagerDemo < --> deinit")
    }
    
}

extension LTAdvancedManagerDemo: LTAdvancedScrollViewDelegate {
    
    //MARK: 具体使用请参考以下
    private func advancedManagerConfig() {
        //MARK: 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
        
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        print("offset --> ", offsetY)
    }
}


extension LTAdvancedManagerDemo {
    private func testLabel() -> LTHeaderView {
        return LTHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 180))
    }
}

