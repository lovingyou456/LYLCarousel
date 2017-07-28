//
//  YLLunBoQi.h
//  图片轮播器
//
//  Created by 李灯涛 on 2017/3/28.
//  Copyright © 2017年 李灯涛. All rights reserved.
//

#import <UIKit/UIKit.h>

//轮播器定时器调用时间间隔(秒)
#define YL_LUNBOQI_TIMER_TIME_INTERVAL  3.0

@class YLLunBoQi;

@protocol YLLunBoQiDelegate <NSObject>

@optional


/**
 图片轮播器中图片的点击回调

 @param luboqi 产生回调的图片轮播器
 @param index 被点击图片对应的索引
 */
-(void)YLLunBoqi:(YLLunBoQi *)luboqi didImageClickedWithIndex:(NSInteger)index;

@end


@interface YLLunBoQi : UIView


/**
 图片轮播器中所包含的图片的数组
 */
@property(nonatomic, strong) NSArray * images;

@property(nonatomic, weak) id<YLLunBoQiDelegate> delegate;


@end
