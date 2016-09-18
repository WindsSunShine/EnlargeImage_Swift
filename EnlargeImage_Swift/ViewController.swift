//
//  ViewController.swift
//  EnlargeImage_Swift
//
//  Created by 张建军 on 16/9/18.
//  Copyright © 2016年 张建军. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    
    
    let SCREEN_WITDH = UIScreen.mainScreen().bounds.size.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    
    var imageView = UIImageView()
    
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView = UIImageView(image: UIImage(named: "beautiful.jpg"))
        
        imageView.frame = CGRectMake(0, 0, SCREEN_WITDH, SCREEN_HEIGHT)
        
        creatScrollView()
        
        recenterImage()
        
    }
    
    
    
    override func viewWillLayoutSubviews() {
        
       super.viewWillLayoutSubviews()
        
        
       setZoomScaleFor(scrollView.bounds.size)
        
        if scrollView.zoomScale < scrollView.minimumZoomScale {
            
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
            recenterImage()
        
    }
    
    
    private func creatScrollView() {
        
        
        scrollView = UIScrollView(frame:view.bounds)
        
        scrollView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        
        scrollView.backgroundColor = UIColor.clearColor()
        
        scrollView.delegate = self
        
        setZoomScaleFor(scrollView.bounds.size)
        
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        scrollView.contentSize = imageView.bounds.size
        
        scrollView.addSubview(imageView)
        
        view.addSubview(scrollView)
        
    }
    
    
    private func setZoomScaleFor(scrollViewSize:CGSize) {
        
        
        let imageSize = imageView.bounds.size
        
        let widthScale = scrollViewSize.width / imageSize.width
        
        let heightScale = scrollViewSize.height / imageSize.height
        
        
        let minimunScale = min(widthScale,heightScale)
        scrollView.minimumZoomScale = minimunScale
        
        scrollView.maximumZoomScale = 3.0
        
        
        
        
        
    }
    
    
    
  //将图片缩放过程中居中显示
    private func recenterImage() {
        
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size
        
        let horizontalSpace = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0
        
        let verticalSpace = imageViewSize.height <  scrollViewSize.height ? (scrollViewSize.height - imageViewSize.width) / 2.0 : 0
        
        
       scrollView.contentInset =  UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace)
    
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return self.imageView
    }
    
    
    func scrollViewDidZoom(scrollView: UIScrollView){
        
        self.recenterImage()
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

