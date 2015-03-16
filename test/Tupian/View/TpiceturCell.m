//
//  TpiceturCell.m
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "TpiceturCell.h"
#import "AsynlmageView.h"
#import "PictureModel.h"
#import "UIViewAdditions.h"
#import "MCTopAligningLabel.h"
#import "MCFireworksButton.h"
#import <ShareSDK/ShareSDK.h>

#define LABHEIGHT 30
#define BTNWEIGHT 80
#define FONTSIZE 14
#define MARGIN 10
#define SHAREWIDTH 50
#define PICTURE_HEIGHT 40
#define BACNGROUND [UIColor clearColor]
@implementation TpiceturCell
{
    BOOL _selected;
    BOOL _selecte;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
         self.likeArray = [NSMutableArray arrayWithCapacity:1];
        // Initialization code
        self.view = [[UIView alloc] init];
        self.view.backgroundColor = [UIColor whiteColor];
        [self addSubview:_view];
        
        self.contIm = [[AsynlmageView alloc] init];
        self.contIm.backgroundColor = BACNGROUND;
        [self addSubview:_contIm];
        
        self.userIm = [[AsynlmageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, PICTURE_HEIGHT, PICTURE_HEIGHT)];
        self.userIm.clipsToBounds = YES;
        self.userIm.layer.cornerRadius = 3.0;
        self.userIm.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(print)];
        [_userIm addGestureRecognizer:tap];
        [self addSubview:_userIm];
        
        self.userName = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.userName addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
        self.userName.frame = CGRectMake(_userIm.right + MARGIN, MARGIN * 2, 250, 15);
        self.userName.backgroundColor = BACNGROUND;
        [self addSubview:_userName];
        
        self.txtLab = [[UILabel alloc] init];
        [self addSubview:_txtLab];
        
        /*self.likeBtn = [MCFireworksButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn addTarget:self action:@selector(btnlike) forControlEvents:UIControlEventTouchUpInside];
        self.likeBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
        self.likeBtn.particleScale = 0.05;
        self.likeBtn.particleScaleRange = 0.02;
        [self addSubview:_likeBtn];
        
        self.likeLab = [[UILabel alloc] init];
        self.likeLab.userInteractionEnabled = YES;
        [self addSubview:_likeLab];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnlike)];
        [_likeLab addGestureRecognizer:tap];
        
        self.assginBtn = [MCFireworksButton buttonWithType:UIButtonTypeCustom];
        [_assginBtn addTarget:self action:@selector(btnassignt) forControlEvents:UIControlEventTouchUpInside];
        self.assginBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
        self.assginBtn.particleScale = 0.05;
        self.assginBtn.particleScaleRange = 0.02;
        
        self.assigntLab = [[UILabel alloc] init];
        self.assigntLab.userInteractionEnabled = YES;
        [self addSubview:_assigntLab];
        UITapGestureRecognizer *tapassignt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnassignt)];
        [_assigntLab addGestureRecognizer:tapassignt];
        [self addSubview:_assginBtn];*/
        
        self.hotIM = [[AsynlmageView alloc] initWithImage:[UIImage imageNamed:@"hotdot"]];
        [self addSubview:_hotIM];
        self.pinglunLab = [[UILabel alloc] init];
        [self addSubview:_pinglunLab];
        
        self.likeLab.textColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1.0];
        self.pinglunLab.textColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1.0];
        self.assigntLab.textColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1.0];
        
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

- (void)print
{
    [self.delegate rootUser:self];
}

