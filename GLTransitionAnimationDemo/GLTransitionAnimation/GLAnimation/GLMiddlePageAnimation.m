//
//  GLMiddlePageAnimation.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/31.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "GLMiddlePageAnimation.h"

@implementation GLMiddlePageAnimation

- (void)setToAnimation:(id<UIViewControllerContextTransitioning>)contextTransition
{
    //获取目标动画的VC
    UIViewController *toVc = [contextTransition viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVc = [contextTransition viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [contextTransition containerView];
    
    //m34 这个参数有点不好理解  为透视效果 我在http://www.jianshu.com/p/e8d1985dccec这里有讲
    //当Z轴上有变化的时候 我们所看到的透视效果 可以对比看看 当你改成-0.1的时候 就懂了
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    [containerView.layer setSublayerTransform:transform];
    
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    
    //截图
    //当前页面的右侧
    CGRect from_half_right_rect = CGRectMake(fromView.frame.size.width/2.0, 0, fromView.frame.size.width/2.0, fromView.frame.size.height);
    //目标页面的左侧
    CGRect to_half_left_rect = CGRectMake(0, 0, toView.frame.size.width/2.0, toView.frame.size.height);
    //目标页面的右侧
    CGRect to_half_right_rect = CGRectMake(toView.frame.size.width/2.0, 0, toView.frame.size.width/2.0, toView.frame.size.height);
    
    //截三张图 当前页面的右侧 目标页面的左和右
    UIView *fromRightSnapView = [fromView resizableSnapshotViewFromRect:from_half_right_rect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    UIView *toLeftSnapView = [toView resizableSnapshotViewFromRect:to_half_left_rect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    UIView *toRightSnapView = [toView resizableSnapshotViewFromRect:to_half_right_rect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    
    
    fromRightSnapView.frame = from_half_right_rect;
    toLeftSnapView.frame = to_half_left_rect;
    toRightSnapView.frame = to_half_right_rect;
    
    //重新设置anchorPoint  分别绕自己的最左和最右旋转
    fromRightSnapView.layer.position = CGPointMake(CGRectGetMinX(fromRightSnapView.frame), CGRectGetMinY(fromRightSnapView.frame) + CGRectGetHeight(fromRightSnapView.frame) * 0.5);
    fromRightSnapView.layer.anchorPoint = CGPointMake(0, 0.5);
    
    toLeftSnapView.layer.position = CGPointMake(CGRectGetMinX(toLeftSnapView.frame) + CGRectGetWidth(toLeftSnapView.frame), CGRectGetMinY(toLeftSnapView.frame) + CGRectGetHeight(toLeftSnapView.frame) * 0.5);
    toLeftSnapView.layer.anchorPoint = CGPointMake(1, 0.5);
    
    //添加阴影效果

    UIView *fromRightShadowView = [self addShadowView:fromRightSnapView startPoint:CGPointMake(0, 1) endPoint:CGPointMake(1, 1)];
    UIView *toLeftShaDowView = [self addShadowView:toLeftSnapView startPoint:CGPointMake(1, 1) endPoint:CGPointMake(0, 1)];
    
    //添加视图  注意顺序
    [containerView insertSubview:toView atIndex:0];
    [containerView addSubview:toLeftSnapView];
    [containerView addSubview:toRightSnapView];
    [containerView addSubview:fromRightSnapView];

    toLeftSnapView.hidden = YES;
    
    
    //先旋转到最中间的位置
    toLeftSnapView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    //StartTime 和 relativeDuration 均为百分百
    [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            
            fromRightSnapView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
            fromRightShadowView.alpha = 1.0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            toLeftSnapView.hidden = NO;
            toLeftSnapView.layer.transform = CATransform3DIdentity;
            toLeftShaDowView.alpha = 0.0;
        }];
    } completion:^(BOOL finished) {
        [toLeftSnapView removeFromSuperview];
        [toRightSnapView removeFromSuperview];
        [fromRightSnapView removeFromSuperview];
        [fromView removeFromSuperview];
        
        if ([contextTransition transitionWasCancelled]) {
            [containerView addSubview:fromView];
        }
        
        [contextTransition completeTransition:![contextTransition transitionWasCancelled]];
    }];
    
    
    
//本来打算用基础动画来实现 但是由于需要保存几个变量 在动画完成的代理函数中用，所以就取消这个想法了
//    CABasicAnimation *fromRightAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    fromRightAnimation.duration = self.duration/2.0;
//    fromRightAnimation.beginTime = CACurrentMediaTime();
//    fromRightAnimation.toValue = @(-M_PI_2);
//    [fromRightSnapView.layer addAnimation:fromRightAnimation forKey:nil];
//    
//    
//    CABasicAnimation *toLeftAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    toLeftAnimation.beginTime = CACurrentMediaTime() + self.duration/2.0;
//    toLeftAnimation.fromValue = @(M_PI_2);
//    [toLeftAnimation setValue:contextTransition forKey:@"contextTransition"];
//    [toLeftSnapView.layer addAnimation:toLeftAnimation forKey:@"toLeftAnimation"];
}

- (void)setBackAnimation:(id<UIViewControllerContextTransitioning>)contextTransition
{
    //获取目标动画的VC
    UIViewController *toVc = [contextTransition viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVc = [contextTransition viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [contextTransition containerView];
    
    //m34 这个参数有点不好理解  为透视效果 我在http://www.jianshu.com/p/e8d1985dccec这里有讲
    //当Z轴上有变化的时候 我们所看到的透视效果 可以对比看看 当你改成-0.1的时候 就懂了
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    [containerView.layer setSublayerTransform:transform];
    
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    
    //截图
    //当前页面的右侧
    CGRect from_half_left_rect = CGRectMake(0, 0, fromView.frame.size.width/2.0, fromView.frame.size.height);
    //目标页面的左侧
    CGRect to_half_left_rect = CGRectMake(0, 0, toView.frame.size.width/2.0, toView.frame.size.height);
    //目标页面的右侧
    CGRect to_half_right_rect = CGRectMake(toView.frame.size.width/2.0, 0, toView.frame.size.width/2.0, toView.frame.size.height);
    
    //截三张图 当前页面的右侧 目标页面的左和右
    UIView *fromLeftSnapView = [fromView resizableSnapshotViewFromRect:from_half_left_rect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    UIView *toLeftSnapView = [toView resizableSnapshotViewFromRect:to_half_left_rect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    UIView *toRightSnapView = [toView resizableSnapshotViewFromRect:to_half_right_rect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    
    
    fromLeftSnapView.frame = from_half_left_rect;
    toLeftSnapView.frame = to_half_left_rect;
    toRightSnapView.frame = to_half_right_rect;
    
    //重新设置anchorPoint  分别绕自己的最左和最右旋转
    fromLeftSnapView.layer.position = CGPointMake(CGRectGetMinX(fromLeftSnapView.frame) + CGRectGetWidth(fromLeftSnapView.frame), CGRectGetMinY(fromLeftSnapView.frame) + CGRectGetHeight(fromLeftSnapView.frame) * 0.5);
    fromLeftSnapView.layer.anchorPoint = CGPointMake(1, 0.5);
    
    toRightSnapView.layer.position = CGPointMake(CGRectGetMinX(toRightSnapView.frame), CGRectGetMinY(toRightSnapView.frame) + CGRectGetHeight(toRightSnapView.frame) * 0.5);
    toRightSnapView.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //添加阴影效果
    
    UIView *fromLeftShadowView = [self addShadowView:fromLeftSnapView startPoint:CGPointMake(1, 1) endPoint:CGPointMake(0, 1)];
    UIView *toRightShaDowView = [self addShadowView:toRightSnapView startPoint:CGPointMake(0, 1) endPoint:CGPointMake(1, 1)];
    
    //添加视图  注意顺序
    [containerView insertSubview:toView atIndex:0];
    [containerView addSubview:toLeftSnapView];
    [containerView addSubview:toRightSnapView];
    [containerView addSubview:fromLeftSnapView];
    
    toRightSnapView.hidden = YES;
    
    
    //先旋转到最中间的位置
    toRightSnapView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    //StartTime 和 relativeDuration 均为百分百
    [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            
            fromLeftSnapView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
            fromLeftShadowView.alpha = 1.0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            toRightSnapView.hidden = NO;
            toRightSnapView.layer.transform = CATransform3DIdentity;
            toRightShaDowView.alpha = 0.0;
        }];
    } completion:^(BOOL finished) {
        [toLeftSnapView removeFromSuperview];
        [toRightSnapView removeFromSuperview];
        [fromLeftSnapView removeFromSuperview];
        [fromView removeFromSuperview];
        
        if ([contextTransition transitionWasCancelled]) {
            [containerView addSubview:fromView];
        }
        
        [contextTransition completeTransition:![contextTransition transitionWasCancelled]];
    }];
}

- (UIView *)addShadowView:(UIView *)view startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    UIView *shadowView = [[UIView alloc] initWithFrame:view.bounds];
    [view addSubview:shadowView];
    //颜色可以渐变
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = shadowView.bounds;
    [shadowView.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0].CGColor];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    
    return shadowView;
}


@end
