//
//  AddCardViewController.swift
//  Scandiggo
//
//  Created by WTS on 29/01/16.
//  Copyright © 2016 wings. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    var frame = CGRect()
    
    var colors:[UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AddCardViewController")
        
        configurePageControl()
        
        scrollView.delegate = self
        scrollView.layer.borderWidth = 1
        for index in 0..<3 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.origin.y = 0
            frame.size = self.scrollView.frame.size
            self.scrollView.pagingEnabled = true
            
            var subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.scrollView .addSubview(subView)
            
        }
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: Selector("changePage:"), forControlEvents: UIControlEvents.ValueChanged)

    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        
//        self.pageControl.numberOfPages = colors.count
//        self.pageControl.currentPage = 0
//        self.pageControl.tintColor = UIColor.redColor()
//        self.pageControl.pageIndicatorTintColor = UIColor.blackColor()
//        self.pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        //self.view.addSubview(pageControl)
        
    }
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPointMake(x, 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }

}
