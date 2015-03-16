//
//  HDViewController.m
//  test
//
//  Created by baoyuan on 14-9-4.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "HDViewController.h"
#import "AsynlmageView.h"
#import "UIViewAdditions.h"
#import <ShareSDK/ShareSDK.h>
#import "PictureModel.h"
#import "TpiceturCell.h"
#import "TuserViewController.h"
#import "TdetailViewController.h"
#import "MBProgressHUD.h"
#import "MCFireworksButton.h"
#import "MJRefresh.h"
@interface HDViewController ()<enjoy>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UIView *showView;
@end

@implementation HDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self createTimeId];
    self.tPictureArray = [NSMutableArray arrayWithCapacity:1];
    self.bigArray = [NSMutableArray arrayWithCapacity:1];
    self.detailArray = [NSMutableArray arrayWithCapacity:1];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    // 2.集成刷新控件
    [self setupRefresh];
    // Do any additional setup after loading the view.
}


- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //[self.table headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    //[self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        //[self.table reloadData];
        [self.bigArray removeAllObjects];
        [self createTimeId];
    });
}

- (void)createTimeId
{
    NSURL *url1 = [NSURL URLWithString:@"http://ic.snssdk.com/api/2/essay/zone/activities/?count=30&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&openudid=a814218a3fc50c5b"];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url1];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"%@", connectionError);
        }
        else
        {
            NSError *error = nil;
            NSMutableDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"%@", error);
            }
            else{
                [[[[tempDic objectForKey:@"data"] objectForKey:@"data"] firstObject] objectForKey:@"id"];
                NSLog(@"************%@", [[[[tempDic objectForKey:@"data"] objectForKey:@"data"] firstObject] objectForKey:@"id"]);
                [self creatUrl:[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] firstObject] objectForKey:@"id"]];
            }
        }
    }];
}

- (void)creatUrl:(NSString *)timeId
{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ic.snssdk.com/api/2/essay/zone/activity/feed/?activity_id=%@&count=30&min_time=0&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&openudid=a814218a3fc50c5b", timeId]];
    NSLog(@"xcxcxcxcxcxcxcxcxcxcxcxcxcxcxcxcxcxcxcxcx%@", url);
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"%@", connectionError);
        }
        else
        {
            NSError *error = nil;
            NSMutableDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"%@", error);
            }
            else{
                self.hUserCount = [[[tempDic objectForKey:@"data"] objectForKey:@"activity"] objectForKey:@"user_count"];
                self.hTitle = [[[tempDic objectForKey:@"data"] objectForKey:@"activity"] objectForKey:@"title"];
                self.hText = [[[tempDic objectForKey:@"data"] objectForKey:@"activity"] objectForKey:@"text"];
                self.hStartTime = [[[tempDic objectForKey:@"data"] objectForKey:@"activity"] objectForKey:@"start_time"];
                self.hEndTime = [[[tempDic objectForKey:@"data"] objectForKey:@"activity"] objectForKey:@"end_time"];
                self.hWidth = [[[[tempDic objectForKey:@"data"] objectForKey:@"activity"] objectForKey:@"image"] objectForKey:@"width"];
                self.hHeight = [[[[tempDic objectForKey:@"data"] objectForKey:@"activity"] objectForKey:@"image"] objectForKey:@"height"];
                self.hImageUrl = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"activity"] objectForKey:@"image"] objectForKey:@"url_list"] firstObject] objectForKey:@"url"];
                
                
                for (int i = 0; i < [[[tempDic objectForKey:@"data"] objectForKey:@"data"] count]; i++) {
                    PictureModel *pcMode = [[PictureModel alloc] init];
                    pcMode.userName = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"name"];
                    pcMode.userImageUrl = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"avatar_url"];
                    pcMode.userId = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"user_id"];
                    pcMode.groupId = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"group_id"];
                    
                    pcMode.tDespircet = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"description"];
                    pcMode.tConUrl = [[[[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"large_image"] objectForKey:@"url_list"] firstObject] objectForKey:@"url"];
                    pcMode.tWeight = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"large_image"] objectForKey:@"width"];
                    pcMode.tHeight = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"large_image"] objectForKey:@"height"];
                    
                    pcMode.like = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"digg_count"];
                    pcMode.assignt = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"bury_count"];
                    pcMode.hotDot = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"comment_count"];
                    NSLog(@"****************tHeight = %@, tWeight = %@", pcMode.tHeight, pcMode.tWeight);
                    [self.tPictureArray addObject:pcMode];
                }
                [self createView];
                [self.bigArray addObject:_tPictureArray];
                [self.tableView reloadData];
                
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [self.tableView headerEndRefreshing];
            }
        }
    }];
}


