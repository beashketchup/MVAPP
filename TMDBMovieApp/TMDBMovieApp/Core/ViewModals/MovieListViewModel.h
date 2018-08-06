//
//  MovieListViewModel.h
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieStore.h"

@interface MovieListViewModel : NSObject

- (instancetype)initWithStore:(MovieStore *)store;

- (NSString *)title;
- (NSUInteger)numberOfPeopleInSection:(NSInteger)section;
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)imageAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)ratingAtIndexPath:(NSIndexPath *)indexPath;

@end
