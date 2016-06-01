//
//  VRCell.m
//  VRTableViewDemo
//
//  Created by Visitor on 16/6/1.
//  Copyright © 2016年 Visitor. All rights reserved.
//

#import "VRCell.h"

@implementation VRCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //add the image layer
        self.contentView.backgroundColor = [UIColor clearColor];
        mImageLayer =[CALayer layer];
        mImageLayer.cornerRadius = 16.0;
        mImageLayer.contents = (id)[UIImage imageNamed:@"circle.png"].CGImage;
        [self.contentView.layer addSublayer:mImageLayer];
        
        //the title label
        self.mCellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 10.0, self.contentView.bounds.size.width - 44.0, 21.0)];
        [self.contentView addSubview:self.mCellTitleLabel];
        self.mCellTitleLabel.backgroundColor= [UIColor clearColor];
        self.mCellTitleLabel.textColor = [UIColor whiteColor];
        self.mCellTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        
        self.cellLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableviewcell_line"]];
        self.cellLine.frame = CGRectMake(30.0f, self.frame.size.height - 6.0f, self.frame.size.width/3, 1.5f);
        [self.contentView addSubview:self.cellLine];
        self.cellLine.hidden = YES;
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    float imageY = 4.0;
    float heightOfImageLayer  = self.bounds.size.height - imageY*2.0;
    heightOfImageLayer = floorf(heightOfImageLayer);
    mImageLayer.cornerRadius = heightOfImageLayer/2.0f;
    mImageLayer.frame = CGRectMake(4.0, imageY+10, 30, 30);
    self.mCellTitleLabel.frame = CGRectMake(heightOfImageLayer, floorf(heightOfImageLayer/2.0 - (21/2.0f))+4.0, self.contentView.bounds.size.width-heightOfImageLayer+10.0, 21.0);
}

-(void)setCellTitle:(NSString*)title {
    self.mCellTitleLabel.text = title;
}

-(void)setIcon:(UIImage*)image {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0];
    mImageLayer.contents = (id)image.CGImage;
    [CATransaction commit];
}

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.mCellTitleLabel.textColor = selected ? [UIColor colorWithRed:0.54f green:0.81f blue:0.98f alpha:1.00f] : [UIColor whiteColor];
    if(selected) {
        if([self.mCellTitleLabel.text isEqualToString:@"云端骚扰电话拦截"]) {
            self.cellLine.frame = CGRectMake(self.cellLine.frame.origin.x + 20.0f, self.cellLine.frame.origin.y, self.cellLine.frame.size.width, self.cellLine.frame.size.height);
        }
    }
    self.cellLine.hidden = selected ? NO : YES;
    
    if(selected)
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(hideCellLineWhenTimeOut) userInfo:nil repeats:NO];
}

- (void)hideCellLineWhenTimeOut {
    if([self.mCellTitleLabel.text isEqualToString:@"云端骚扰电话拦截"]) {
        self.cellLine.frame = CGRectMake(self.cellLine.frame.origin.x - 20.0f, self.cellLine.frame.origin.y, self.cellLine.frame.size.width, self.cellLine.frame.size.height);
    }
    self.cellLine.hidden = YES;
    self.mCellTitleLabel.textColor = [UIColor whiteColor];
}

@end
