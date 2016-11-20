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
        pageControlView1.pageIndicatorTintColor = UIColor.black
        pageControlView1.currentPageIndicatorTintColor = UIColor.red
        pageControlView1.pageControlType = PageControlType.roundedFilled
        pageControlView1.delegate = self
        
        pageControlView2.numberOfPages = 4
        pageControlView2.currentPage = 0
        pageControlView2.pageIndicatorTintColor = UIColor.black
        pageControlView2.currentPageIndicatorTintColor = UIColor.red
        pageControlView2.pageControlType = PageControlType.squareFilled
        pageControlView2.delegate = self
        
        pageControlView3.numberOfPages = 4
        pageControlView3.currentPage = 0
        pageControlView3.pageIndicatorTintColor = UIColor.black
        pageControlView3.currentPageIndicatorTintColor = UIColor.red
        pageControlView3.pageControlType = PageControlType.diamondBorderFilledSelected
        pageControlView3.delegate = self
        
        pageControlView4.numberOfPages = 4
        pageControlView4.currentPage = 0
        pageControlView4.pageIndicatorTintColor = UIColor.black
        pageControlView4.currentPageIndicatorTintColor = UIColor.red
        pageControlView4.pageControlType = PageControlType.squareBorderFilledSelected
        pageControlView4.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PageControlViewController : PageControlDelegate {
    func pageControl(_ pageControl: VPPageControl, didSelectPageIndex pageIndex: Int) {
        switch pageIndex {
        case 0:
            pageControl.backgroundColor = UIColor.white
            
        case 1:
            pageControl.backgroundColor = UIColor.yellow
            
        case 2:
            pageControl.backgroundColor = UIColor.green
            
        case 3:
            pageControl.backgroundColor = UIColor.darkGray
            
        default:
            pageControl.backgroundColor = UIColor.white
        }
    }
}
