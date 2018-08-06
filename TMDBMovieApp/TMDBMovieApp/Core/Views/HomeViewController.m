//
//  HomeViewController.m
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import "HomeViewController.h"
#import "MovieSearchViewModel.h"
#import "MovieSearchViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong, readonly) HomeViewModel *viewModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindViewModel];
    
    [self createViewComponent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lifecycle

- (instancetype)initWithViewModel:(HomeViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    
    _viewModel = viewModel;
    
    return self;
}

#pragma mark - Init

- (void) createViewComponent {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    UIButton *newButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 28)];
    [newButton setTitle:@"Start" forState:UIControlStateNormal];
    [newButton setBackgroundColor:[UIColor lightGrayColor]];
    [newButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newButton];
    
    [newButton setCenter:CGPointMake(screenSize.width / 2, screenSize.height / 2)];
}

#pragma mark - Bindings

- (void)bindViewModel {
    
    self.title = [self.viewModel title];
}

# pragma mark - Actions

- (void) buttonClick:(UIButton *) sender {
    
    MovieSearchViewModel *movieVM = [[MovieSearchViewModel alloc] init];
    MovieSearchViewController *movieSearchVC = [[MovieSearchViewController alloc] initWithViewModel:movieVM];
    [[self navigationController] pushViewController:movieSearchVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
