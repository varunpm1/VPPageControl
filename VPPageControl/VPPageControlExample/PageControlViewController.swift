//
//  PageControlViewController.swift
//  PageControl
//
//  Created by Varun on 08/06/16.
//  Copyright © 2016 VPM. All rights reserved.
//

import UIKit

class PageControlViewController: UIViewController {

    @IBOutlet weak var pageControlView1: VPPageControl!
    @IBOutlet weak var pageControlView2: VPPageControl!
    @IBOutlet weak var pageControlView3: VPPageControl!
    @IBOutlet weak var pageControlView4: VPPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControlView1.numberOfPages = 4
        pageControlView1.currentPage = 0
        pageControlView1.pageIndicatorTintColor = UIColor.blackColor()
        pageControlView1.currentPageIndicatorTintColor = UIColor.redColor()
        pageControlView1.pageControlType = PageControlType.RoundedFilled
        pageControlView1.delegate = self
        
        pageControlView2.numberOfPages = 4
        pageControlView2.currentPage = 0
        pageControlView2.pageIndicatorTintColor = UIColor.blackColor()
        pageControlView2.currentPageIndicatorTintColor = UIColor.redColor()
        pageControlView2.pageControlType = PageControlType.SquareFilled
        pageControlView2.delegate = self
        
        pageControlView3.numberOfPages = 4
        pageControlView3.currentPage = 0
        pageControlView3.pageIndicatorTintColor = UIColor.blackColor()
        pageControlView3.currentPageIndicatorTintColor = UIColor.redColor()
        pageControlView3.pageControlType = PageControlType.DiamondBorderFilledSelected
        pageControlView3.delegate = self
        
        pageControlView4.numberOfPages = 4
        pageControlView4.currentPage = 0
        pageControlView4.pageIndicatorTintColor = UIColor.blackColor()
        pageControlView4.currentPageIndicatorTintColor = UIColor.redColor()
        pageControlView4.pageControlType = PageControlType.SquareBorderFilledSelected
        pageControlView4.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PageControlViewController : PageControlDelegate {
    func pageControl(pageControl: VPPageControl, didSelectPageIndex pageIndex: Int) {
        switch pageIndex {
        case 0:
            pageControl.backgroundColor = UIColor.whiteColor()
            
        case 1:
            pageControl.backgroundColor = UIColor.yellowColor()
            
        case 2:
            pageControl.backgroundColor = UIColor.greenColor()
            
        case 3:
            pageControl.backgroundColor = UIColor.darkGrayColor()
            
        default:
            pageControl.backgroundColor = UIColor.whiteColor()
        }
    }
}
