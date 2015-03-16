//
//  HomeViewController.m
//  test
//
//  Created by baoyuan on 14-9-1.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "HomeViewController.h"
#import "DuanziCell.h"
#import "Duanzi.h"
#import "UserViewController.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "MCFireworksButton.h"
#import "MBProgressHUD.h"

#import "EAIntroView.h"
@interface HomeViewController ()<cellPostVlaue, EAIntroDelegate>
@property (nonatomic, retain)UITableView *table;
@end

@implementation HomeViewController

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
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:228/255.0 green:102/255.0 blue:9/255.0 alpha:1.0];
    
    self.showArray = [NSMutableArray arrayWithCapacity:1];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
   
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getPath]]) {
        [self unarchiver];
    }
    else
    {
        [self createUrl];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getLength:@"duanzi.txt"]]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"open"] isEqualToString:@"YES"]) {
            [self read];
        }
    }
   
    // 2.集成刷新控件
    [self setupRefresh];
   
}

- (void)refresh
{
    
    [self.showArray removeAllObjects];
    [self createUrl];
    //[self headerRereshing];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"正在刷新,请稍后...";

    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.5];
    
}

//存放所有的Student类型的数据的数组进行归档
- (void)archiver
{
    NSMutableData * studentData = [[NSMutableData alloc] init] ;//对数组进行归档
    NSKeyedArchiver * keyeAchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:studentData];//创建压缩类
    
    [keyeAchiver encodeObject:self.showArray forKey:@"stu"];//对准备压缩的对象(如NSArray),进行标记, 基赋值键值key
    [keyeAchiver finishEncoding];//完成压缩
    
    BOOL result = [studentData writeToFile:[self getPath] atomically:YES];//对data数据进行写入
    if (result) {
        NSLog(@"写入成功!");
        
    }else
    {
        NSLog(@"写入失败!");
    }
    
}
//对所有的数据进行解档
- (void)unarchiver
{
    NSData * data = [NSData dataWithContentsOfFile:[self getPath]];
    
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    self.showArray = [unarchiver decodeObjectForKey:@"stu"];
    [unarchiver finishDecoding];
}

- (NSString *)getPath
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"duanzi.plist"];
    return path;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"********************%g", self.table.contentOffset.y);
    [self write];
}

- (void)read
{
    NSString *leng = [[NSString alloc] initWithContentsOfFile:[self getLength:@"duanzi.txt"] encoding:NSUTF8StringEncoding error:nil];
    self.table.contentOffset = CGPointMake(0, [leng floatValue]);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    
        hud.labelText = @"您上次观看到这里！";
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.5];
    
}

- (void)write
{
    NSString *length = [NSString stringWithFormat:@"%f", self.table.contentOffset.y];
    if([length writeToFile:[self getLength:@"duanzi.txt"] atomically:YES encoding:NSUTF8StringEncoding error:nil])
    {
        NSLog(@"success!");
    }else
    {
        NSLog(@"不对");
    }
    
}
- (NSString *)getLength:(NSString *)apath
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:apath];
    return path;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.table addHeaderWithTarget:self action:@selector(headerRereshing)];

    //[self.table headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.table addFooterWithTarget:self action:@selector(footerRereshing)];
}




#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        //[self.table reloadData];
        [self.showArray removeAllObjects];
        
        [self createUrl];
        
        
    });
}
- (void)footerRereshing
{
    [self.table footerEndRefreshing];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已完全加载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
}

- (void)createUrl
{
    
    NSURL *url = [NSURL URLWithString:@"http://ic.snssdk.com/2/essay/zone/category/data/?category_id=1&level=6&count=30&min_time=1409406750&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300"];
    
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
                for (int i = 0; i < [[[tempDic objectForKey:@"data"] objectForKey:@"data"] count]; i++) {
                    Duanzi *myDuanzi = [[Duanzi alloc] init];
                    myDuanzi.userName = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"name"];
                    myDuanzi.userImageUrl = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"avatar_url"];
                    myDuanzi.like = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"digg_count"];
                    myDuanzi.assignt = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"bury_count"];
                    myDuanzi.hotDot = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"comment_count"];
                    myDuanzi.content = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"content"];
                    myDuanzi.userId = [[[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"user_id"];
                    myDuanzi.groupId = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] objectAtIndex:i] objectForKey:@"group"] objectForKey:@"group_id"];
                    [self.showArray addObject:myDuanzi];
                   
                    
                }
                [self archiver];
            }
            [self.table reloadData];
            self.table.contentOffset = CGPointMake(0, 0);
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.table headerEndRefreshing];
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark datadelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *indefint = @"cell";
        DuanziCell *cell = [tableView dequeueReusableCellWithIdentifier:indefint];
    //DuanziCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
            cell = [[DuanziCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefint];
        }
        cell.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
        cell.delegate = self;
    if(self.showArray.count > 0)
    {
        cell.cellDuanzi = [self.showArray objectAtIndex:indexPath.row];
        cell.likeBtn.tag = indexPath.row + 100;
        cell.likeLab.tag = indexPath.row + 200;
        cell.assginBtn.tag = indexPath.row + 500;
        cell.assigntLab.tag = indexPath.row +600;
        
    }
    NSLog(@"%d", cell.likeArray.count);
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
        return cell;
}

#pragma mark - celldelegate
- (void)cellPrint:(DuanziCell *)cell
{
    NSLog(@"%@, %@", cell.userBtn.currentTitle, cell.userId);
    UserViewController *userVC = [UserViewController alloc];
    userVC.userId = cell.userId;
    [self.navigationController pushViewController:userVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DuanziCell getCellHeight:[self.showArray objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showArray.count > 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"%@", [[self.showArray objectAtIndex:indexPath.row] userName]);
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
        detailVC.duanzi = [self.showArray objectAtIndex:indexPath.row];
    }
}


#pragma mark - meaage
- (void)message:(MCFireworksButton *)btn
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    if ([btn.currentTitle isEqualToString:@"0"]) {
        hud.labelText = @"您已顶过";
    }
    else{
        hud.labelText = @"您已踩过";
    }
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.5];
    
}



#pragma mark - tabbaedelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"*********%@", NSStringFromCGSize(item.image.size));
}


- (void)changColorlikeBtn:(DuanziCell *)cell
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

- (void)changColorassigntBtn:(DuanziCell *)cell
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
