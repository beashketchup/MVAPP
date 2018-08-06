//
//  MovieStore.m
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import "MovieStore.h"
#import <MovieFramework/MovieFramework.h>
#import "Movie.h"

@interface MovieStore ()

@property (nonatomic, strong, readonly) NSString *searchItem;

@end

@implementation MovieStore

#pragma mark - Lifecycle

- (instancetype)initWithSearch:(NSString *)item {
    self = [super init];
    if (!self) return nil;
    
    _searchItem = item;
    _movies = @[];
    
    return self;
}

- (void)fetchMovies {
        
    [[DataFetcher sharedManager] initWithAPIkey:@"b5c34c996b0f93d624c485c79881e04b"];
    [[DataFetcher sharedManager] fetchMoviesFor:_searchItem handler:^(NSArray *dataArray, NSError *error) {
        NSMutableArray *newArray = [[NSMutableArray alloc] init];
        for (NSDictionary *movieItem in dataArray) {
            Movie *newMovie = [[Movie alloc] initWithTitle:[movieItem objectForKey:@"title"]
                                                     image:[movieItem objectForKey:@"posterImageUrl"]
                                                popularity:[movieItem objectForKey:@"popularity"]];
            [newArray addObject:newMovie];
        }
        _movies = newArray;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MOVIE_RECIEVED" object:self];
    }];
}

@end
