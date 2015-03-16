//
//  SysSettingsCell.m
//  MyMovie
//
//  Created by 韩森 on 14-8-12.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "SysSettingsCell.h"

@implementation SysSettingsCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//        self.label1.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.label1];
        
        
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
