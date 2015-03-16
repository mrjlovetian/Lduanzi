//
//  DuanziCell.m
//  test
//
//  Created by baoyuan on 14-9-1.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "DuanziCell.h"
#import "AsynlmageView.h"
#import "Duanzi.h"
#import "UIViewAdditions.h"

#import "MCFireworksButton.h"

#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
//#import "BTRippleButton/BTRippleButtton.h"
#define MARGIN 10
#define LABHEIGHT 40
#define LABWEIGHT 30
#define CONTENTHEIGHT 200
#define BTNWEIGHT 80
#define FONTSIZE 14
#define LINE 5
#define BTNWITH 50
#define BACKGROND [UIColor clearColor]
@implementation DuanziCell
{
    BOOL _selected;
    BOOL _selecte;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.likeArray = [NSMutableArray arrayWithCapacity:1];
        self.view = [[UIView alloc] init];
        self.view.backgroundColor = [UIColor whiteColor];
        [self addSubview:_view];
        
        self.userImage = [[AsynlmageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, LABWEIGHT, LABWEIGHT)];
        self.userImage.clipsToBounds = YES;
        self.userImage.layer.cornerRadius = 3.0;
        self.userImage.backgroundColor = BACKGROND;
        self.userImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(print)];
        [_userImage addGestureRecognizer:tap];
        [self addSubview:_userImage];
        
        self.userBtn = [[UIButton alloc] initWithFrame:CGRectMake(_userImage.right + LINE, 3, LABWEIGHT * 9, LABHEIGHT)];
        //self.userBtn.frame =  CGRectMake(_userImage.right + MARGIN, MARGIN, LABWEIGHT * 9, LABHEIGHT);
        self.userBtn.backgroundColor = BACKGROND;
        [_userBtn addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_userBtn];
        
        self.contentLab = [[UILabel alloc] initWithFrame:CGRectMake(LINE, _userBtn.bottom + MARGIN, 320 - 2 * MARGIN, 0)];
        self.contentLab.backgroundColor = BACKGROND;
        self.contentLab.numberOfLines = 0;
        _contentLab.font = [UIFont systemFontOfSize:FONTSIZE];
        [self addSubview:_contentLab];
        
        self.hotIM = [[AsynlmageView alloc] initWithImage:[UIImage imageNamed:@"hotdot"]];
        [self addSubview:_hotIM];
        self.pinglunLab = [[UILabel alloc] init];
        [self addSubview:_pinglunLab];
        
        self.pinglunLab.textColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1.0];
        
        
        self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *shareIm = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share.png"]];
        shareIm.size = CGSizeMake(25, 25);
        [_shareBtn addSubview:shareIm];
        [self addSubview:_shareBtn];
        _selected = YES;
        
        
    }
    return self;
}

/*- (void)changeColorBtn
{
    for (int i = 0; i < self.likeArray.count; i++) {
        if (_likeBtn.tag == [[_likeArray objectAtIndex:i] intValue]) {
            [self.likeBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        }
    }
}*/

- (void)setCellDuanzi:(Duanzi *)cellDuanzi
{
    if (_cellDuanzi != cellDuanzi) {
    }
    
    [_likeBtn removeFromSuperview];
    _likeBtn = nil;
    
    [_likeLab removeFromSuperview];
    _likeLab = nil;
    
    [_assigntLab removeFromSuperview];
    _assigntLab = nil;
    
    [_assginBtn removeFromSuperview];
    _assginBtn = nil;
    
    _userImage.url = cellDuanzi.userImageUrl;
    [self.userBtn setTitle:[NSString stringWithFormat:@" %@", cellDuanzi.userName] forState:UIControlStateNormal];
    [_userBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _userBtn.titleLabel.font = [UIFont systemFontOfSize:FONTSIZE];
    _userBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//设置BUTTON的字体向右对齐
    
    _contentLab.text = cellDuanzi.content;
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FONTSIZE], NSFontAttributeName, nil];
    
    CGRect rect = [cellDuanzi.content boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.contentLab.frame = CGRectMake(MARGIN, self.contentLab.frame.origin.y, 300, rect.size.height);
    
    self.likeLab.text = [NSString stringWithFormat:@"%@", cellDuanzi.like];
    self.likeBtn.frame = CGRectMake(MARGIN, self.contentLab.bottom + MARGIN, 25, 25);
    self.likeLab.frame = CGRectMake(_likeBtn.right, self.contentLab.bottom + MARGIN, BTNWITH, 25);
    
    
    self.Dselect = YES;
    self.assginBtn.frame = CGRectMake(_likeLab.right + MARGIN, self.contentLab.bottom + MARGIN, 25, 25);
    self.assigntLab.text = [NSString stringWithFormat:@"%@", cellDuanzi.assignt];
    self.assigntLab.frame = CGRectMake(_assginBtn.right, self.contentLab.bottom + MARGIN, BTNWITH, 25);
    
    self.hotIM.frame = CGRectMake(_assigntLab.right + MARGIN, self.contentLab.bottom + MARGIN, 25, 25);
    self.pinglunLab.text = [NSString stringWithFormat:@"%@", cellDuanzi.hotDot];
    self.pinglunLab.frame = CGRectMake(_hotIM.right, self.contentLab.bottom + MARGIN, BTNWITH, 25);
    
    self.shareBtn.frame = CGRectMake(_pinglunLab.right + MARGIN, self.contentLab.bottom + MARGIN, 50, 25);
    
    
    _userId = cellDuanzi.userId;
    
    self.view.frame = CGRectMake(5, 5, 310,LABHEIGHT + MARGIN + rect.size.height + LABHEIGHT);

}

