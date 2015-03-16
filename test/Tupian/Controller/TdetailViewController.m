//
//  TdetailViewController.m
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "TdetailViewController.h"

#import "PictureModel.h"
#import "UIViewAdditions.h"
#import "PLModel.h"
#import "PLmodeCell.h"
#import "AsynlmageView.h"

#define FONTSIZE 13
@interface TdetailViewController ()
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UIView *detial;
@end

@implementation TdetailViewController

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
    self.deatialArray = [NSMutableArray arrayWithCapacity:1];
    self.bigArray = [NSMutableArray arrayWithCapacity:1];
    self.smallArray = [NSMutableArray arrayWithCapacity:1];
    NSLog(@"*-*-*-*-*-*%@, %@", _duanzi.userId, _duanzi.content);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.detial = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    //detial.backgroundColor = [UIColor yellowColor];
    //[self.view addSubview:detial];
    [self.smallArray addObject:_detial];
    [self.bigArray addObject:_smallArray];
    
    UIImageView *userPC = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    userPC.clipsToBounds = YES;
    userPC.layer.cornerRadius = 3.0;
    userPC.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_duanzi.userImageUrl]]];
    [self.detial addSubview:userPC];
    
    UILabel *userLab = [[UILabel alloc] initWithFrame:CGRectMake(userPC.right + 10, 10, 200, 30)];
    userLab.font = [UIFont systemFontOfSize:FONTSIZE];
    userLab.text = _duanzi.userName;
    [self.detial addSubview:userLab];

    AsynlmageView *imageIm = [[AsynlmageView alloc] initWithFrame:CGRectMake(0, userPC.bottom + 5, 300, [_duanzi.tHeight intValue] / 2)];
    imageIm.url = _duanzi.tConUrl;
    self.detial.frame = CGRectMake(0, 0, 320, 22 + 10 + 10 + 30 + 10 + [_duanzi.tHeight intValue] / 2);
    [self.detial addSubview:imageIm];
    
    UILabel *pinglnLab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageIm.bottom + 5, 320, 22)];
    pinglnLab.backgroundColor = [UIColor grayColor];
    pinglnLab.text = @"热门评论";
    pinglnLab.font = [UIFont systemFontOfSize:FONTSIZE];
    [self.detial addSubview:pinglnLab];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    //[_tableView addSubview:_detial];
    [self.view addSubview:_tableView];
    
    [self createUrl];
}

- (void)createUrl
{
    NSLog(@"0000000000000000000");
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://isub.snssdk.com/2/data/get_essay_comments/?group_id=%@&count=20&offset=0&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&uuid=863308022120649&openudid=a814218a3fc50c5b", _duanzi.groupId]];
    
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
                for (int i = 0; i < [[[tempDic objectForKey:@"data"] objectForKey:@"recent_comments"] count]; i++) {
                    
                    PLModel *model = [[PLModel alloc] init];
                    model.pName = [[[[tempDic objectForKey:@"data"] objectForKey:@"recent_comments"] objectAtIndex:i] objectForKey:@"user_name"];
                    model.pPurl = [[[[tempDic objectForKey:@"data"] objectForKey:@"recent_comments"] objectAtIndex:i] objectForKey:@"user_profile_image_url"];
                    model.pText = [[[[tempDic objectForKey:@"data"] objectForKey:@"recent_comments"] objectAtIndex:i] objectForKey:@"text"];
                    model.pTime = [[[[tempDic objectForKey:@"data"] objectForKey:@"recent_comments"] objectAtIndex:i] objectForKey:@"create_time"];
                    
                    [self.deatialArray addObject:model];
                    [self.bigArray addObject:_deatialArray];
                    
                }
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datadelegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (self.deatialArray.count > 0) {
         return [[self.bigArray objectAtIndex:section] count];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, _detial.height)];
        [cell addSubview:_detial];
        return cell;
    }
    else
    {
        static NSString *indenfine = @"cell";
        PLmodeCell *cell = [tableView dequeueReusableCellWithIdentifier:indenfine];
        if (!cell) {
            cell = [[PLmodeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indenfine];
        }
        cell.plMode = [self.deatialArray objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
}



- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _detial.height;
    }
    return [PLmodeCell getCellHeight:[self.deatialArray objectAtIndex:indexPath.row]];

    
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
