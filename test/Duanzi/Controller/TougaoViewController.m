//
//  TougaoViewController.m
//  test
//
//  Created by baoyuan on 14-9-2.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "TougaoViewController.h"
#import "Duanzi.h"
#import "DuanziCell.h"
@interface TougaoViewController ()

@end

@implementation TougaoViewController

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
    
    self.userArray = [NSMutableArray arrayWithCapacity:1];
    //self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
     tableView.delegate = self;
     tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self.view addSubview:tableView];
    
    
    NSLog(@"%@", _userId);
    self.userArray = [NSMutableArray arrayWithCapacity:1];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ic.snssdk.com/2/essay/zone/user/posts/?user_id=%@&count=30&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&uuid=863308022120649&openudid=a814218a3fc50c5b", _userId]];
    
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
                
                /*[[tempDic objectForKey:@"data"] objectForKey:@"name"];
                
                NSLog(@"%@", [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] firstObject] objectForKey:@"group"] objectForKey:@"content"] );*/
                //[self.userArray addObject:_user];
                for (int i = 0; i < [[[tempDic objectForKey:@"data"] objectForKey:@"data"] count]; i++) {
                    Duanzi *myDuanzi = [[Duanzi alloc] init];
                    myDuanzi.userName = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"name"];
                    myDuanzi.userImageUrl = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"avatar_url"];
                    myDuanzi.like = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"digg_count"];
                    myDuanzi.assignt = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"bury_count"];
                    myDuanzi.hotDot = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"comment_count"];
                    myDuanzi.content = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"content"];
                    myDuanzi.userId = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"user_id"];
                    [self.userArray addObject:myDuanzi];
                    //NSLog(@"**************%@", myDuanzi.userId);
                    
                }
                [tableView reloadData];
                //NSLog(@"%@", tempDic);
            }
            
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark datasoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indefint = @"cell";
    DuanziCell *cell = [tableView dequeueReusableCellWithIdentifier:indefint];
    if (!cell) {
        cell = [[DuanziCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefint];
    }
    cell.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    cell.cellDuanzi = [self.userArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DuanziCell getCellHeight:[self.userArray objectAtIndex:indexPath.row]];
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
