//
//  MovieSearchViewController.h
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieSearchViewModel.h"

@interface MovieSearchViewController : UIViewController

- (instancetype)initWithViewModel:(MovieSearchViewModel *)viewModel;

@end
