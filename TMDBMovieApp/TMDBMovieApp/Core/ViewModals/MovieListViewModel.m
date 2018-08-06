//
//  MovieListViewModel.m
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieListViewModel.h"
#import "Movie.h"

@interface MovieListViewModel ()

@property (nonatomic, strong, readonly) MovieStore *store;

@end


@implementation MovieListViewModel

#pragma mark - Lifecycle

- (instancetype)initWithStore:(MovieStore *)store {
    self = [super init];
    if (!self) return nil;
    
    _store = store;        
    
    [_store fetchMovies];
    
    return self;
}

#pragma mark - Data Source

- (NSString *)title {
    return @"Movie List";
}

- (NSUInteger)numberOfPeopleInSection:(NSInteger)section {
    return _store.movies.count > 10 ? 10 : _store.movies.count;
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    Movie *newMovie = [self movieAtIndexPath:indexPath];
    return newMovie.title;
}

- (NSString *)imageAtIndexPath:(NSIndexPath *)indexPath {
    Movie *newMovie = [self movieAtIndexPath:indexPath];
    return newMovie.imageURL;
}

- (NSString *)ratingAtIndexPath:(NSIndexPath *)indexPath {
    Movie *newMovie = [self movieAtIndexPath:indexPath];
    return [NSString stringWithFormat:@"%f", newMovie.popularity.doubleValue];
}

- (Movie *)movieAtIndexPath:(NSIndexPath *)indexPath {
    return [_store.movies objectAtIndex:indexPath.row];
}

@end
