//
//  BrnRngTests.swift
//  BrnRngTests
//
//  Created by Tatyana Lomonosova on 7/14/14.
//  Copyright (c) 2014 Tanchey. All rights reserved.
//

import XCTest

class BrnRngTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        let string = "<div class=\"razdatka\"><div class=\"razdatka_header\">Раздаточный материал</div>\n<br />\n    К тому же наш \"главный начальник\", А.В. Федоров, оказался не в силах \nорганизовать людей и, хотя он был [ПРОПУСК], но особой смелостью не\n отличался.\n<br />\n    </div>\n<br />\n    Перед вами отрывок из воспоминаний одного из ополченцев, участников\n обороны Ленинграда от немцев. Восстановите пропущенные слова, одно из\n которых является фамилией."
        XCTAssert(string.stringByReplacingOccurrencesOfString(
            "<br />",
            withString: "\n",
            options: .WidthInsensitiveSearch,
            range: nil) == "<div class=\"razdatka\"><div class=\"razdatka_header\">Раздаточный материал</div>\n\n\n    К тому же наш \"главный начальник\", А.В. Федоров, оказался не в силах \nорганизовать людей и, хотя он был [ПРОПУСК], но особой смелостью не\n отличался.\n\n\n    </div>\n\n\n    Перед вами отрывок из воспоминаний одного из ополченцев, участников\n обороны Ленинграда от немцев. Восстановите пропущенные слова, одно из\n которых является фамилией.", "Pass")
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
