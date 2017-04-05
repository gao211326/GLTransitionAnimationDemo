//
//  GLCircleRectSpreadAnimation.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/27.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "GLCircleRectSpreadAnimation.h"

@interface GLCircleRectSpreadAnimation ()

@property (nonatomic,strong) UIView *startView;

@property (nonatomic,assign) CGPoint centerPoint;

@end

@implementation GLCircleRectSpreadAnimation

- (id)initWithStartPoint:(CGPoint )point
{
    self = [super init];
    if (self) {
        self.centerPoint = point;
    }
    return self;
}


#pragma mark == private method
- (CGRect)frameToCircle:(CGPoint)centerPoint size:(CGSize)size
{
    CGFloat radius_x = fmax(centerPoint.x, size.width - centerPoint.x);
    CGFloat radius_y = fmax(centerPoint.y, size.height - centerPoint.y);
    CGFloat endRadius = 2 * sqrtf(pow(radius_x, 2) + pow(radius_y, 2));

    CGRect rect = {CGPointZero,CGSizeMake(endRadius, endRadius)};
    
    return rect;
}


- (void)setToAnimation:(id<UIViewControllerContextTransitioning>)contextTransition
{
    //获取目标动画的VC
    UIViewController *toVc = [contextTransition viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [contextTransition containerView];
    
//    [toVc beginAppearanceTransition:YES animated:YES];
    CGPoint center = toVc.view.center;
    
    CGRect rect = [self frameToCircle:self.centerPoint size:toVc.view.bounds.size];
    UIView *backView = [[UIView alloc] initWithFrame:rect];
    backView.backgroundColor = UICOLOR_FROM_RGB_OxFF(0xFFA500);
    backView.center = self.centerPoint;
    backView.layer.cornerRadius = backView.frame.size.height / 2.0;
    backView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [containerView addSubview:backView];
    
    self.startView = backView;
    
    toVc.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    toVc.view.alpha = 0;
    toVc.view.center = self.centerPoint;
    [containerView addSubview:toVc.view];
    
    
    [UIView animateWithDuration:self.duration animations:^{
        
        backView.transform = CGAffineTransformIdentity;
        
        toVc.view.center = center;
        toVc.view.transform = CGAffineTransformIdentity;
        toVc.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        [contextTransition completeTransition:!contextTransition.transitionWasCancelled];
        
//        [toVc endAppearanceTransition];
    }];
}

- (void)setBackAnimation:(id<UIViewControllerContextTransitioning>)contextTransition
{
    //获取目标动画的VC
    UIViewController *fromVc = [contextTransition viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [contextTransition viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [contextTransition containerView];
    [containerView insertSubview:toVc.view atIndex:0];

    [UIView animateWithDuration:self.duration animations:^{
        //缩小
        self.startView.transform = CGAffineTransformMakeScale(0.01, 0.01);

        fromVc.view.center = self.centerPoint;
        fromVc.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
        fromVc.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        [contextTransition completeTransition:!contextTransition.transitionWasCancelled];
        [self.startView removeFromSuperview];
    }];
}

@end
