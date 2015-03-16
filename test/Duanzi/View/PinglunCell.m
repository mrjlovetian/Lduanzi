//
//  PinglunCell.m
//  test
//
//  Created by baoyuan on 14-9-2.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "PinglunCell.h"
#import "UIViewAdditions.h"
#import "AsynlmageView.h"
#import "PinglunModel.h"
#define MARGIN 10
#define LABHEIGHT 15
#define LABWEIGHT 260
#define CONTENTHEIGHT 200
#define BTNWEIGHT 80
#define FONTSIZE 13
#define IMAGEWEIGHT 30
#define BACKGROND [UIColor clearColor]
@implementation PinglunCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.baView = [[UIView alloc] init];
        self.baView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baView];
        
        self.userImage = [[AsynlmageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, IMAGEWEIGHT, IMAGEWEIGHT)];
        self.userImage.backgroundColor = BACKGROND;
        self.userImage.clipsToBounds = YES;
        self.userImage.layer.cornerRadius = 3.0;
        [self addSubview:_userImage];
        
        self.userLab = [[UILabel alloc] initWithFrame:CGRectMake(_userImage.right + MARGIN, MARGIN, LABWEIGHT, LABHEIGHT)];
        self.userLab.font = [UIFont systemFontOfSize:FONTSIZE];
        self.userLab.backgroundColor = BACKGROND;
        [self addSubview:_userLab];
        
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(_userImage.right + MARGIN, _userLab.bottom + 2, LABWEIGHT, LABHEIGHT)];
        self.timeLab.font = [UIFont systemFontOfSize:FONTSIZE];
        _timeLab.backgroundColor = BACKGROND;
        [self addSubview:_timeLab];
        
        
        self.contentLab = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, _userImage.bottom + 5, 300, 0)];
        self.contentLab.numberOfLines = 0;
        self.contentLab.font = [UIFont systemFontOfSize:FONTSIZE];
        self.contentLab.backgroundColor = BACKGROND;
        [self addSubview:_contentLab];
        
        self.pingContantLab = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, _contentLab.bottom + 5, 300, 0)];
        self.pingContantLab.numberOfLines = 0;
        self.pingContantLab.font = [UIFont systemFontOfSize:FONTSIZE];
        self.pingContantLab.backgroundColor = [UIColor grayColor];
        [self addSubview:_pingContantLab];
    }
    return self;
}

- (void)setPlmode:(PinglunModel *)plmode
{
    self.userImage.url = plmode.userPictureUrl;
    self.userLab.text = [NSString stringWithFormat:@"%@ 评论了", plmode.userName];
    self.contentLab.text = plmode.content;
    self.pingContantLab.text = plmode.text;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[plmode.time integerValue]];
    /*NSTimeZone *zone = [NSTimeZone systemTimeZone];
     NSInteger interval = [zone secondsFromGMTForDate:date];
     NSDate *localDate = [date dateByAddingTimeInterval:interval];*/
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //NSLog(@"localDate%@", currentDateStr);
    self.timeLab.text = currentDateStr;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FONTSIZE], NSFontAttributeName, nil];
    
    CGRect framec = [plmode.content boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGRect framet = [plmode.text boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.contentLab.frame = CGRectMake(MARGIN, _userImage.bottom + 5, 300, framec.size.height);
    self.pingContantLab.frame = CGRectMake(MARGIN, _contentLab.bottom + 5, 300, framet.size.height);
    self.baView.frame = CGRectMake(5, 5, 310, MARGIN + IMAGEWEIGHT + 5 + 5 + framec.size.height + framet.size.height);
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

+ (CGFloat)getCellHeight:(PinglunModel *)plmode
{
    //计算简介高度
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FONTSIZE], NSFontAttributeName, nil];
    
    CGRect framec = [plmode.content boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGRect framet = [plmode.text boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    NSLog(@"frame:%f", MARGIN + IMAGEWEIGHT + 5 + 5 + framec.size.height + framet.size.height + MARGIN);
    
    return MARGIN + IMAGEWEIGHT + 5 + 5 + framec.size.height + framet.size.height + MARGIN;
}

@end
