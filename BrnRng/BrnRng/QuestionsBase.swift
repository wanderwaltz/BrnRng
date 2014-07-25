//
//  QuestionsBase.swift
//  BrnRng
//
//  Created by Tatyana Lomonosova on 7/15/14.
//  Copyright (c) 2014 Tanchey. All rights reserved.
//

import Foundation

let questionsBaseUrl = "http://db.chgk.info/random/from_2012-01-01/complexity2"

struct QuestionsBase : Printable {

    var questions: Question[] = Question[]()

    init() {
        let path = NSBundle.mainBundle().pathForResource("db0", ofType: "html")

        if let data = NSData.dataWithContentsOfFile(path, options: NSDataReadingOptions.DataReadingMappedIfSafe, error:nil) {
            questions = parse(data)
        }
    }
    
    init(number: Int) {
        let path = NSBundle.mainBundle().pathForResource("db\(number)", ofType: "html")

        if let data = NSData.dataWithContentsOfFile(path, options: NSDataReadingOptions.DataReadingMappedIfSafe, error:nil) {
            questions = parse(data)
        }
    }
    
    init(urlString: String) {
        if let data = NSData.dataWithContentsOfURL(NSURL.URLWithString(urlString), options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil) {
            questions = parse(data)
        }
    }

    var description: String {
    return "\n\(questions)"
    }

    func parse(data : NSData) -> Question[] {
        var qs = Question[]()
        if let tutorialsParser = TFHpple.hppleWithHTMLData(data.removeMultipleWhitespaces()) {
            let tutorialsXpathQueryString = "//div[@class='random-results']/div[@class='random_question']";
            let tutorialsNodes = tutorialsParser.searchWithXPathQuery(tutorialsXpathQueryString);
            for item : AnyObject in tutorialsNodes {
                if let element = item as? TFHppleElement {
                    let question = Question(node: element)
                    if question.text.0 && question.answer.0 {
                        qs.append(question)
                    }
                }
            }
        }
        return qs
    }
}