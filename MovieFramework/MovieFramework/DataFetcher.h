//
//  DataFetcher.h
//  MovieFramework
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFetcher : NSObject

typedef void (^ActionBlock) (NSArray *data, NSError *error);

typedef void (^ImageActionBlock) (NSData *response);

+ (id)sharedManager;

- (void)initWithAPIkey:(NSString *) key;

- (void)fetchMoviesFor:(NSString *) searchItem handler:(ActionBlock) completion;

- (void)getImageFor:(NSString *) imagePath handler:(ImageActionBlock) completion;

@end
