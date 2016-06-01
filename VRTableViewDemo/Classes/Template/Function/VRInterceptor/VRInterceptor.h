//
//  Interceptor.h
//  VRTableViewDemo
//
//  Created by Visitor on 16/6/1.
//  Copyright © 2016年 Visitor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VRInterceptor : NSObject

@property (nonatomic, readwrite, assign) id receiver;
@property (nonatomic, readwrite, assign) id middleMan;


@end
