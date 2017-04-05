//
//  UIViewController+GLTransition.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/24.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "UIViewController+GLTransition.h"
#import "GLTransitionManager.h"
#import <objc/runtime.h>

NSString *const kAnimationKey = @"kAnimationKey";
NSString *const kToAnimationKey = @"kToAnimationKey";


@implementation UIViewController (GLTransition)




#pragma mark == public method


- (void)gl_pushViewControler:(UIViewController *)viewController withAnimation:(GLTransitionManager *)transitionManager
{
    if (!viewController) {
        return;
    }
    if (!transitionManager) {
        return;
    }
    
    if (self.navigationController) {
        
        self.navigationController.delegate = transitionManager;
        
        GLInteractiveTransition *toInteractiveTransition = objc_getAssociatedObject(self, &kToAnimationKey);
        if (toInteractiveTransition) {
            [transitionManager setValue:toInteractiveTransition forKey:@"toInteractiveTransition"];
        }
        
        objc_setAssociatedObject(viewController, &kAnimationKey, transitionManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.navigationController pushViewController:viewController animated:YES];
   
    }
}

- (void)gl_presentViewControler:(UIViewController *)viewController withAnimation:(GLTransitionManager *)transitionManager
{
    if (!viewController) {
        return;
    }
    if (!transitionManager) {
        return;
    }
    //present 动画代理 被执行动画的vc设置代理
    viewController.transitioningDelegate = transitionManager;
    
    GLInteractiveTransition *toInteractiveTransition = objc_getAssociatedObject(self, &kToAnimationKey);
    if (toInteractiveTransition) {
        [transitionManager setValue:toInteractiveTransition forKey:@"toInteractiveTransition"];
    }
    objc_setAssociatedObject(viewController, &kAnimationKey, transitionManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)gl_registerToInteractiveTransitionWithDirection:(GLEdgePanGestureDirection)direction eventBlcok:(dispatch_block_t)blcok
{
    GLInteractiveTransition *interactiveTransition = [[GLInteractiveTransition alloc] init];
    interactiveTransition.eventBlcok = blcok;
    [interactiveTransition addEdgePageGestureWithView:self.view direction:direction];
    
    objc_setAssociatedObject(self, &kToAnimationKey, interactiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)gl_registerBackInteractiveTransitionWithDirection:(GLEdgePanGestureDirection)direction eventBlcok:(dispatch_block_t)blcok
{
    GLInteractiveTransition *interactiveTransition = [[GLInteractiveTransition alloc] init];
    interactiveTransition.eventBlcok = blcok;
    [interactiveTransition addEdgePageGestureWithView:self.view direction:direction];
    
    //判读是否需要返回 然后添加侧滑
    GLTransitionManager *animator = objc_getAssociatedObject(self, &kAnimationKey);
    if (animator)
    {
        //用kvc的模式  给 animator的backInteractiveTransition 退场赋值
        [animator setValue:interactiveTransition forKey:@"backInteractiveTransition"];
    }
}

@end
