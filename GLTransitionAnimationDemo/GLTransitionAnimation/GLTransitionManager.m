//
//  GLTransitionManager.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/23.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "GLTransitionManager.h"
#import "GLTransitionAnimation.h"
#import "GLInteractiveTransition.h"

@interface GLTransitionManager ()


/**
 入场动画
 */
@property (nonatomic,strong) GLTransitionAnimation *toTransitionAnimation;

/**
 退场动画
 */
@property (nonatomic,strong) GLTransitionAnimation *backTransitionAnimation;

/**
 入场手势
 */
@property (nonatomic,strong) GLInteractiveTransition *toInteractiveTransition;

/**
 退场手势
 */
@property (nonatomic,strong) GLInteractiveTransition *backInteractiveTransition;


/**
 转场类型 push or pop
 */
@property (nonatomic,assign) UINavigationControllerOperation operation;

@end

@implementation GLTransitionManager

- (void)dealloc
{

}

- (id)init
{
    self = [super init];
    if (self) {
        self.duration = 0.5;
    }
    return self;
}


#pragma mark == public method
- (void)setToAnimation:(id<UIViewControllerContextTransitioning>)contextTransition
{
    //需在子类中进行重写
}

- (void)setBackAnimation:(id<UIViewControllerContextTransitioning>)contextTransition
{
    //需在子类中进行重写
}


#pragma mark == UIViewControllerTransitioningDelegate
//非手势转场交互 for present
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.toTransitionAnimation;
}

//非手势转场交互 for dismiss
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.backTransitionAnimation;
}

//手势交互 for dismiss
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.backInteractiveTransition.isPanGestureInteration ? self.backInteractiveTransition:nil;
}

//手势交互 for present
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
   return self.toInteractiveTransition.isPanGestureInteration ? self.toInteractiveTransition:nil;
}



#pragma mark == UINavigationControllerDelegate
//执行顺序 先
//非手势转场交互 for push or pop
/*****注释:通过 fromVC 和 toVC 我们可以在此设置需要自定义动画的类 *****/
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    _operation = operation;
    
    if (operation == UINavigationControllerOperationPush)
    {
        return self.toTransitionAnimation;
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        return self.backTransitionAnimation;
    }
    else
    {
        return nil;
    }
}

//手势交互 for push or pop
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (_operation == UINavigationControllerOperationPush) {
        return self.toInteractiveTransition.isPanGestureInteration ? self.toInteractiveTransition:nil;
    }
    else{
        return self.backInteractiveTransition.isPanGestureInteration ? self.backInteractiveTransition:nil;
    }
}


#pragma mark == setter
- (void)setBackInteractiveTransition:(GLInteractiveTransition *)backInteractiveTransition
{
    _backInteractiveTransition = backInteractiveTransition;
}

- (void)setToInteractiveTransition:(GLInteractiveTransition *)toInteractiveTransition
{
    _toInteractiveTransition = toInteractiveTransition;
}

#pragma mark == 懒加载
- (GLTransitionAnimation *)toTransitionAnimation
{
    if (nil == _toTransitionAnimation) {
        __weak typeof(self) weakSelf = self;
        _toTransitionAnimation = [[GLTransitionAnimation alloc] initWithDuration:self.duration ];
        _toTransitionAnimation.animationBlock = ^(id<UIViewControllerContextTransitioning> contextTransition)
        {
            [weakSelf setToAnimation:contextTransition];
        };
    }
    return _toTransitionAnimation;
}

- (GLTransitionAnimation *)backTransitionAnimation
{
    if (nil == _backTransitionAnimation) {
        __weak typeof(self) weakSelf = self;
        _backTransitionAnimation = [[GLTransitionAnimation alloc] initWithDuration:self.duration];
        _backTransitionAnimation.animationBlock = ^(id<UIViewControllerContextTransitioning> contextTransition)
        {
            [weakSelf setBackAnimation:contextTransition];
        };
    }
    return _backTransitionAnimation;
}



@end
