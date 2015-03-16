//
//  PersonCell.m
//  MyMovie
//
//  Created by MRJ on 14-8-9.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "PersonCell.h"
#import "UIViewAdditions.h"
#define BACKGROUND [UIColor whiteColor];
@implementation PersonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.sepreate = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        self.sepreate.image = [UIImage imageNamed:@"up.png"];
        [self addSubview:_sepreate];
        _sepreate.alpha = 1.0;
        
        /*self.sp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
        self.sp.backgroundColor = [UIColor clearColor];
        [self addSubview:_sp];
        [_sp release];*/
        
        self.markView = [[UIImageView alloc] initWithFrame:CGRectMake(10, _sepreate.bottom + 10, 30, 30)];
        //_markView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"directright" ofType:@"png"]];
        [self addSubview:_markView];
        
        self.texLab = [[UILabel alloc] initWithFrame:CGRectMake(_markView.right + 10, _markView.top, 150, 30)];
        _texLab.backgroundColor = BACKGROUND;
        [self addSubview:_texLab];
        
        self.directRightView = [[UIImageView alloc] initWithFrame:CGRectMake(320 - 50, _texLab.top - 5, 40, 40)];
        _directRightView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"directright" ofType:@"png"]];
        [self addSubview:_directRightView];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
