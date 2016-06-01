//
//  VRCell.h
//  VRTableViewDemo
//
//  Created by Visitor on 16/6/1.
//  Copyright © 2016年 Visitor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface VRCell : UITableViewCell {
    CALayer *mImageLayer;
}

@property (nonatomic, retain) UIImageView *cellLine;    //选中cell时的下划线
@property (nonatomic, retain) UILabel *mCellTitleLabel;   //cell上从title，为了设置字体title颜色创建

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCellTitle:(NSString*)title;
-(void)setIcon:(UIImage*)image;

@end
