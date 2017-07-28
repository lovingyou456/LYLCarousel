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
    
    YLLunBoQi *lunboqi = [YLLunBoQi new];
    
    CGFloat x = 20;
    CGFloat y = 20;
    CGFloat width = self.view.bounds.size.width - 20 * 2;
    CGFloat height = width * 400 / 950;
    [lunboqi setFrame:CGRectMake(x, y, width, height)];
    
    ;
    
    [lunboqi setImages:@[[UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1.jpg" ofType:nil]]],
                         [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2.jpg" ofType:nil]]],
                         [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"3.jpg" ofType:nil]]],
                         [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"4.jpg" ofType:nil]]],
                         [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"5.jpg" ofType:nil]]],
                         [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"6.jpg" ofType:nil]]],
                         [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"7.jpg" ofType:nil]]],
                         [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"8.jpg" ofType:nil]]]]];
    
    [lunboqi setDelegate:self];
    
    [self.view addSubview:lunboqi];
}

-(void)YLLunBoqi:(YLLunBoQi *)luboqi didImageClickedWithIndex:(NSInteger)index
{
    NSLog(@"index:%zd", index);
}


@end
