//
//  GLTransitionManager.h
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/23.
//  Copyright © 2017年 高磊. All rights reserved.
//  转场动画管理类 push pop present dismiss均在此类中进行统一管理

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GLTransitionManager : NSObject<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

/**
 转场动画的时间 默认为0.5s
 */
@property (nonatomic,assign) NSTimeInterval duration;

/**
 入场动画 
 
 @param contextTransition 实现动画
 */
- (void)setToAnimation:(id<UIViewControllerContextTransitioning>)contextTransition;


/**
 退场动画
 
 @param contextTransition 实现动画
 */
- (void)setBackAnimation:(id<UIViewControllerContextTransitioning>)contextTransition;

@end
