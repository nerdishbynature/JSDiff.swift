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
        let jsDiff = JSDiff(deletedColor: UIColor.deletedColor(), deletedWordColor: UIColor.strongDeletedColor(), addedColor: UIColor.addedColor(), addedWordColor: UIColor.strongAddedColor())

        let expectedOldLine = NSMutableAttributedString(string: oldLine, attributes: [NSAttributedStringKey.backgroundColor: UIColor.deletedColor()])
        expectedOldLine.addAttributes([NSAttributedStringKey.backgroundColor: UIColor.strongDeletedColor()], range: (oldLine as NSString).range(of: "-you-always"))
        expectedOldLine.addAttributes([NSAttributedStringKey.backgroundColor: UIColor.strongDeletedColor()], range: (oldLine as NSString).range(of: "id963577401"))

        let expectedNewLine = NSMutableAttributedString(string: newLine, attributes: [NSAttributedStringKey.backgroundColor: UIColor.addedColor()])
        expectedNewLine.addAttributes([NSAttributedStringKey.backgroundColor: UIColor.strongAddedColor()], range: (newLine as NSString).range(of: "enterprise-"))
        expectedNewLine.addAttributes([NSAttributedStringKey.backgroundColor: UIColor.strongAddedColor()], range: (newLine as NSString).range(of: "id1079716387"))
        expectedNewLine.addAttributes([NSAttributedStringKey.backgroundColor: UIColor.strongAddedColor()], range: (newLine as NSString).range(of: "ls=1&"))

        let result = jsDiff.diffWords(oldLine, newLine: newLine)
        XCTAssertEqual(result.oldLine, expectedOldLine)
        XCTAssertEqual(result.newLine, expectedNewLine)
    }
}
