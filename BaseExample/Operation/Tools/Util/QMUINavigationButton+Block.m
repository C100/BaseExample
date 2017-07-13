//
//  QMUINavigationButton+Block.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/13.
//  Copyright © 2017年 james. All rights reserved.
//

#import "QMUINavigationButton+Block.h"

static const void *BarButtonItemBlockKey = &BarButtonItemBlockKey;

@interface QMUICommonViewController(BlocksKitPrivate)

- (void)handleAction:(UIBarButtonItem *)sender;

@end

@implementation QMUICommonViewController(BlocksKitPrivate)

- (void)handleAction:(UIBarButtonItem *)sender
{
    void (^block)(id) = objc_getAssociatedObject(self, BarButtonItemBlockKey);
    if (block) block(sender);
}

@end

@implementation QMUINavigationButton (Block)
+ (UIBarButtonItem *)backBarButtonItemWithTintColor:(UIColor *)tintColor target:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self backBarButtonItemWithTarget:target action:@selector(handleAction:) tintColor:tintColor];
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}

+ (UIBarButtonItem *)backBarButtonItemWithTarget:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self backBarButtonItemWithTarget:target action:@selector(handleAction:)];
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}

+ (UIBarButtonItem *)closeBarButtonItemWithTintColor:(UIColor *)tintColor target:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self closeBarButtonItemWithTarget:target action:@selector(handleAction:) tintColor:tintColor];
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}

+ (UIBarButtonItem *)closeBarButtonItemWithTarget:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self closeBarButtonItemWithTarget:target action:@selector(handleAction:)];
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithType:(QMUINavigationButtonType)type title:(NSString *)title tintColor:(UIColor *)tintColor position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithType:type title:title tintColor:tintColor position:position target:target action:@selector(handleAction:)];
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithType:(QMUINavigationButtonType)type title:(NSString *)title position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithType:type title:title position:position target:target action:@selector(handleAction:)];
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithNavigationButton:(QMUINavigationButton *)button tintColor:(UIColor *)tintColor position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithNavigationButton:button tintColor:tintColor position:position target:target action:@selector(handleAction:)];
    
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithNavigationButton:(QMUINavigationButton *)button position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithNavigationButton:button position:position target:target action:@selector(handleAction:)];
    
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image tintColor:(UIColor *)tintColor position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithImage:image tintColor:tintColor position:position target:target action:@selector(handleAction:)];
    
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithImage:image position:position target:target action:@selector(handleAction:)];
    
    if (!barButtonItem) return nil;
    
    objc_setAssociatedObject(target, BarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return barButtonItem;
}
@end
