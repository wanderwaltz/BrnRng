//
//  Question.swift
//  BrnRng
//
//  Created by Tatyana Lomonosova on 7/14/14.
//  Copyright (c) 2014 Tanchey. All rights reserved.
//

import Foundation

struct Question : Printable {

    var text: (String?, NSURL?)
    var answer: (String?, NSURL?)
    var comment: (String?, NSURL?)
    var handout: (String?, NSURL?)

    init(node: TFHppleElement) {
        text = node.extractTextAndImages()
        if let maybeHandout = node.searchWithXPathQuery("//div[@class='razdatka']"){
            if maybeHandout.count > 0 {
                let definitelyHandout = maybeHandout[0] as TFHppleElement
                handout = definitelyHandout.extractTextAndImages()
            }
        }
        let components = node.searchWithXPathQuery("//div[@class='collapsible collapsed']/p")
        for item: AnyObject in components {
            if let component = item as? TFHppleElement {
                if let prepareName = component.searchWithXPathQuery("//strong") {
                    if prepareName.count > 0 {
                        if let name: AnyObject = prepareName[0] as? TFHppleElement {
                            if name.text! == "Ответ:" {
                                answer = component.extractTextAndImages()
                            }
                            else if name.text! == "Комментарий:" {
                                comment = component.extractTextAndImages()
                            }
                        }
                    }
                }
            }
        }
    }

    var description: String {
        return "\nQuestion: \n\(text)\nAnswer: \(answer)\n"
    }
}


