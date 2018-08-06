//
//  Movie.h
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *imageURL;
@property (nonatomic, copy, readonly) NSNumber *popularity;

- (instancetype)initWithTitle:(NSString *)tile image:(NSString *)imageURL popularity:(NSNumber *)popularity;

@end