- (void)createView
{
    [self.detailArray removeAllObjects];
    //设置一个大的view放图片，标签，活动内容
    self.showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    //活动图片
    
    AsynlmageView *huodongIM = [[AsynlmageView alloc] initWithFrame:CGRectMake(0, 0, [self.hWidth intValue] / 2, [self.hHeight intValue] / 2)];
    huodongIM.url = self.hImageUrl;
    //活动标签
    UILabel *hCanjia = [[UILabel alloc] initWithFrame:CGRectMake(0, huodongIM.bottom, 320, 30)];
    //hCanjia.backgroundColor = [UIColor yellowColor];
    //参加活动人数
    UILabel *hPercount = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 30)];
    hPercount.text = [NSString stringWithFormat:@"%@人参加", self.hUserCount];
    //活动截止时间
    UILabel *hTime = [[UILabel alloc] initWithFrame:CGRectMake(hPercount.right, 0, 150, 30)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.hEndTime integerValue]];
    /*NSTimeZone *zone = [NSTimeZone systemTimeZone];
     NSInteger interval = [zone secondsFromGMTForDate:date];
     NSDate *localDate = [date dateByAddingTimeInterval:interval];*/
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //NSLog(@"localDate%@", currentDateStr);
    hTime.text = [NSString stringWithFormat:@"结束时间:%@", currentDateStr];
    hTime.font = [UIFont systemFontOfSize:13];
    //hTime.backgroundColor = [UIColor yellowColor];
    [hCanjia addSubview:hTime];
    [hCanjia addSubview:hPercount];
    
    NSLog(@"%@", self.hUserCount);
    //hCanjia.backgroundColor = [UIColor yellowColor];
    
    //活动内容
    UILabel *hContent = [[UILabel alloc] initWithFrame:CGRectMake(5, hCanjia.bottom, 310, 160)];
    hContent.numberOfLines = 0;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
    
    CGRect frame = [self.hText boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    hContent.font = [UIFont systemFontOfSize:13];
    hContent.text = self.hText;
    hContent.frame = CGRectMake(5, hCanjia.bottom, 310, frame.size.height);
    
    UIButton *canjiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canjiaBtn.frame = CGRectMake(20, hContent.bottom + 5, 170, 30);
    [canjiaBtn setTitle:@"参加活动" forState:UIControlStateNormal];
    canjiaBtn.backgroundColor = [UIColor colorWithRed:244/255.0 green:63/255.0 blue:81/255.0 alpha:1.0];
    canjiaBtn.clipsToBounds = YES;
    canjiaBtn.layer.cornerRadius = 6.0;
    [canjiaBtn addTarget:self action:@selector(canjia) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(canjiaBtn.right + 20, hContent.bottom + 5, 90, 30);
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.clipsToBounds = YES;
    shareBtn.layer.cornerRadius = 6.0;
    shareBtn.backgroundColor = [UIColor colorWithRed:54/255.0 green:100/255.0 blue:1.0 alpha:1.0];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    self.showView.frame = CGRectMake(0, 0, 320, huodongIM.height + hCanjia.height + hContent.height + shareBtn.height + 10 - 64);
    //self.showView.backgroundColor = [UIColor whiteColor];
    NSLog(@"%f", self.showView.height);
    //[self.showView addSubview:shareBtn];
    //[self.showView addSubview:canjiaBtn];
    [self.showView addSubview:hContent];
    [self.showView addSubview:hCanjia];
    [self.showView addSubview:huodongIM];
    self.showView.userInteractionEnabled = YES;
    [self.detailArray addObject:_showView];
    [self.bigArray addObject:_detailArray];
    
    //[self.view addSubview:_showView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datadelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tPictureArray.count > 0) {
        return [[self.bigArray objectAtIndex:section] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, self.showView.height)];
        UIButton *canjiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        canjiaBtn.frame = CGRectMake(20, _showView.bottom + 20, 170, 30);
        [canjiaBtn setTitle:@"参加活动" forState:UIControlStateNormal];
        canjiaBtn.backgroundColor = [UIColor colorWithRed:244/255.0 green:63/255.0 blue:81/255.0 alpha:1.0];
        canjiaBtn.clipsToBounds = YES;
        canjiaBtn.layer.cornerRadius = 6.0;
        [canjiaBtn addTarget:self action:@selector(canjia) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(canjiaBtn.right + 20, _showView.bottom + 20, 90, 30);
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        shareBtn.clipsToBounds = YES;
        shareBtn.layer.cornerRadius = 6.0;
        shareBtn.backgroundColor = [UIColor colorWithRed:54/255.0 green:100/255.0 blue:1.0 alpha:1.0];
        [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:canjiaBtn];
        [cell addSubview:shareBtn];
        [cell addSubview:_showView];
        //cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }
    else
    {
        static NSString *indefine = @"cell";
        TpiceturCell *cell = [tableView dequeueReusableCellWithIdentifier:indefine];
        if (!cell) {
            cell = [[TpiceturCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefine];
        }
        //cell.backgroundColor = [UIColor redColor];
        cell.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
        if (self.tPictureArray.count > 0) {
            NSLog(@"%@", [[self.tPictureArray objectAtIndex:indexPath.row] userName]);
            cell.pictureMode = [self.tPictureArray objectAtIndex:indexPath.row];
        }
        for (int i = 0; i < cell.likeArray.count; i++) {
            if (cell.likeBtn.tag == [[cell.likeArray objectAtIndex:i] intValue]) {
                NSLog(@"/*-/*/**//**/*/*//-*/-*/-*/%@", [cell.likeArray objectAtIndex:i]);
                [cell.likeBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
                int a = [cell.likeLab.text intValue] + 1;
                cell.likeLab.text = [NSString stringWithFormat:@"%d", a];
                cell.likeLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
                
                cell.Dselect = NO;
            }
            
        }
        for (int i = 0; i < cell.likeArray.count; i++) {
            if (cell.assginBtn.tag == [[cell.likeArray objectAtIndex:i] intValue]) {
                [cell.assginBtn setImage:[UIImage imageNamed:@"assignt0"] forState:UIControlStateNormal];
                int b = [cell.assigntLab.text intValue] + 1;
                cell.assigntLab.text = [NSString stringWithFormat:@"%d", b];
                cell.assigntLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
                cell.Dselect = NO;
            }
            
        }
        cell.delegate = self;
        return cell;
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        return self.showView.height + 64;
    }
    return [TpiceturCell getCellHeight:[self.tPictureArray objectAtIndex:indexPath.row]];
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
 return 10;
 }*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"**********************%@", indexPath);
    if (indexPath.section == 0) {
        
    }
    else{
        NSLog(@"%@", [NSString stringWithFormat:@"%@", [[self.tPictureArray objectAtIndex:indexPath.row] hotDot]]);
        if ([[NSString stringWithFormat:@"%@", [[self.tPictureArray objectAtIndex:indexPath.row] hotDot]] isEqualToString:@"0"]) {
            UIAlertView *viewalert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无评论" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [viewalert show];

        }
        else{
            TdetailViewController *detailVC = [[TdetailViewController alloc] init];
            [self.navigationController pushViewController:detailVC animated:YES];
            detailVC.duanzi = [self.tPictureArray objectAtIndex:indexPath.row];
        }
    }
}

#pragma mark - enjoy
- (void)rootUser:(TpiceturCell *)cell
{
    TuserViewController *tuserVC = [[TuserViewController alloc] init];
    [self.navigationController pushViewController:tuserVC animated:YES];
    tuserVC.userId = cell.pictureMode.userId;
    NSLog(@"%@", cell.pictureMode.userName);
}


#pragma mark - share
- (void)share
{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:self.hText
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

- (void)canjia
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"要冷静, 您的等级还不够" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - meaage
- (void)message:(MCFireworksButton *)btn
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    if ([btn.currentTitle isEqualToString:@"0"]) {
        hud.labelText = @"你已顶过";
    }
    else{
        hud.labelText = @"你已踩过";
    }
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.5];
    
}

