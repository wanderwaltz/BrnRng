//
//  QuestionViewController.swift
//  BrnRng
//
//  Created by Tatyana Lomonosova on 7/15/14.
//  Copyright (c) 2014 Tanchey. All rights reserved.
//

import UIKit

class QuestionViewController: UICollectionViewController, UIScrollViewDelegate {

    var questionBase: QuestionsBase = QuestionsBase()
    var currentIndex: Int = 0
    var baseNumber: Int = 0 {
        didSet(newBaseNumber) {
            self.questionBase = QuestionsBase(number: self.baseNumber)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout(self.collectionView!.bounds.size)
    }

    override func viewDidAppear(animated: Bool) {
        self.collectionView!.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.questionBase.questions.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("question", forIndexPath: indexPath) as! QuestionCell
        cell.fillWithQuestion(self.questionBase.questions[indexPath.item])
        cell.isLast = self.questionBase.questions.count == indexPath.item + 1
        cell.isFirst = indexPath.item == 0
        cell.goBack = ({
            self.dismissViewControllerAnimated(true, completion: nil)
            })
        cell.goNext = ({
            self.currentIndex = self.currentIndex + 1
            self.scrollToCurrentIndex()
            })
        cell.goPrevious = ({
            self.currentIndex = self.currentIndex - 1
            self.scrollToCurrentIndex()
            })
        return cell as UICollectionViewCell
    }

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        let size = self.collectionView!.bounds.size
        self.layout(CGSize(width: size.height, height: size.width))
    }

    func scrollToCurrentIndex() {
        self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: self.currentIndex, inSection: 0), atScrollPosition: .CenteredHorizontally, animated: true)
    }

    func layout(size: CGSize) {
        let layout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.invalidateLayout()
        self.collectionView!.contentSize = CGSizeMake(size.width * CGFloat(questionBase.questions.count), size.height)
    }

    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.currentIndex = Int(scrollView.contentOffset.x / self.collectionView!.frame.size.width)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let button = sender as? UIButton {
            let imageUrl = self.questionBase.questions[self.currentIndex].text.1
            if let vc = segue.destinationViewController as? ImageViewController {
                vc.imageUrl = imageUrl
            }
        }
    }
}
