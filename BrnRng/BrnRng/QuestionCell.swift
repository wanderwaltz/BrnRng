//
//  QuestionCell.swift
//  BrnRng
//
//  Created by Tatyana Lomonosova on 7/15/14.
//  Copyright (c) 2014 Tanchey. All rights reserved.
//

import UIKit

class QuestionCell: UICollectionViewCell {

    var isLast: Bool {
        get {
            return self.nextButton.hidden
        }
        set(newIsLast) {
            self.nextButton.hidden = newIsLast
        }
    }
    var isFirst: Bool {
        get {
            return self.nextButton.hidden
        }
        set(newIsFirst) {
            self.previousButton.hidden = newIsFirst
        }
    }

    var goBack: (()->Void)?
    var goPrevious: (()->Void)?
    var goNext: (()->Void)?
    
    var imageHeight: CGFloat = 0.0

    @IBOutlet var textLabel: UILabel!
    @IBOutlet var textImageButton: UIButton!
    @IBOutlet var textImage: UIImageView!

    @IBOutlet var handoutLabel: UILabel!
    @IBOutlet var handoutImageButton: UIButton!

    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var answerImageButton: UIButton!

    @IBOutlet var commentLabel: UILabel!

    @IBOutlet var showAnswerButton: UIButton!

    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!

    @IBOutlet var widthConstraint: NSLayoutConstraint!

    @IBOutlet var textHeightConstraint: NSLayoutConstraint!
    @IBOutlet var textImageHeightConstraint: NSLayoutConstraint!

    @IBOutlet var handoutHeightConstraint: NSLayoutConstraint!
    @IBOutlet var handoutImageHeightConstraint: NSLayoutConstraint!

    @IBOutlet var answerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var answerImageHeightConstraint: NSLayoutConstraint!

    @IBOutlet var commentHeightConstraint: NSLayoutConstraint!

    @IBOutlet var showAnswerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var leftMarginConstraint: NSLayoutConstraint!
    @IBOutlet var rightMarginConstraint: NSLayoutConstraint!
    @IBOutlet var answerCommentConstraint: NSLayoutConstraint!

    @IBOutlet var scrollContentView: UIView!
    @IBOutlet var scrollView: UIScrollView!


    @IBAction func back(AnyObject) {
        if (self.goBack != nil) {
            self.goBack!()
        }
    }
    @IBAction func next(AnyObject) {
        if (self.goNext != nil) {
            self.goNext!()
        }
    }

    @IBAction func previous(AnyObject) {
        if (self.goPrevious != nil) {
            self.goPrevious!()
        }
    }

    @IBAction func showAnswer(AnyObject) {
        UIView.animateWithDuration(0.3, animations: {
            self.showAnswerButton.alpha = 0
            })
    }
// (UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    func fillWithQuestion(question: Question) {
        self.textLabel.text = question.text.0
        self.textImage.sd_setImageWithURL(question.text.1, completed:{ (image: UIImage!,
            error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) in
                self.layoutImages()
            })
        self.answerLabel.text = question.answer.0
        self.commentLabel.text = question.comment.0
        self.setNeedsLayout()
    }

    override func prepareForReuse() {
        self.showAnswerButton.alpha = 1
        self.isFirst = false
        self.isLast = false
        self.textImage.sd_setImageWithURL(nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        imageHeight = self.textImageHeightConstraint.constant

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.widthConstraint.constant =
            self.frame.size.width - self.leftMarginConstraint.constant - self.rightMarginConstraint.constant;
        self.scrollContentView.setNeedsLayout()
        self.scrollContentView.layoutIfNeeded()

        self.textLabel.frame.size.height = CGFloat.max
        let tsize = self.textLabel.sizeThatFits(textLabel.frame.size)
        self.textHeightConstraint.constant = tsize.height

        self.layoutImages()

        self.answerLabel.frame.size.height = CGFloat.max
        let asize = self.answerLabel.sizeThatFits(textLabel.frame.size)
        self.answerHeightConstraint.constant = asize.height

        self.commentLabel.frame.size.height = CGFloat.max
        let csize = self.commentLabel.sizeThatFits(textLabel.frame.size)
        self.commentHeightConstraint.constant = csize.height

        self.showAnswerHeightConstraint.constant = asize.height + csize.height +
            self.answerCommentConstraint.constant

        self.scrollContentView.setNeedsLayout()
        self.scrollContentView.layoutIfNeeded()
    }

    func layoutImages() {
        if let image = self.textImage.image {
            self.textImageHeightConstraint.constant = self.widthConstraint.constant * image.size.height / image.size.width
        }
        else {
            self.textImageHeightConstraint.constant = 0
        }
    }
}

