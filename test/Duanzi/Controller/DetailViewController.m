//
//  DetailViewController.m
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "DetailViewController.h"
#import "Duanzi.h"
#import "UIViewAdditions.h"
#import "PLModel.h"
#import "PLmodeCell.h"
@interface DetailViewController ()
@property (nonatomic, retain)UITableView *tableView;
@end

@implementation DetailViewController

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
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    self.deatialArray = [NSMutableArray arrayWithCapacity:1];
    NSLog(@"*-*-*-*-*-*%@, %@", _duanzi.userId, _duanzi.content);
    
    UIView *detial = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 100)];
    //detial.backgroundColor = [UIColor yellowColor];
    [detial addSubview:view];
    [self.view addSubview:detial];
    
    UIImageView *userPC = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    userPC.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_duanzi.userImageUrl]]];
    [detial addSubview:userPC];
    
    UILabel *userLab = [[UILabel alloc] initWithFrame:CGRectMake(userPC.right + 10, 10, 200, 30)];
    userLab.text = _duanzi.userName;
    [detial addSubview:userLab];
    
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(10, userPC.bottom + 10, 300, 0)];
    contentLab.numberOfLines = 0;
    contentLab.font = [UIFont systemFontOfSize:13];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    
    CGRect frame = [_duanzi.content boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    contentLab.text = _duanzi.content;
    contentLab.frame = CGRectMake(10, userPC.bottom + 10, 300, frame.size.height);
    detial.frame = CGRectMake(0, 64, 320, 10 + 10 + 30 + 10 + frame.size.height);
    view.frame = CGRectMake(5, 5, 310, 10 + 30 + 10 + frame.size.height);
    
    [detial addSubview:contentLab];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, detial.bottom, 300, [UIScreen mainScreen].bounds.size.height - detial.bottom - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deatialArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indenfine = @"cell";
    PLmodeCell *cell = [tableView dequeueReusableCellWithIdentifier:indenfine];
    if (!cell) {
        cell = [[PLmodeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indenfine];
    }
    cell.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    cell.plMode = [self.deatialArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str = @"热门评价";
    return str;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PLmodeCell getCellHeight:[self.deatialArray objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
