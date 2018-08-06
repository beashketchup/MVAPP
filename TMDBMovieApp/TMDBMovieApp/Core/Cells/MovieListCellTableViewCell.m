//
//  MovieListCellTableViewCell.m
//  TMDBMovieApp
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import "MovieListCellTableViewCell.h"
#import <MovieFramework/MovieFramework.h>

@interface MovieListCellTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *movieImageView;

@end

@implementation MovieListCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createComponents];
    }
    return self;
}

- (void) createComponents {
    
    CGFloat xPadding = 14, yPadding = 14;
    _movieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 92, 138)];
    [self.contentView addSubview:_movieImageView];
    
    xPadding += 100;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPadding, yPadding, self.frame.size.width - xPadding, 30)];
    _titleLabel.text = @"";
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    [self.contentView addSubview:_titleLabel];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPadding, yPadding + 40, self.frame.size.width - xPadding, 30)];
    _descLabel.text = @"";
    _descLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    [self.contentView addSubview:_descLabel];        
}

- (void) setTitle:(NSString *) value {
    self.titleLabel.text = value;
}

- (void) setImage:(NSString *) value {
    
    [self.imageView setImage:NULL];
    __typeof(self) __weak weakSelf = self;
    [[DataFetcher sharedManager] getImageFor:value handler:^(NSData *response) {
        [weakSelf.movieImageView setImage:[UIImage imageWithData:response]];
    }];
}

- (void) setDesc:(NSString *) value {
    self.descLabel.text = value;
}

@end
