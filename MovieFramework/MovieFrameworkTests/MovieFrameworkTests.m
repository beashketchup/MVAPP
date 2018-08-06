//
//  MovieFrameworkTests.m
//  MovieFrameworkTests
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataFetcher.h"

@interface MovieFrameworkTests : XCTestCase

@end

@implementation MovieFrameworkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testFetch {
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Fetch Data"];
    [[DataFetcher sharedManager] initWithAPIkey:@"b5c34c996b0f93d624c485c79881e04b"];
    [[DataFetcher sharedManager] fetchMoviesFor:@"aveng" handler:^(NSArray *data, NSError *error) {
        XCTAssertNotNil(data, @"No data was downloaded");
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10.0];
}



@end
