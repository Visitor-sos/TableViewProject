//
//  VRTableView.h
//  VRTableViewDemo
//
//  Created by Visitor on 16/6/1.
//  Copyright © 2016年 Visitor. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CONTENT_SIZE_MULTIPLY_FACTOR 3

typedef enum _ContentAlignment {
    eBBTableViewContentAlignmentLeft,
    eBBTableViewContentAlignmentRight
}EBBTableViewContentAlignment;

@interface VRTableView : UITableView

@property(nonatomic, assign, getter = isInfiniteScrollingEnabled)BOOL enableInfiniteScrolling;
@property(nonatomic, assign) EBBTableViewContentAlignment contentAlignment;
@property(nonatomic, assign) CGFloat horizontalRadiusCorrection;//value from 1.0 - 0.5;

@end
