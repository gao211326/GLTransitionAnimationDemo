//
//  UIViewController+GLTransition.h
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/24.
//  Copyright © 2017年 高磊. All rights reserved.
//  UIViewController的转场category

#import <UIKit/UIKit.h>
#import "GLInteractiveTransition.h"

extern NSString *const kAnimationKey;
extern NSString *const kToAnimationKey;

@class GLTransitionManager;

@interface UIViewController (GLTransition)

/**
 push动画

 @param viewController 被push viewController
 @param transitionManager 控制类
 */
- (void)gl_pushViewControler:(UIViewController *)viewController withAnimation:(GLTransitionManager*)transitionManager;


/**
 present动画

 @param viewController 被present viewController
 @param transitionManager 控制类
 */
- (void)gl_presentViewControler:(UIViewController *)viewController withAnimation:(GLTransitionManager*)transitionManager;


/**
 注册入场手势

 @param direction 方向
 @param blcok 手势转场触发的点击事件
 */
- (void)gl_registerToInteractiveTransitionWithDirection:(GLEdgePanGestureDirection)direction eventBlcok:(dispatch_block_t)blcok;

/**
 注册返回手势

 @param direction 侧滑方向
 @param blcok 手势转场触发的点击事件
 */
- (void)gl_registerBackInteractiveTransitionWithDirection:(GLEdgePanGestureDirection)direction eventBlcok:(dispatch_block_t)blcok;


@end
