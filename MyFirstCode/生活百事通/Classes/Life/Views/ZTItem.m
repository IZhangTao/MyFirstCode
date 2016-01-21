//
//  ZTItem.m
//  生活百事通
//
//  Created by 张涛 on 15/4/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTItem.h"

@implementation ZTItem
/**
 *  <#Description#>
 *
 *  @param image <#image description#>
 *  @param title <#title description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithImage:(NSString *)image title:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
        self.imageName = image;
    }
    return self;
}

+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title
{
    return [[self alloc] initWithImage:image title:title];
}
/**
 *  <#Description#>
 *
 *  @param title       <#title description#>
 *  @param icon        <#icon description#>
 *  @param destVcClass <#destVcClass description#>
 *
 *  @return <#return value description#>
 */

+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title destVcClass:(Class)destVcClass
{
    return [[self alloc]initWithImage:image title:title destVcClass:destVcClass];
}

- (instancetype)initWithImage:(NSString *)image title:(NSString *)title destVcClass:(Class)destVcClass
{
    self = [self initWithImage:image title:title];
    if (!self)
        return nil;
    self.destVcClass = destVcClass;
    return self;
}



+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title selectionHandler:(void (^)(id))selectionHandler
{
    return [[self alloc]initWithImage:image title:title selectionHandler:selectionHandler];
}

- (instancetype)initWithImage:(NSString *)image title:(NSString *)title selectionHandler:(void (^)(id item))selectionHandler
{
    self = [self initWithImage:image title:title];
    if (!self)
        return nil;
    self.selectionHandler = selectionHandler;
    return self;
}

@end
