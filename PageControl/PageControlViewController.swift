//
//  PageControlViewController.swift
//  PageControl
//
//  Created by Varun on 08/06/16.
//  Copyright © 2016 VPM. All rights reserved.
//

import UIKit

class PageControlViewController: UIViewController {

    @IBOutlet weak var pageControlView: PageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControlView.numberOfPages = 4
        pageControlView.currentPage = 0
        pageControlView.pageIndicatorTintColor = UIColor.blackColor()
        pageControlView.currentPageIndicatorTintColor = UIColor.redColor()
        pageControlView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PageControlViewController : PageControlDelegate {
    func pageControl(pageControl: PageControl, didSelectPageIndex pageIndex: Int) {
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
