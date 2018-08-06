//
//  MovieListViewController.m
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieListCellTableViewCell.h"

@interface MovieListViewController ()

@property (nonatomic, strong, readonly) MovieListViewModel *viewModel;
@property (nonatomic, strong, readonly) UITableView *tableView;

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindViewModel];
    
    [self createViewComponent];
}

- (void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lifecycle

- (instancetype)initWithViewModel:(MovieListViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    
    _viewModel = viewModel;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieDataUpdated:)
                                                 name:@"MOVIE_RECIEVED"
                                               object:nil];
    
    return self;
}

#pragma mark - Init

- (void) createViewComponent {
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenSize.width, screenSize.height - 64) style:UITableViewStylePlain];
    [_tableView registerClass:[MovieListCellTableViewCell class] forCellReuseIdentifier:@"MovieCell"];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
}

#pragma mark - Bindings

- (void)bindViewModel {
    
    self.title = [self.viewModel title];
}

- (void)movieDataUpdated:(id)sender {
    __typeof(self) __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
}

# pragma mark - Actions

- (void) buttonClick:(UIButton *) sender {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfPeopleInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListCellTableViewCell *cell = (MovieListCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    [cell setTitle:[self.viewModel titleAtIndexPath:indexPath]];
    [cell setDesc:[NSString stringWithFormat:@"Rating - %@", [self.viewModel ratingAtIndexPath:indexPath]]];
    [cell setImage:[self.viewModel imageAtIndexPath:indexPath]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 138.0;
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
