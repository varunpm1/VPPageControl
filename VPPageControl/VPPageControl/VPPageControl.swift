//
//  VPPageControl.swift
//  PageControl
//  Version 1.0.0
//
//  Created by Varun on 08/06/16.
//  Copyright © 2016 VPM. All rights reserved.
//
//
//The MIT License (MIT)
//
//Copyright (c) 2016 Varun P M
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import UIKit

protocol PageControlDelegate : class {
    // Called whenever the pageControl view is tapped.
    func pageControl(pageControl : VPPageControl, didSelectPageIndex pageIndex : Int)
}

enum PageControlType : Int {
    case RoundedFilled = 0 // Circular with filled states. Default UIPageControl type. This is the default type
    case RoundedBorder // Circular with border type. Only Border and border color will be representing the states
    case RoundedBorderFilledSelected // Circular with border type. Border color will be representing the unselected state. Filled represents the selected state
    case RoundedFilledBorderSelected // Circular with filled type. Filled color will be representing the unselected state. Border represents the selected state
    case SquareFilled // Square with filled states. Fill color represent the states
    case SquareBorder // Square with border type. Border color will be representing the states
    case SquareBorderFilledSelected // Square with border type. Border color will be representing the unselected state. Filled represents the selected state
    case SquareFilledBorderSelected // Square with filled type. Filled color will be representing the unselected state. Border represents the selected state
    case DiamondFilled // Diamond with filled states. Fill color represent the states
    case DiamondBorder // Diamond with border type. Border color will be representing the states
    case DiamondBorderFilledSelected // Diamond with border type. Border color will be representing the unselected state. Filled represents the selected state
    case DiamondFilledBorderSelected // Diamond with filled type. Filled color will be representing the unselected state. Border represents the selected state
}

class VPPageControl: UIView {
    
    private let pageControlSpacing : CGFloat = 7
    private let pageControlWidth : CGFloat = 7
    
    // The type that represent the page control UI
    var pageControlType = PageControlType.RoundedFilled
    
    // The number of pages in page control
    @IBInspectable var numberOfPages : Int = 0 {
        didSet {
            setPageControlUI()
        }
    }
    
    // The current selected page. Defaults to 0.
    @IBInspectable var currentPage : Int = 0
    
    // The unselected page control tintColor. Defaults to whiteColor.
    @IBInspectable var pageIndicatorTintColor : UIColor = UIColor.whiteColor()
    
    // The selected page control tintColor. Defaults to whiteColor with 50% opacity
    @IBInspectable var currentPageIndicatorTintColor : UIColor = UIColor.init(white: 1.0, alpha: 0.5)
    
