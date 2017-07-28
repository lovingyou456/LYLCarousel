//
//  YLLunBoQi.h
//  图片轮播器
//
//  Created by 李灯涛 on 2017/3/28.
//  Copyright © 2017年 李灯涛. All rights reserved.
//

#import <UIKit/UIKit.h>

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

/** 图片轮播器中所包含的图片的数组 */
@property(nonatomic, strong) NSArray * imageUrls;

/** 加载网络图片时的占位图片 */
@property(nonatomic, copy) NSString * placeholderImageName;

/** 轮播器的事件代理 */
@property(nonatomic, weak) id<YLLunBoQiDelegate> delegate;

/**
 使用轮播器切换时间间隔初始化轮播器对象

 @param timeInterVal 轮播器图片更换调用时间间隔(秒)
 @return 轮播器对象
 */
-(instancetype)initWithTimeInterval:(NSTimeInterval)timeInterVal;


@end
