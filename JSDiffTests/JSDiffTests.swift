//
//  JSDiffTests.swift
//  JSDiffTests
//
//  Created by Piet Brauer on 09/04/16.
//  Copyright © 2016 nerdish by nature. All rights reserved.
//

import XCTest
import JSDiff

class JSDiffTests: XCTestCase {
    func testChangedNumbers() {
        let oldLine = "<a id=\"appIcon\" href=\"https://itunes.apple.com/us/app/git2go-git-client-you-always/id963577401?mt=8\"><img style=\"height:125px; width:125px\" src=\"{{ site.url }}/img/App Icon 2 - 120.svg\" alt=\"Git2Go Icon\"></a>"
        let newLine = "<a id=\"appIcon\" href=\"https://itunes.apple.com/us/app/git2go-enterprise-git-client/id1079716387?ls=1&mt=8\"><img style=\"height:125px; width:125px\" src=\"{{ site.url }}/img/App Icon 2 - 120.svg\" alt=\"Git2Go Icon\"></a>"
        let jsDiff = JSDiff(deletedColor: Color.deletedColor(), deletedWordColor: Color.strongDeletedColor(), addedColor: Color.addedColor(), addedWordColor: Color.strongAddedColor())

        let expectedOldLine = NSMutableAttributedString(string: oldLine, attributes: [NSBackgroundColorAttributeName: Color.deletedColor()])
        expectedOldLine.addAttributes([NSBackgroundColorAttributeName: Color.strongDeletedColor()], range: (oldLine as NSString).rangeOfString("-you-always"))
        expectedOldLine.addAttributes([NSBackgroundColorAttributeName: Color.strongDeletedColor()], range: (oldLine as NSString).rangeOfString("id963577401"))

        let expectedNewLine = NSMutableAttributedString(string: newLine, attributes: [NSBackgroundColorAttributeName: Color.addedColor()])
        expectedNewLine.addAttributes([NSBackgroundColorAttributeName: Color.strongAddedColor()], range: (newLine as NSString).rangeOfString("enterprise-"))
        expectedNewLine.addAttributes([NSBackgroundColorAttributeName: Color.strongAddedColor()], range: (newLine as NSString).rangeOfString("id1079716387"))
        expectedNewLine.addAttributes([NSBackgroundColorAttributeName: Color.strongAddedColor()], range: (newLine as NSString).rangeOfString("ls=1&"))

        let result = jsDiff.diffWords(oldLine, newLine: newLine)
        XCTAssertEqual(result.oldLine, expectedOldLine)
        XCTAssertEqual(result.newLine, expectedNewLine)
    }
}
