//
//  ImageViewController.swift
//  BrnRng
//
//  Created by Tatyana Lomonosova on 7/17/14.
//  Copyright (c) 2014 Tanchey. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBAction func back(AnyObject) {
        self.dismissModalViewControllerAnimated(true)
    }

    @IBOutlet var imageView: UIImageView

    var imageUrl: NSURL?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.setImageWithURL(imageUrl)
    }

}
