//
//  UserViewController.m
//  test
//
//  Created by baoyuan on 14-9-2.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "UserViewController.h"
#import "UserModel.h"
#import "UIViewAdditions.h"
#import "TougaoViewController.h"
#import "PinglunViewController.h"
#import "ShoucangViewController.h"
#import "MCTopAligningLabel.h"
#define MARIGN 10
#define FONTSIZE 12
@interface UserViewController ()

@end

@implementation UserViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    /*UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, 320, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];*/
    
    
    //NSLog(@"%@", _userId);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ic.snssdk.com/2/essay/profile/?user_id=%@&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&uuid=863308022120649&openudid=a814218a3fc50c5b", _userId]];
    
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
                
                [[tempDic objectForKey:@"data"] objectForKey:@"name"];
                self.user = [[UserModel alloc] init];
                self.user.userName = [[tempDic objectForKey:@"data"] objectForKey:@"name"];
                //self.user.description = [[tempDic objectForKey:@"data"] objectForKey:@"description"];
                self.user.point = [[tempDic objectForKey:@"data"] objectForKey:@"point"];
                self.user.ugc = [[tempDic objectForKey:@"data"] objectForKey:@"ugc_count"];
                self.user.userPicture = [[tempDic objectForKey:@"data"] objectForKey:@"avatar_url"];
                self.user.essay = [[tempDic objectForKey:@"data"] objectForKey:@"essay_repin_count"];
                self.user.comment = [[tempDic objectForKey:@"data"] objectForKey:@"comment_count"];
                
                NSLog(@"%@", [[tempDic objectForKey:@"data"] objectForKey:@"name"] );
                
                
                [self createView:_user];
                [self createMessage:_user];
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

- (void)createView:(UserModel *)user
{
    UIView *userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    //userView.backgroundColor = [UIColor redColor];
    
    UIImageView *imagePicture = [[UIImageView alloc] initWithFrame:CGRectMake(MARIGN, MARIGN, 80, 80)];
    imagePicture.clipsToBounds = YES;
    imagePicture.layer.cornerRadius = 4.0;
    imagePicture.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.userPicture]]];
    [userView addSubview:imagePicture];
    
    UILabel *userLab = [[UILabel alloc] initWithFrame:CGRectMake(imagePicture.right + MARIGN, MARIGN, 320 - imagePicture.right - 2 * MARIGN, 20)];
    userLab.text = user.userName;
    userLab.font = [UIFont systemFontOfSize:FONTSIZE];
    [userView addSubview:userLab];
    
    UILabel *pointLab = [[UILabel alloc] initWithFrame:CGRectMake(imagePicture.right + MARIGN, userLab.bottom + 5, 320 - imagePicture.right - 2 * MARIGN, 20)];
    pointLab.text = [NSString stringWithFormat:@"积分: %@", user.point];
    pointLab.textColor = [UIColor colorWithRed:130 / 255.0 green:100 / 255.0 blue:20 / 255.0 alpha:1.0];
    pointLab.font = [UIFont systemFontOfSize:FONTSIZE];
    [userView addSubview:pointLab];
    
    MCTopAligningLabel *desprictLab = [[MCTopAligningLabel alloc] initWithFrame:CGRectMake(imagePicture.right + MARIGN, pointLab.bottom + 5, 320 - imagePicture.right - 2 * MARIGN, 40)];
    desprictLab.numberOfLines = 0;
    //desprictLab.textAlignment =
    desprictLab.text = user.description;
    desprictLab.font = [UIFont systemFontOfSize:FONTSIZE];
    [userView addSubview:desprictLab];
    
    [self.view addSubview:userView];
}

