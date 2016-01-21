//
//  ZTSingleton.h
//  单例模式，完善
//
//  Created by 张涛 on 15/4/4.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#ifndef ________ZTSingleton_h
#define ________ZTSingleton_h

//.h文件
#define ZTSingletonH(name)  +(instancetype)shared##name;

//.m文件
#if __has_feature(objc_arc)

#define ZTSingletonM(name)\
static id _instance;\
\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)shared##name\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc]init];\
});\
return _instance;\
}\
\
+(id)copyWithZone:(struct _NSZone *)zone\
{\
return _instance;\
}

#else

#define ZTSingletonM(name)  static id _instance;\
\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)shared##name\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc]init];\
});\
return _instance;\
}\
\
+(id)copyWithZone:(struct _NSZone *)zone\
{\
return _instance;\
}\
-(oneway void)release{}\
-(instancetype)autorelease{return self;}\
-(instancetype)retain{return self;}\
-(NSUInteger)retainCount{return 1;}

#endif


#endif
