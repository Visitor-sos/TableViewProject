//
//  VRSlideView.m
//  VRTableViewDemo
//
//  Created by Visitor on 16/6/1.
//  Copyright © 2016年 Visitor. All rights reserved.
//

#define RADIUS (self.frame.size.width/2.8)
#define RADIUS1 (self.frame.size.width/2.5)
#define TRIANGLE_WIDTH 25.0f
#define TRIANGLE_HEIGHT TRIANGLE_WIDTH

#import "VRSlideView.h"

@implementation VRSlideView

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformRotation:) name:@"scrollViewDidScroll" object:nil];
        self.image = [UIImage imageNamed:@"indexcircle.png"];
    }
    return self;
}

- (void)transformRotation:(NSNotification *)not {
    NSNumber *number = not.object;
    if([number boolValue]) {
        self.transform = CGAffineTransformRotate(self.transform,6);
    }
    else {
        self.transform = CGAffineTransformRotate(self.transform,-6);
    }
}

@end