+ (CGFloat)getCellHeight:(Duanzi *)duanzi
{
    //计算简介高度
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FONTSIZE], NSFontAttributeName, nil];
    
    CGRect frame = [duanzi.content boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    //NSLog(@"frame:%@", NSStringFromCGRect(frame));
    
    return  LABHEIGHT + MARGIN + frame.size.height + MARGIN + LABHEIGHT + MARGIN;
}


- (void)print
{

    [self.delegate cellPrint:self];
    
}

- (void)btnassignt
{
    [self.delegate changColorassigntBtn:self];
    /*_selecte = !_selecte;
	if (_selecte) {
		[self.assginBtn popOutsideWithDuration:0.5];
		[self.assginBtn setImage:[UIImage imageNamed:@"assignt0"] forState:UIControlStateNormal];
		[self.assginBtn animate];
        int a = [_assigntLab.text intValue] + 1;
        self.assigntLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
        self.assigntLab.text = [NSString stringWithFormat:@"%d", a];
	}
	else {
		[self.assginBtn popInsideWithDuration:0.4];
		[self.assginBtn setImage:[UIImage imageNamed:@"assignt"] forState:UIControlStateNormal];
        int a = [_assigntLab.text intValue] - 1;
        self.assigntLab.textColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1.0];
        self.assigntLab.text = [NSString stringWithFormat:@"%d", a];
	}*/
    
    
    /*if (_selected) {
        [self.assginBtn popOutsideWithDuration:0.5];
		[self.assginBtn setImage:[UIImage imageNamed:@"assignt0"] forState:UIControlStateNormal];
		[self.assginBtn animate];
        int a = [_assigntLab.text intValue] + 1;
        self.assigntLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
        self.assigntLab.text = [NSString stringWithFormat:@"%d", a];
         
        self.isTure = @"1";
        _selected = NO;
        
    }
    else{
        [self.assginBtn setTitle:_isTure forState:UIControlStateNormal];
        self.assginBtn.titleLabel.font = [UIFont systemFontOfSize:0.01];
        [self.delegate message:self.assginBtn];
        
    }*/
    
}



- (void)btnlike
{

    [self.delegate changColorlikeBtn:self];
    
    
    
    
    
    
    
    
    /*NSLog(@"%d",_likeBtn.tag);
    
    if (self.Dselect) {
        [self.likeBtn popOutsideWithDuration:0.5];
        [self.likeBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        [self.likeBtn animate];
        [self.likeArray addObject:[NSString stringWithFormat:@"%d", _likeBtn.tag]];
        [self.delegate changColorBtn:self];
    }*/
    
        /*if (self.Dselect) {
            
            [self.likeBtn popOutsideWithDuration:0.5];
            [self.likeBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
            [self.likeBtn animate];
            
            int a = [_likeLab.text intValue] + 1;
            self.likeLab.text = [NSString stringWithFormat:@"%d", a];
            self.likeLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
            self.isTure = @"0";
            _selected = NO;
    }
    else{
        [self.likeBtn setTitle:_isTure forState:UIControlStateNormal];
        self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:0.01];
        [self.delegate message:self.likeBtn];
    }*/
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

#pragma mark - share
- (void)share
{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:_contentLab.text
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"L段子分享"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"我在使用L段子"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

- (MCFireworksButton *)likeBtn
{
    if (_likeBtn == nil) {
        _likeBtn = [MCFireworksButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn addTarget:self action:@selector(btnlike) forControlEvents:UIControlEventTouchUpInside];
        [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"Like"]
                                forState:UIControlStateNormal];
        self.likeBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
        self.likeBtn.particleScale = 0.05;
        self.likeBtn.particleScaleRange = 0.02;
        [self addSubview:_likeBtn];
    }
    return _likeBtn;
}

- (UILabel *)likeLab
{
    if (_likeLab == nil) {
        _likeLab = [[UILabel alloc] init];
        self.likeLab.userInteractionEnabled = YES;
        [self addSubview:_likeLab];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnlike)];
        [_likeLab addGestureRecognizer:tap];
        self.likeLab.textColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1.0];
    }
    return _likeLab;
}

- (MCFireworksButton *)assginBtn
{
    if (_assginBtn == nil) {
    _assginBtn = [MCFireworksButton buttonWithType:UIButtonTypeCustom];
    [_assginBtn addTarget:self action:@selector(btnassignt) forControlEvents:UIControlEventTouchUpInside];
    [self.assginBtn setBackgroundImage:[UIImage imageNamed:@"assignt"]
                                  forState:UIControlStateNormal];
    self.assginBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
    self.assginBtn.particleScale = 0.05;
    self.assginBtn.particleScaleRange = 0.02;
    [self addSubview:_assginBtn];
    }
    return _assginBtn;
}

- (UILabel *)assigntLab
{
    if (_assigntLab == nil) {
        self.assigntLab = [[UILabel alloc] init];
        self.assigntLab.userInteractionEnabled = YES;
        [self addSubview:_assigntLab];
        self.assigntLab.textColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1.0];
        UITapGestureRecognizer *tapassignt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnassignt)];
        [_assigntLab addGestureRecognizer:tapassignt];
    }
    return _assigntLab;
}
@end
