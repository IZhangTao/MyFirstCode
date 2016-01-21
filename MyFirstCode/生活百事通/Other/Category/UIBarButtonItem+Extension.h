//
//  UIBarButtonItem+Extension.h
//
//  Created by apple on 15/3/24.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  自定义UIBarButtonItem
 */
- (UIBarButtonItem *)initWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title target:(id)target action:(SEL)action;
/**
 *  自定义UIBarButtonItem
 */
+ (instancetype)itemWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title target:(id)target action:(SEL)action;
/**
 *  自定义UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)norimage higImage:(NSString *)higImage imageScale:(CGFloat)imageScale target:(id)target action:(SEL)action;
/**
 *  自定义UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)image target:(id)target action:(SEL)action;
/**
 *  自定义UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte;
@end
