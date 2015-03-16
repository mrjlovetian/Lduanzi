//
//  TshoucangViewController.m
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "TshoucangViewController.h"
#import "PictureModel.h"
#import "TpiceturCell.h"
@interface TshoucangViewController ()

@end

@implementation TshoucangViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    NSLog(@"%@", _userId);
    self.userArray = [NSMutableArray arrayWithCapacity:1];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ic.snssdk.com/2/essay/zone/user/favorites/?user_id=%@&count=30&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&uuid=863308022120649&openudid=a814218a3fc50c5b", _userId]];
    
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
                    [self.userArray addObject:pcMode];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indefint = @"cell";
    TpiceturCell *cell = [tableView dequeueReusableCellWithIdentifier:indefint];
    if (!cell) {
        cell = [[TpiceturCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefint];
    }
    
    cell.pictureMode = [self.userArray objectAtIndex:indexPath.row];
    //NSLog(@"=============%@", [[self.showArray objectAtIndex:indexPath.row] userName]);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TpiceturCell getCellHeight:[self.userArray objectAtIndex:indexPath.row]];
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
