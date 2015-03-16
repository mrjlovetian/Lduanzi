//
//  AsynlmageView.m
//  TestProjiect
//
//  Created by 陈龙海 on 14-8-4.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "AsynlmageView.h"

#import "UIImageView+WebCache.h"

@implementation AsynlmageView
- (void)dealloc
{
    self.url = nil;
    [super dealloc];
}
//重写setter方法,异步请求图片,显示
- (void)setUrl:(NSString *)url
{
    if (_url != url) {
        [_url release];
        _url = [url retain];
    }
    
    //缓冲文件夹
  NSString * cashPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //转化文件名字
    NSString *fileName = [_url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    //文件的路径
    NSString *filePath = [cashPath stringByAppendingPathComponent:fileName];
    //判断缓存文件夹是否存在
    NSFileManager * fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        //感觉不行的样子
        self.image = [UIImage imageWithContentsOfFile:filePath];
    }else{
        
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    
    //创建url
   /* NSURL *aUrl = [NSURL URLWithString:url];
    //创建urlrequest
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:aUrl];
    //创建异步请求链接
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"erro:%@", [connectionError description]);
        }else
        {
            UIImage * aImage = [[UIImage alloc] initWithData:data];
            self.image = aImage;
            
             //写入文件
         BOOL result = [data writeToFile:filePath atomically:YES];
            if (result) {
                NSLog(@"写入成功");
            }else
            {
            
                NSLog(@"写入失败");

            }

        }
    }];*/
        
      
      
        
        
        
        
    }

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
