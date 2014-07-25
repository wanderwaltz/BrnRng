//
//  ParseHelpers.swift
//  BrnRng
//
//  Created by Tatyana Lomonosova on 7/17/14.
//  Copyright (c) 2014 Tanchey. All rights reserved.
//

import Foundation


extension String {
    func stringBetweenStrings(start : String?, end : String?) -> String? {
        let startRange = start ? self.rangeOfString(start!, options: .WidthInsensitiveSearch | .CaseInsensitiveSearch, range: nil, locale: nil) : Range(start: self.startIndex, end: self.startIndex)
        if !startRange.isEmpty {
            let endRange = end ? self.rangeOfString(end!, options: .WidthInsensitiveSearch | .CaseInsensitiveSearch, range: nil, locale: nil) : Range(start: self.endIndex, end: self.endIndex)
            if !endRange.isEmpty {
                let targetRange = Range(start: startRange.endIndex, end: endRange.startIndex)
                return self.substringWithRange(targetRange)
            }
        }
        return nil;
    }

    func clean() -> String {
        return
            self.stringByReplacingOccurrencesOfString(
                "&nbsp;",
                withString: " ",
                options: .WidthInsensitiveSearch,
                range: nil).stringByReplacingOccurrencesOfString(
                    "<br />",
                    withString: "\n",
                    options: .WidthInsensitiveSearch,
                    range: nil).removeMultipleWhitespaces()
    }

    func removeMultipleWhitespaces() -> String {
        let regex = NSRegularExpression.regularExpressionWithPattern(
            "\\s\\s+",
            options:.CaseInsensitive,
            error:nil)
        let string: NSString = self
        return regex.stringByReplacingMatchesInString(
            string,
            options: .ReportCompletion,
            range: NSMakeRange(0, string.length),
            withTemplate: " ")
    }
}


extension NSData {
    func removeMultipleWhitespaces() -> NSData {
        let regex = NSRegularExpression.regularExpressionWithPattern(
            "\\s\\s+",
            options:.CaseInsensitive,
            error:nil)
        let string = NSString(data: self, encoding: NSUTF8StringEncoding) as String
        return string.removeMultipleWhitespaces().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
    }
}


extension TFHppleElement {
    func extractTextAndImages() -> (String?, NSURL?) {
        var textContainer: String? = nil
        var imageUrl: NSURL? = nil
        for maybeChild : AnyObject in self.children {
            if let child = maybeChild as? TFHppleElement {
                if child.content {
                    if textContainer {
                        textContainer = textContainer!.stringByAppendingString(child.content)
                    } else {
                        textContainer = child.content
                    }
                }
                if child.tagName == "img" {
                    imageUrl = NSURL(string: String(child.attributes["src"] as NSString))
                }
            }
        }
        return (textContainer ? textContainer!.clean() : nil, imageUrl)
    }

}

