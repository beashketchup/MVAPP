//
//  MovieStore.h
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieStore : NSObject

@property (nonatomic, strong, readonly) NSArray *movies;

- (instancetype)initWithSearch:(NSString *)item;
- (void)fetchMovies;

@end
