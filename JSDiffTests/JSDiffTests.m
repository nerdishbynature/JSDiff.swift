//
//  JSDiffTests.m
//  JSDiff
//
//  Created by Piet Brauer on 09/04/16.
//  Copyright © 2016 nerdish by nature. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSDiffTests-Swift.h"
#import <JSDiff/JSDiff.h>

@interface JSDiffTests : XCTestCase

@end

@implementation JSDiffTests

- (void)testSmallerLines {
    NSString *oldLine = @"<div class=\"{% if modulo == '6' %}flex-first{% endif %} sm-col sm-col-6 center\">";
    NSString *newLine = @"<div class=\"{% if modulo == '0' %}flex-first{% endif %} sm-col sm-col-4 center\">";
    NSMutableAttributedString *expectedOldLine = [[NSMutableAttributedString alloc] initWithString:oldLine attributes:@{NSBackgroundColorAttributeName: [UIColor deletedColor]}];
    [expectedOldLine addAttribute:NSBackgroundColorAttributeName value:[UIColor strongDeletedColor] range:NSMakeRange(29, 1)];
    [expectedOldLine addAttribute:NSBackgroundColorAttributeName value:[UIColor strongDeletedColor] range:NSMakeRange(70, 1)];
    NSMutableAttributedString *expectedNewLine = [[NSMutableAttributedString alloc] initWithString:newLine attributes:@{NSBackgroundColorAttributeName: [UIColor addedColor]}];
    [expectedNewLine addAttribute:NSBackgroundColorAttributeName value:[UIColor strongAddedColor] range:NSMakeRange(29, 1)];
    [expectedNewLine addAttribute:NSBackgroundColorAttributeName value:[UIColor strongAddedColor] range:NSMakeRange(70, 1)];

    JSDiff *diffObject = [[JSDiff alloc] initWithDeletedColor: [UIColor deletedColor] deletedWordColor: [UIColor strongDeletedColor] addedColor: [UIColor addedColor] addedWordColor: [UIColor strongAddedColor]];
    JSLineDiff *lineDiff = [diffObject diffWords:oldLine newLine:newLine];

    XCTAssertEqualObjects(lineDiff.oldLine, expectedOldLine);
    XCTAssertEqualObjects(lineDiff.newLine, expectedNewLine);
}

@end
