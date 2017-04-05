//
//  GLInteractiveTransition.h
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/24.
//  Copyright © 2017年 高磊. All rights reserved.
//  手势转场控制类

#import <UIKit/UIKit.h>


/**
 手势的方向枚举

 - GLPanEdgeTop:屏幕上方
 - GLPanEdgeLeft:屏幕左侧
 - GLPanEdgeBottom: 屏幕下方
 - GLPanEdgeRight: 屏幕右方
 */
typedef NS_ENUM(NSInteger,GLEdgePanGestureDirection) {
    GLPanEdgeTop    = 0,
    GLPanEdgeLeft,
    GLPanEdgeBottom,
    GLPanEdgeRight
};


///**
// 手势转场类型
//
// - GLInteractiveTransitionPush: push
// - GLInteractiveTransitionPop: pop
// - GLInteractiveTransitionPresent: present
// - GLInteractiveTransitionDismiss: dismiss
// */
//typedef NS_ENUM(NSInteger,GLInteractiveTransitionType) {
//    GLInteractiveTransitionPush = 0,
//    GLInteractiveTransitionPop,
//    GLInteractiveTransitionPresent ,
//    GLInteractiveTransitionDismiss
//};


@interface GLInteractiveTransition : UIPercentDrivenInteractiveTransition

/**
 是否满足侧滑手势交互
 */
@property (nonatomic,assign) BOOL isPanGestureInteration;


/**
 转场时的操作 不用传参数的block
 */
@property (nonatomic,copy) dispatch_block_t eventBlcok;

/**
 添加侧滑手势

 @param view 添加手势的view
 @param direction 手势的方向
 */
- (void)addEdgePageGestureWithView:(UIView *)view direction:(GLEdgePanGestureDirection)direction;

@end
