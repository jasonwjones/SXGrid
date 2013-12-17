//
//  SXGridTests.m
//  SXGridTests
//
//  Created by Jason Jones on 12/12/13.
//  Copyright (c) 2013 Saxifrage Systems LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SXGrid.h"

@interface SXGridTests : XCTestCase

@property (nonatomic, strong) SXGrid *grid;

@end

@implementation SXGridTests

- (void)setUp
{
    [super setUp];
    self.grid = [SXGrid gridWithRows:4 cols:3 fromBlock:^id(NSUInteger row, NSUInteger col) {
        return [NSString stringWithFormat:@"%d, %d", row, col];
    }];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStringRepresentation
{
    NSString *stringRepresentation = [self.grid stringRepresentation];
    NSLog(@"\n%@", stringRepresentation);
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

@end