- (void)createMessage:(UserModel *)user
{
    UIImageView *aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 320, 30)];
    aImageView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    aImageView.userInteractionEnabled = YES;
    UIImageView *tougaoIM = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    tougaoIM.image = [UIImage imageNamed:@"tougao.png"];
    UILabel *tougaoLab = [[UILabel alloc] initWithFrame:CGRectMake(tougaoIM.right + MARIGN * 2, 5, 100, 20)];
    tougaoLab.text = @"投稿";
    UILabel *tougao = [[UILabel alloc] initWithFrame:CGRectMake(320 - MARIGN * 5, 5, 30, 20)];
    tougao.text = [NSString stringWithFormat:@"%@", user.ugc];
    tougao.textAlignment = NSTextAlignmentRight;
    UIButton *tougaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tougaoBtn.frame = CGRectMake(0, 0, 320, 30);
    [tougaoBtn addTarget:self action:@selector(tougao) forControlEvents:UIControlEventTouchUpInside];
    //tougaoBtn.backgroundColor = [UIColor blueColor];
    [aImageView addSubview:tougaoBtn];
    [aImageView addSubview:tougao];
    [aImageView addSubview:tougaoLab];
    [aImageView addSubview:tougaoIM];
    //aImageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:aImageView];
    
    UIImageView *bImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, aImageView.bottom + 1, 320, 30)];
    bImageView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    bImageView.userInteractionEnabled = YES;
    UIImageView *pinglunIM = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    pinglunIM.image = [UIImage imageNamed:@"pinglun.png"];
    UILabel *pinglunLab = [[UILabel alloc] initWithFrame:CGRectMake(tougaoIM.right + MARIGN * 2, 5, 100, 20)];
    pinglunLab.text = @"评论";
    UILabel *pinglun = [[UILabel alloc] initWithFrame:CGRectMake(320 - MARIGN * 5, 5, 30, 20)];
    pinglun.text = [NSString stringWithFormat:@"%@", user.comment];
    pinglun.textAlignment = NSTextAlignmentRight;
    UIButton *pinglunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pinglunBtn.frame = CGRectMake(0, 0, 320, 30);
    [pinglunBtn addTarget:self action:@selector(pinglun) forControlEvents:UIControlEventTouchUpInside];
    //pinglunBtn.backgroundColor = [UIColor blueColor];
    [bImageView addSubview:pinglunBtn];
    [bImageView addSubview:pinglun];
    [bImageView addSubview:pinglunLab];
    [bImageView addSubview:pinglunIM];
    //bImageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bImageView];
    
    UIImageView *cImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, bImageView.bottom + 1, 320, 30)];
    cImageView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    cImageView.userInteractionEnabled = YES;
    UIImageView *shoucangIM = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    shoucangIM.image = [UIImage imageNamed:@"shoucang.png"];
    UILabel *shoucangLab = [[UILabel alloc] initWithFrame:CGRectMake(tougaoIM.right + MARIGN * 2, 5, 100, 20)];
    shoucangLab.text = @"收藏";
    UILabel *shoucang = [[UILabel alloc] initWithFrame:CGRectMake(320 - MARIGN * 5, 5, 30, 20)];
    shoucang.text = [NSString stringWithFormat:@"%@", user.essay];
    shoucang.textAlignment = NSTextAlignmentRight;
    UIButton *shoucangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shoucangBtn.frame = CGRectMake(0, 0, 320, 30);
    [shoucangBtn addTarget:self action:@selector(shoucang) forControlEvents:UIControlEventTouchUpInside];
    //shoucangBtn.backgroundColor = [UIColor blueColor];
    [cImageView addSubview:shoucangBtn];
    [cImageView addSubview:shoucang];
    [cImageView addSubview:shoucangLab];
    [cImageView addSubview:shoucangIM];
    //cImageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:cImageView];
    
}


- (void)tougao
{
    TougaoViewController *tougaoVC = [[TougaoViewController alloc] init];
    tougaoVC.userId = _userId;
    [self.navigationController pushViewController:tougaoVC animated:YES];
}

- (void)pinglun
{
    PinglunViewController *pinglunVC = [[PinglunViewController alloc] init];
    pinglunVC.userId = _userId;
    [self.navigationController pushViewController:pinglunVC animated:YES];
}

- (void)shoucang
{
    ShoucangViewController *shoucangVC = [[ShoucangViewController alloc] init];
    shoucangVC.userId = _userId;
    [self.navigationController pushViewController:shoucangVC animated:YES];
}
#pragma mark datasoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indefine = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefine];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefine];
    
    }
    return cell;
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