- (void)setPictureMode:(PictureModel *)pictureMode
{
    _pictureMode = pictureMode;
    _contIm.url = pictureMode.tConUrl;
   
    [_likeBtn removeFromSuperview];
    _likeBtn = nil;
    
    [_likeLab removeFromSuperview];
    _likeLab = nil;
    
    [_assigntLab removeFromSuperview];
    _assigntLab = nil;
    
    [_assginBtn removeFromSuperview];
    _assginBtn = nil;
    
    _userIm.url = pictureMode.userImageUrl;
    
    [_userName setTitle:pictureMode.userName forState:UIControlStateNormal];
    [_userName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _userName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _userName.titleLabel.font = [UIFont systemFontOfSize:FONTSIZE];
    
    if (pictureMode.tDespircet != nil) {
        _txtLab.frame = CGRectMake(MARGIN, _userIm.bottom + 5, 300, LABHEIGHT);
    }
    else if(pictureMode.tDespircet == nil)
    {
        _txtLab.frame = CGRectMake(MARGIN, _userIm.bottom + 5, 300, 0);
    }
    _txtLab.text = pictureMode.tDespircet;
    if ([pictureMode.tHeight integerValue] < 300) {
        _contIm.frame = CGRectMake(MARGIN, self.userIm.bottom + 5 + _txtLab.height, 300, [pictureMode.tHeight intValue]);
    }
    if ([pictureMode.tHeight integerValue] >= 300) {
        _contIm.frame = CGRectMake(MARGIN, self.userIm.bottom + 5 + _txtLab.height, 300, [pictureMode.tHeight intValue] / 2);
    }
    self.Dselect = YES;
    
    self.likeLab.text = [NSString stringWithFormat:@"%@", pictureMode.like];
    /*[self.likeBtn setBackgroundImage:[UIImage imageNamed:@"Like"]
                            forState:UIControlStateNormal];*/
    self.likeBtn.frame = CGRectMake(MARGIN, self.contIm.bottom + MARGIN, 25, 25);
    self.likeLab.frame = CGRectMake(_likeBtn.right, self.contIm.bottom + MARGIN, SHAREWIDTH, 25);
    //self.likeBtn.titleLabel.text = [NSString stringWithFormat:@"%@", cellDuanzi.like];
    //self.likeBtn.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 20, 0);
    
    
    
    /*[self.assginBtn setBackgroundImage:[UIImage imageNamed:@"assignt"]
                              forState:UIControlStateNormal];*/
    self.assginBtn.frame = CGRectMake(_likeLab.right + MARGIN, self.contIm.bottom + MARGIN, 25, 25);
    self.assigntLab.text = [NSString stringWithFormat:@"%@", pictureMode.assignt];
    self.assigntLab.frame = CGRectMake(_assginBtn.right, self.contIm.bottom + MARGIN, SHAREWIDTH, 25);
    
    self.hotIM.frame = CGRectMake(_assigntLab.right + MARGIN, self.contIm.bottom + MARGIN, 25, 25);
    self.pinglunLab.text = [NSString stringWithFormat:@"%@", pictureMode.hotDot];
    self.pinglunLab.frame = CGRectMake(_hotIM.right, self.contIm.bottom + MARGIN, SHAREWIDTH, 25);
    self.view.frame = CGRectMake(5, 5, 310, self.pinglunLab.bottom);
    
    self.shareBtn.frame = CGRectMake(_pinglunLab.right + MARGIN, self.contIm.bottom + MARGIN, 50, 25);
    
}

+ (CGFloat)getCellHeight:(PictureModel *)pictureMode
{
    NSLog(@"*********%@", pictureMode.tDespircet);
    if (pictureMode.tDespircet == nil) {
        if ([pictureMode.tHeight integerValue] < 300) {
            return [pictureMode.tHeight intValue] + MARGIN + PICTURE_HEIGHT + MARGIN + MARGIN + MARGIN + LABHEIGHT ;
        }
        if ([pictureMode.tHeight integerValue] >= 300) {
            return [pictureMode.tHeight intValue] / 2 + MARGIN + PICTURE_HEIGHT + MARGIN + MARGIN + MARGIN + LABHEIGHT ;
        }
        
    }
    if (pictureMode.tDespircet != nil) {
        if ([pictureMode.tHeight integerValue] < 300) {
            return [pictureMode.tHeight intValue] + MARGIN + PICTURE_HEIGHT + MARGIN + MARGIN + MARGIN + LABHEIGHT * 2;
        }
        if ([pictureMode.tHeight integerValue] >= 300) {
            return [pictureMode.tHeight intValue] / 2 + MARGIN + PICTURE_HEIGHT + MARGIN + MARGIN + MARGIN + LABHEIGHT * 2;
        }
    }
    return [pictureMode.tHeight intValue] / 2 + MARGIN + PICTURE_HEIGHT + MARGIN + MARGIN + MARGIN + LABHEIGHT * 2;
    
}

//- (void)btnassignt
//{
//    /*_selecte = !_selecte;
//	if (_selecte) {
//		[self.assginBtn popOutsideWithDuration:0.5];
//		[self.assginBtn setImage:[UIImage imageNamed:@"assignt0"] forState:UIControlStateNormal];
//		[self.assginBtn animate];
//        int a = [_assigntLab.text intValue] + 1;
//        self.assigntLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
//        self.assigntLab.text = [NSString stringWithFormat:@"%d", a];
//	}
//	else {
//		[self.assginBtn popInsideWithDuration:0.4];
//		[self.assginBtn setImage:[UIImage imageNamed:@"assignt"] forState:UIControlStateNormal];
//        int a = [_assigntLab.text intValue] - 1;
//        self.assigntLab.textColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1.0];
//        self.assigntLab.text = [NSString stringWithFormat:@"%d", a];
//	}*/
//    
//    if (_selected) {
//        [self.assginBtn popOutsideWithDuration:0.5];
//		[self.assginBtn setImage:[UIImage imageNamed:@"assignt0"] forState:UIControlStateNormal];
//		[self.assginBtn animate];
//        int a = [_assigntLab.text intValue] + 1;
//        self.assigntLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
//        self.assigntLab.text = [NSString stringWithFormat:@"%d", a];
//        
//        self.isTure = @"1";
//        _selected = NO;
//        
//    }
//    else{
//        [self.assginBtn setTitle:_isTure forState:UIControlStateNormal];
//        self.assginBtn.titleLabel.font = [UIFont systemFontOfSize:0.01];
//        [self.delegate message:self.assginBtn];
//        
//    }
//}
//
//- (void)btnlike
//{
//    NSLog(@"");
//    /*_selected = !_selected;
//	if (_selected) {
//		[self.likeBtn popOutsideWithDuration:0.5];
//		[self.likeBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
//		[self.likeBtn animate];
//        int a = [_likeLab.text intValue] + 1;
//        self.likeLab.text = [NSString stringWithFormat:@"%d", a];
//        self.likeLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
//	}
//	else {
//		[self.likeBtn popInsideWithDuration:0.4];
//		[self.likeBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
//        int a = [_likeLab.text intValue] - 1;
//        self.likeLab.text = [NSString stringWithFormat:@"%d", a];
//        self.likeLab.textColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1.0];
//	}*/
//    if (_selected) {
//        [self.likeBtn popOutsideWithDuration:0.5];
//        [self.likeBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
//        [self.likeBtn animate];
//        int a = [_likeLab.text intValue] + 1;
//        self.likeLab.text = [NSString stringWithFormat:@"%d", a];
//        self.likeLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
//        self.isTure = @"0";
//        _selected = NO;
//    }
//    else{
//        [self.likeBtn setTitle:_isTure forState:UIControlStateNormal];
//        self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:0.01];
//        [self.delegate message:self.likeBtn];
//    }
//}

- (void)btnassignt
{
    [self.delegate changColorassigntBtn:self];
}


- (void)btnlike
{
    [self.delegate changColorlikeBtn:self];
    
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
    id<ISSContent> publishContent = [ShareSDK content:_userIm.url
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