#pragma mark - changzhaungtai
- (void)changColorlikeBtn:(TpiceturCell *)cell
{
    NSLog(@"%@", (cell.Dselect == 1 ? @"YES" :@"NO"));
    if (cell.Dselect) {
        [cell.likeBtn popOutsideWithDuration:0.5];
        [cell.likeBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        [cell.likeBtn animate];
        [cell.likeArray addObject:[NSString stringWithFormat:@"%d", cell.likeBtn.tag]];
        [cell.likeArray addObject:[NSString stringWithFormat:@"%d", cell.likeLab.tag]];
        int a = [cell.likeLab.text intValue] + 1;
        cell.likeLab.text = [NSString stringWithFormat:@"%d", a];
        cell.likeLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
        cell.isTure = @"0";
        cell.Dselect = NO;
    }
    else{
        [cell.likeBtn setTitle:cell.isTure forState:UIControlStateNormal];
        cell.likeBtn.titleLabel.font = [UIFont systemFontOfSize:0.01];
        [self message:cell.likeBtn];
    }
    
}

- (void)changColorassigntBtn:(TpiceturCell *)cell
{
    NSLog(@"%@", (cell.Dselect == 1 ? @"YES" :@"NO"));
    if (cell.Dselect) {
        [cell.assginBtn popOutsideWithDuration:0.5];
        [cell.assginBtn setImage:[UIImage imageNamed:@"assignt0"] forState:UIControlStateNormal];
        [cell.assginBtn animate];
        [cell.likeArray addObject:[NSString stringWithFormat:@"%d", cell.assginBtn.tag]];
        [cell.likeArray addObject:[NSString stringWithFormat:@"%d", cell.assigntLab.tag]];
        int a = [cell.assigntLab.text intValue] + 1;
        cell.assigntLab.text = [NSString stringWithFormat:@"%d", a];
        cell.assigntLab.textColor = [UIColor colorWithRed:47 / 255.0 green:119 / 255.0 blue:255 / 255.0 alpha:1.0];
        cell.isTure = @"1";
        cell.Dselect = NO;
    }
    else{
        [cell.assginBtn setTitle:cell.isTure forState:UIControlStateNormal];
        cell.assginBtn.titleLabel.font = [UIFont systemFontOfSize:0.01];
        [self message:cell.assginBtn];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
