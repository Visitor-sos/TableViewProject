//
//  Interceptor.m
//  VRTableViewDemo
//
//  Created by Visitor on 16/6/1.
//  Copyright © 2016年 Visitor. All rights reserved.
//

#import "VRInterceptor.h"

@implementation VRInterceptor

@synthesize receiver = _receiver;
@synthesize middleMan = _middleMan;

- (id) forwardingTargetForSelector:(SEL)aSelector {
    if ([_middleMan respondsToSelector:aSelector])
        return _middleMan;
    
    if ([_receiver respondsToSelector:aSelector])
        return _receiver;
    
    return	[super forwardingTargetForSelector:aSelector];
}

- (BOOL) respondsToSelector:(SEL)aSelector {
    if ([_middleMan respondsToSelector:aSelector])
        return YES;
    
    if ([_receiver respondsToSelector:aSelector])
        return YES;
    
    return [super respondsToSelector:aSelector];
}

@end
