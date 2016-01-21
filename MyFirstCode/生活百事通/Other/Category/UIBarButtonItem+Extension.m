//
//  UIBarButtonItem+Extension.m
//
//  Created by apple on 15/3/24.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


- (UIBarButtonItem *)initWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title target:(id)target action:(SEL)action
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // 2.设置按钮的默认图片和高亮图片
    if (norimage != nil && ![norimage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:norimage] forState:UIControlStateNormal];
    }
    if (higImage != nil && ![higImage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    }
    // 设置标题
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // 3.监听按钮的点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 4.设置按钮的frame
    // 可以调用控件的sizeToFit方法来自动调整控件的大小
    [btn sizeToFit];
    
    // 5.根据按钮创建BarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)itemWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title target:(id)target action:(SEL)action
{
    return [[self alloc] initWithNorImage:norimage higImage:higImage title:title target:target action:action];
}

+(UIBarButtonItem *)itemWithImage:(NSString *)norimage higImage:(NSString *)higImage imageScale:(CGFloat)imageScale target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:norimage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    CGSize btnSize = CGSizeMake(btn.currentBackgroundImage.size.width * imageScale, btn.currentBackgroundImage.size.height * imageScale);
    
    btn.frame = (CGRect){CGPointZero,btnSize};
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];

}

+ (UIBarButtonItem *)itemWithImage:(NSString *)image target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(UIBarButtonItem *)itemWithTitle:(NSString *)tilte
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:tilte forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.userInteractionEnabled = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button sizeToFit];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
