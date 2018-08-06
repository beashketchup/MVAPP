//
//  Movie.m
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)tile image:(NSString *)imageURL popularity:(NSNumber *)popularity {
    self = [super init];
    if (!self) return nil;
    
    _title = [tile copy];
    _imageURL = [imageURL copy];
    _popularity = [popularity copy];
    
    return self;
}

@end
