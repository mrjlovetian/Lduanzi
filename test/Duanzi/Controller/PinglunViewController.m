//
//  PinglunViewController.m
//  test
//
//  Created by baoyuan on 14-9-2.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "PinglunViewController.h"
#import "PinglunCell.h"
#import "PinglunModel.h"
@interface PinglunViewController ()

@end

@implementation PinglunViewController

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
    self.pingLunArray = [NSMutableArray arrayWithCapacity:1];
    NSLog(@"-*-*-*-*-*-*-%@", _userId);
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://isub.snssdk.com/13/update/user/?count=20&user_id=%@&min_create_time=0&type=comment&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&uuid=863308022120649&openudid=a814218a3fc50c5b", _userId]];
    
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
                for (int i = 0; i < [[tempDic objectForKey:@"data"] count]; i++) {
                    PinglunModel *plMode = [[PinglunModel alloc] init];
                    plMode.text = [[[tempDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"text"];
                    plMode.userName = [[[tempDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"user_screen_name"];
                    plMode.userPictureUrl = [[[tempDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"avatar_url"];
                    plMode.content = [[[tempDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"content"];
                    plMode.time = [[[tempDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"create_time"];
                    
                    [self.pingLunArray addObject:plMode];
                    NSLog(@"*-*-*-*-*-*-*%@", [[[tempDic objectForKey:@"data"] firstObject] objectForKey:@"text"]);
                }
                [tableView reloadData];
            }
            
        }
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datadelgte
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pingLunArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indefine = @"cell";
    PinglunCell *cell = [tableView dequeueReusableCellWithIdentifier:indefine];
    if (!cell) {
        cell = [[PinglunCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefine];
    }
    cell.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    NSLog(@"/*/*/*/**/*/*/%@", [[self.pingLunArray objectAtIndex:indexPath.row] time]);
    cell.plmode = [self.pingLunArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PinglunCell getCellHeight:[self.pingLunArray objectAtIndex:indexPath.row]];
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
