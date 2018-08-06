//
//  HomeViewController.h
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"

@interface HomeViewController : UIViewController

- (instancetype)initWithViewModel:(HomeViewModel *)viewModel;

@end
