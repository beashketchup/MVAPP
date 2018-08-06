//
//  MovieSearchViewController.m
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import "MovieSearchViewController.h"
#import "MovieStore.h"
#import "MovieListViewModel.h"
#import "MovieListViewController.h"

@interface MovieSearchViewController ()

@property (nonatomic, strong, readonly) MovieSearchViewModel *viewModel;
@property (nonatomic, strong) UITextField *searchView;

@end

@implementation MovieSearchViewController

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

- (instancetype)initWithViewModel:(MovieSearchViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    
    _viewModel = viewModel;
    
    return self;
}

#pragma mark - Init

- (void) createViewComponent {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    _searchView = [[UITextField alloc] initWithFrame:CGRectMake(15, 80, screenSize.width - 30 - 60, 30)];
    [_searchView setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:_searchView];
    
    UIButton *newButton = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.width - 30 - 60, 80, 70, 30)];
    [newButton setTitle:@"Search" forState:UIControlStateNormal];
    [newButton setBackgroundColor:[UIColor lightGrayColor]];
    [newButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newButton];
}

#pragma mark - Bindings

- (void)bindViewModel {
    
    self.title = [self.viewModel title];
}

# pragma mark - Actions

- (void) buttonClick:(UIButton *) sender {
    
    MovieStore *store = [[MovieStore alloc] initWithSearch:_searchView.text];
    MovieListViewModel *listVM = [[MovieListViewModel alloc] initWithStore:store];
    MovieListViewController *listVC = [[MovieListViewController alloc] initWithViewModel:listVM];
    [[self navigationController] pushViewController:listVC animated:YES];
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
