//
//  PLmodeCell.m
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "PLmodeCell.h"
#import "AsynlmageView.h"
#import "UIViewAdditions.h"
#import "PLModel.h"
#define BACKGROUND [UIColor clearColor]
#define FONTSIZE 13
#define MARGIN 10
#define LINE 5
#define USERIM_WEIGHT 40
@implementation PLmodeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.view = [[UIView alloc] init];
        self.view.backgroundColor = [UIColor whiteColor];
        [self addSubview:_view];
        
        self.userPicture = [[AsynlmageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, USERIM_WEIGHT, USERIM_WEIGHT)];
        self.userPicture.backgroundColor = BACKGROUND;
        self.userPicture.clipsToBounds = YES;
        self.userPicture.layer.cornerRadius = 3.0;
        [self addSubview:_userPicture];
        
        self.userLab = [[UILabel alloc] initWithFrame:CGRectMake(_userPicture.right + MARGIN, MARGIN, 300 - _userPicture.width, 15)];
        self.userLab.font = [UIFont systemFontOfSize:FONTSIZE];
        self.userLab.backgroundColor = BACKGROUND;
        [self addSubview:_userLab];
        
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(_userPicture.right + MARGIN, self.userLab.bottom + LINE, 300 - _userPicture.width, 15)];
        self.timeLab.backgroundColor = BACKGROUND;
        [self addSubview:_timeLab];
        
        self.pinglunLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _userPicture.bottom + LINE, 300, 0)];
        self.pinglunLab.numberOfLines = 0;
        self.pinglunLab.font = [UIFont systemFontOfSize:FONTSIZE];
        self.pinglunLab.backgroundColor = BACKGROUND;
        [self addSubview:_pinglunLab];
    }
    return self;
}

-(void)setPlMode:(PLModel *)plMode
{
    _userPicture.url = plMode.pPurl;
    _userLab.text = plMode.pName;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[plMode.pTime integerValue]];
    /*NSTimeZone *zone = [NSTimeZone systemTimeZone];
     NSInteger interval = [zone secondsFromGMTForDate:date];
     NSDate *localDate = [date dateByAddingTimeInterval:interval];*/
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //NSLog(@"localDate%@", currentDateStr);
    _timeLab.text = currentDateStr;
    _pinglunLab.text = plMode.pText;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FONTSIZE], NSFontAttributeName, nil];
    
    CGRect frame = [plMode.pText boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    _pinglunLab.frame = CGRectMake(10, _userPicture.bottom + LINE, 280, frame.size.height);
    self.view.frame = CGRectMake(5, 5, 310, USERIM_WEIGHT + LINE + frame.size.height + MARGIN);
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


+ (CGFloat)getCellHeight:(PLModel *)plmode
{
    //计算简介高度
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FONTSIZE], NSFontAttributeName, nil];
    
    CGRect frame = [plmode.pText boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    
    return MARGIN + USERIM_WEIGHT + LINE + frame.size.height + MARGIN;
}
@end
