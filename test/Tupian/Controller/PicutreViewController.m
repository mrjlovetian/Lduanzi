//
//  PicutreViewController.m
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "PicutreViewController.h"
#import "PictureModel.h"
#import "TpiceturCell.h"
#import "TuserViewController.h"
#import "TdetailViewController.h"
#import "MJRefresh.h"
#import "MCFireworksButton.h"
#import "MBProgressHUD.h"
@interface PicutreViewController ()<enjoy>
@property (nonatomic, retain)UITableView *tableView;
@end

@implementation PicutreViewController

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
    //self.tabBarItem.selectedImage = [UIImage imageNamed:@"tupian2.png"];
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    self.tPictureArray = [NSMutableArray arrayWithCapacity:1];
    self.view.backgroundColor = [UIColor grayColor];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height  - 46) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getPath]]) {
        [self unarchiver];
    }
    else
    {
        [self creatUrl];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getLength]]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"open"] isEqualToString:@"YES"]) {
            [self read];
        }
        
    }
    
    // 2.集成刷新控件
    [self setupRefresh];
    // Do any additional setup after loading the view.
}

- (void)refresh
{
    
    [self creatUrl];
    //self.tableView.contentOffset = CGPointMake(0, 0);
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
    
    [keyeAchiver encodeObject:self.tPictureArray forKey:@"stu"];//对准备压缩的对象(如NSArray),进行标记, 基赋值键值key
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
    
    self.tPictureArray = [unarchiver decodeObjectForKey:@"stu"];
    [unarchiver finishDecoding];
}

- (NSString *)getPath
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"tupian.plist"];
    return path;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"********************%g", self.tableView.contentOffset.y);
    [self write];
}

- (void)read
{
    NSString *leng = [[NSString alloc] initWithContentsOfFile:[self getLength] encoding:NSUTF8StringEncoding error:nil];
    self.tableView.contentOffset = CGPointMake(0, [leng floatValue]);
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
    NSString *length = [NSString stringWithFormat:@"%f", self.tableView.contentOffset.y];
    if([length writeToFile:[self getLength] atomically:YES encoding:NSUTF8StringEncoding error:nil])
    {
        NSLog(@"success!");
    }else
    {
        NSLog(@"不对");
    }
    
}
- (NSString *)getLength
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"picture.txt"];
    return path;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //[self.table headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        //[self.table reloadData];
        [self.tPictureArray removeAllObjects];
        [self creatUrl];
        
        
    });
}
- (void)footerRereshing
{
    [self.tableView footerEndRefreshing];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已完全加载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
}

- (void)creatUrl
{
    NSURL *url = [NSURL URLWithString:@"http://ic.snssdk.com/2/essay/zone/category/data/?category_id=2&level=6&count=30&min_time=1409407952&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&uuid=863308022120649&openudid=a814218a3fc50c5b"];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"+++++++++++++++++++++++++++%@", connectionError);
        }
        else
        {
            NSError *error = nil;
            NSMutableDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"**********************%@", error);
            }
            else{
                [self.tPictureArray removeAllObjects];
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
                    //NSLog(@"****************tHeight = %@, tWeight = %@", pcMode.tHeight, pcMode.tWeight);
                    [self.tPictureArray addObject:pcMode];
                }
                [self.tableView reloadData];
                [self archiver];
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [self.tableView headerEndRefreshing];
            }
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
    return self.tPictureArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *indefine = @"cell";
        TpiceturCell *cell = [tableView dequeueReusableCellWithIdentifier:indefine];
        if (!cell) {
            cell = [[TpiceturCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefine];
        }
        //cell.backgroundColor = [UIColor redColor];
        cell.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    
    if (self.tPictureArray.count > 0) {
        cell.pictureMode = [self.tPictureArray objectAtIndex:indexPath.row];
        cell.likeBtn.tag = indexPath.row + 100;
        cell.likeLab.tag = indexPath.row + 200;
        cell.assginBtn.tag = indexPath.row + 500;
        cell.assigntLab.tag = indexPath.row +600;
        NSLog(@"%@", [[self.tPictureArray objectAtIndex:indexPath.row] userName]);
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
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TpiceturCell getCellHeight:[self.tPictureArray objectAtIndex:indexPath.row]];
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%@", indexPath);
    //NSLog(@"%@", [NSString stringWithFormat:@"%@", [[self.tPictureArray objectAtIndex:indexPath.row] hotDot]]);
    if (self.tPictureArray.count>0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma maek - message
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
