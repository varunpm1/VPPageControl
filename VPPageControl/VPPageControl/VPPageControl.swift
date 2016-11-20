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
    func pageControl(_ pageControl : VPPageControl, didSelectPageIndex pageIndex : Int)
}

enum PageControlType : Int {
    case roundedFilled = 0 // Circular with filled states. Default UIPageControl type. This is the default type
    case roundedBorder // Circular with border type. Only Border and border color will be representing the states
    case roundedBorderFilledSelected // Circular with border type. Border color will be representing the unselected state. Filled represents the selected state
    case roundedFilledBorderSelected // Circular with filled type. Filled color will be representing the unselected state. Border represents the selected state
    case squareFilled // Square with filled states. Fill color represent the states
    case squareBorder // Square with border type. Border color will be representing the states
    case squareBorderFilledSelected // Square with border type. Border color will be representing the unselected state. Filled represents the selected state
    case squareFilledBorderSelected // Square with filled type. Filled color will be representing the unselected state. Border represents the selected state
    case diamondFilled // Diamond with filled states. Fill color represent the states
    case diamondBorder // Diamond with border type. Border color will be representing the states
    case diamondBorderFilledSelected // Diamond with border type. Border color will be representing the unselected state. Filled represents the selected state
    case diamondFilledBorderSelected // Diamond with filled type. Filled color will be representing the unselected state. Border represents the selected state
}

class VPPageControl: UIView {
    
    fileprivate let pageControlSpacing : CGFloat = 7
    fileprivate let pageControlWidth : CGFloat = 7
    
    // The type that represent the page control UI
    var pageControlType = PageControlType.roundedFilled
    
    // The number of pages in page control
    @IBInspectable var numberOfPages : Int = 0 {
        didSet {
            setPageControlUI()
        }
    }
    
    // The current selected page. Defaults to 0.
    @IBInspectable var currentPage : Int = 0
    
    // The unselected page control tintColor. Defaults to whiteColor.
    @IBInspectable var pageIndicatorTintColor : UIColor = UIColor.white
    
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchObject = touches.first
        
        let startX = (bounds.size.width - CGFloat(numberOfPages) * pageControlWidth - CGFloat(numberOfPages - 1) * pageControlSpacing) / 2
        let touchPoint = touchObject?.location(in: self)
        
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
                
                UIView.animate(withDuration: 0.15, animations: {
                    let currentPageControlView = self.viewWithTag(self.currentPage + 1)
                    self.setUIForPageControlView(currentPageControlView, withIndex: self.currentPage)
                })
                
                delegate?.pageControl(self, didSelectPageIndex: currentPage)
            }
        }
    }
    
    //MARK: Update UI
    fileprivate func updatePageControlViews() {
        // Calculate the start X point for first page control
        var startX = (bounds.size.width - CGFloat(numberOfPages) * pageControlWidth - CGFloat(numberOfPages - 1) * pageControlSpacing) / 2
        
        for pageControlIndex in stride(from: 0, to: numberOfPages, by: 1) {
            let pageControlView = viewWithTag(pageControlIndex + 1)
            pageControlView?.center = CGPoint(x: (startX + pageControlWidth / 2), y: bounds.midY)
            setUIForPageControlView(pageControlView, withIndex: pageControlIndex)
            
            startX += pageControlSpacing + pageControlWidth
        }
    }
    
    fileprivate func setUIForPageControlView(_ pageControlView : UIView?, withIndex pageControlIndex : Int) {
        switch pageControlType {
        case .roundedFilled:
            createRoundedPageControl(pageControlView)
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
            
        case .roundedBorder:
            createRoundedPageControl(pageControlView)
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
            
        case .roundedBorderFilledSelected:
            createRoundedPageControl(pageControlView)
            createBorderFilledSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
            
        case .roundedFilledBorderSelected:
            createRoundedPageControl(pageControlView)
            createFilledBorderSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
        case .squareFilled:
            createSquarePageControl(pageControlView)
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
            
        case .squareBorder:
            createSquarePageControl(pageControlView)
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
            
        case .squareBorderFilledSelected:
            createSquarePageControl(pageControlView)
            createBorderFilledSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
        case .squareFilledBorderSelected:
            createSquarePageControl(pageControlView)
            createFilledBorderSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
        case .diamondFilled:
            createSquarePageControl(pageControlView)
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
            createDiamondPageControl(pageControlView)
            
        case .diamondBorder:
            createSquarePageControl(pageControlView)
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
            createDiamondPageControl(pageControlView)
            
        case .diamondBorderFilledSelected:
            createSquarePageControl(pageControlView)
            createDiamondPageControl(pageControlView)
            createBorderFilledSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            
        case .diamondFilledBorderSelected:
            createSquarePageControl(pageControlView)
            createDiamondPageControl(pageControlView)
            createFilledBorderSelectedState(pageControlView, pageControlIndex: pageControlIndex)
        }
    }
    
    //MARK: Init UI
    fileprivate func setPageControlUI() {
        for pageControlIndex in stride(from: 0, to: numberOfPages, by: 1) {
            addSubview(getPageControlForIndex(pageControlIndex))
        }
    }
    
    fileprivate func getPageControlForIndex(_ index : Int) -> UIView {
        let pageControlView = UIView(frame: CGRect(x: 0, y: 0, width: pageControlWidth, height: pageControlWidth))
        pageControlView.tag = index + 1
        
        return pageControlView
    }
    
    //MARK: Helper methods
    fileprivate func getPageControlColorForIndex(_ index : Int) -> UIColor {
        return (currentPage == index) ? currentPageIndicatorTintColor : pageIndicatorTintColor
    }
    
    // Create pageControl shapes
    fileprivate func createRoundedPageControl(_ pageControlView : UIView?) {
        pageControlView?.layer.cornerRadius = pageControlWidth / 2
        pageControlView?.layer.masksToBounds = true
    }
    
    fileprivate func createSquarePageControl(_ pageControlView : UIView?) {
        pageControlView?.layer.cornerRadius = 0.0
        pageControlView?.layer.masksToBounds = true
    }
    
    fileprivate func createDiamondPageControl(_ pageControlView : UIView?) {
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: CGFloat(M_PI_4))
        pageControlView?.transform = transform
    }
    
    // Create pageControl displayColor
    fileprivate func createBorderPageControl(_ pageControlView : UIView?, pageControlIndex : Int) {
        pageControlView?.layer.borderWidth = 1.0
        pageControlView?.layer.borderColor = getPageControlColorForIndex(pageControlIndex).cgColor
        pageControlView?.backgroundColor = UIColor.clear
    }
    
    fileprivate func createFilledPageControl(_ pageControlView : UIView?, pageControlIndex : Int) {
        pageControlView?.layer.borderWidth = 0.0
        pageControlView?.backgroundColor = getPageControlColorForIndex(pageControlIndex)
        pageControlView?.layer.borderColor = UIColor.clear.cgColor
    }
    
    // Create pageControl BorderFilledSelected state
    fileprivate func createBorderFilledSelectedState(_ pageControlView : UIView?, pageControlIndex : Int) {
        if currentPage != pageControlIndex {
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
        else {
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
    }
    
    // Create pageControl FilledBorderSelected state
    fileprivate func createFilledBorderSelectedState(_ pageControlView : UIView?, pageControlIndex : Int) {
        if currentPage == pageControlIndex {
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
        else {
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
    }
}