    // The delegate for handling changes in page control states.
    weak var delegate : PageControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updatePageControlViews()
    }
    
    //MARK: Handle the tap of page control
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchObject = touches.first
        
        let startX = (bounds.size.width - CGFloat(numberOfPages) * pageControlWidth - CGFloat(numberOfPages - 1) * pageControlSpacing) / 2
        let touchPoint = touchObject?.locationInView(self)
        
        if let touchPoint = touchPoint {
            // pageControlWidth / 2 for midPoint identification
            let tempPageControlSpacing = (touchPoint.x - startX - pageControlWidth / 2)
            let selectedIndex = Int(round(tempPageControlSpacing / (pageControlWidth + pageControlSpacing)))
            
            if selectedIndex >= 0 && selectedIndex < numberOfPages {
                // Reset the previous pageControlView color
                let previousPageControlIndex = currentPage
                currentPage = selectedIndex
                
                let pageControlView = viewWithTag(previousPageControlIndex + 1)
                setUIForPageControlView(pageControlView, withIndex: previousPageControlIndex)
                
                UIView.animateWithDuration(0.15, animations: {
                    let currentPageControlView = self.viewWithTag(self.currentPage + 1)
                    self.setUIForPageControlView(currentPageControlView, withIndex: self.currentPage)
                })
                
                delegate?.pageControl(self, didSelectPageIndex: currentPage)
            }
        }
    }
    
    //MARK: Update UI
    private func updatePageControlViews() {
        // Calculate the start X point for first page control
        var startX = (bounds.size.width - CGFloat(numberOfPages) * pageControlWidth - CGFloat(numberOfPages - 1) * pageControlSpacing) / 2
        
        for pageControlIndex in 0.stride(to: numberOfPages, by: 1) {
            let pageControlView = viewWithTag(pageControlIndex + 1)
            pageControlView?.center = CGPoint(x: (startX + pageControlWidth / 2), y: bounds.midY)
            setUIForPageControlView(pageControlView, withIndex: pageControlIndex)
            
            startX += pageControlSpacing + pageControlWidth
        }
    }
    
    private func setUIForPageControlView(pageControlView : UIView?, withIndex pageControlIndex : Int) {
        switch pageControlType {
        case .RoundedFilled:
            createRoundedPageControl(pageControlView)
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
            
        case .RoundedBorder:
            createRoundedPageControl(pageControlView)
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
            
        case .RoundedBorderFilledSelected:
            createRoundedPageControl(pageControlView)
            createBorderFilledSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
            
        case .RoundedFilledBorderSelected:
            createRoundedPageControl(pageControlView)
            createFilledBorderSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
        case .SquareFilled:
            createSquarePageControl(pageControlView)
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
            
        case .SquareBorder:
            createSquarePageControl(pageControlView)
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
            
        case .SquareBorderFilledSelected:
            createSquarePageControl(pageControlView)
            createBorderFilledSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
        case .SquareFilledBorderSelected:
            createSquarePageControl(pageControlView)
            createFilledBorderSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
        case .DiamondFilled:
            createSquarePageControl(pageControlView)
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
            createDiamondPageControl(pageControlView)
            
        case .DiamondBorder:
            createSquarePageControl(pageControlView)
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
            createDiamondPageControl(pageControlView)
            
        case .DiamondBorderFilledSelected:
            createSquarePageControl(pageControlView)
            createDiamondPageControl(pageControlView)
            createBorderFilledSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
        case .DiamondFilledBorderSelected:
            createSquarePageControl(pageControlView)
            createDiamondPageControl(pageControlView)
            createFilledBorderSelectedState(pageControlView, pageControlIndex: pageControlIndex)
        }
    }
    
    //MARK: Init UI
    private func setPageControlUI() {
        for pageControlIndex in 0.stride(to: numberOfPages, by: 1) {
            addSubview(getPageControlForIndex(pageControlIndex))
        }
    }
    
    private func getPageControlForIndex(index : Int) -> UIView {
        let pageControlView = UIView(frame: CGRect(x: 0, y: 0, width: pageControlWidth, height: pageControlWidth))
        pageControlView.tag = index + 1
        
        return pageControlView
    }
    
    //MARK: Helper methods
    private func getPageControlColorForIndex(index : Int) -> UIColor {
        return (currentPage == index) ? currentPageIndicatorTintColor : pageIndicatorTintColor
    }
    
    // Create pageControl shapes
    private func createRoundedPageControl(pageControlView : UIView?) {
        pageControlView?.layer.cornerRadius = pageControlWidth / 2
        pageControlView?.layer.masksToBounds = true
    }
    
    private func createSquarePageControl(pageControlView : UIView?) {
        pageControlView?.layer.cornerRadius = 0.0
        pageControlView?.layer.masksToBounds = true
    }
    
    private func createDiamondPageControl(pageControlView : UIView?) {
        var transform = CGAffineTransformIdentity
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI_4))
        pageControlView?.transform = transform
    }
    
    // Create pageControl displayColor
    private func createBorderPageControl(pageControlView : UIView?, pageControlIndex : Int) {
        pageControlView?.layer.borderWidth = 1.0
        pageControlView?.layer.borderColor = getPageControlColorForIndex(pageControlIndex).CGColor
        pageControlView?.backgroundColor = UIColor.clearColor()
    }
    
    private func createFilledPageControl(pageControlView : UIView?, pageControlIndex : Int) {
        pageControlView?.layer.borderWidth = 0.0
        pageControlView?.backgroundColor = getPageControlColorForIndex(pageControlIndex)
        pageControlView?.layer.borderColor = UIColor.clearColor().CGColor
    }
    
    // Create pageControl BorderFilledSelected state
    private func createBorderFilledSelectedState(pageControlView : UIView?, pageControlIndex : Int) {
        if currentPage != pageControlIndex {
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
        else {
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
    }
    
    // Create pageControl FilledBorderSelected state
    private func createFilledBorderSelectedState(pageControlView : UIView?, pageControlIndex : Int) {
        if currentPage == pageControlIndex {
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
        else {
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
    }
}
