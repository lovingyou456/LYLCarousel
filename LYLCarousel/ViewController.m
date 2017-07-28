//
//  ViewController.m
//  LYLCarousel
//
//  Created by 李灯涛 on 2017/7/28.
//  Copyright © 2017年 李灯涛. All rights reserved.
//

#import "ViewController.h"
#import "YLLunBoQi.h"

@interface ViewController ()<YLLunBoQiDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YLLunBoQi *lunboqi = [[YLLunBoQi alloc] initWithTimeInterval:3.0];
    
    CGFloat x = 20;
    CGFloat y = 20;
    CGFloat width = self.view.bounds.size.width - 20 * 2;
    CGFloat height = width * 400 / 950;
    [lunboqi setFrame:CGRectMake(x, y, width, height)];
    
    ;
    
    lunboqi.placeholderImageName = @"6.jpg";
        
    [lunboqi setImageUrls:@[@"http://pic1.win4000.com/wallpaper/8/539fa4d37594c.jpg",
                            @"http://b.hiphotos.baidu.com/image/pic/item/9a504fc2d5628535b452cae099ef76c6a6ef6344.jpg",
                            @"http://bizhi.zhuoku.com/wall/jie/20070330/ml/022.jpg",
                            @"http://img.tuku.cn/file_big/201503/d8905515d1c046aeba51025f0ea842f0.jpg",
                            @"http://pic10.nipic.com/20100929/4308872_150108084472_2.jpg",
                            @"http://tupian.enterdesk.com/2014/mxy/02/11/4/4.jpg",
                            @"http://www.pp3.cn/uploads/201606/20160630011.jpg",
                            @"http://img.zcool.cn/community/05e5e1554af04100000115a8236351.jpg",
                            @"http://image.elegantliving.ceconline.com/320000/320100/20110815_03_52.jpg",
                            @"http://f.hiphotos.baidu.com/image/pic/item/80cb39dbb6fd5266953d8467a118972bd40736aa.jpg"
                            ]];
    
    [lunboqi setDelegate:self];
    
    [self.view addSubview:lunboqi];
}

-(void)YLLunBoqi:(YLLunBoQi *)luboqi didImageClickedWithIndex:(NSInteger)index
{
    NSLog(@"index:%zd", index);
}


@end
