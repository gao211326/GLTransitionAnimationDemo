//
//  GLTransitionContext.h
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/24.
//  Copyright © 2017年 高磊. All rights reserved.
//  自定义转场动画的具体实现

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 GLTransitionAnimation 块

 @param contextTransition 将满足UIViewControllerContextTransitioning协议的对象传到管理内 在管理类对动画统一实现
 */
typedef void(^GLTransitionAnimationBlock)(id <UIViewControllerContextTransitioning> contextTransition);

@interface GLTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,copy) GLTransitionAnimationBlock animationBlock;

/**
 初始化方法

 @param duration 转场时间
 @return 返回
 */
- (id)initWithDuration:(NSTimeInterval)duration;

@end
