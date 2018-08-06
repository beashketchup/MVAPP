//
//  MovieListViewController.h
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieListViewModel.h"

@interface MovieListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithViewModel:(MovieListViewModel *)viewModel;

@end
