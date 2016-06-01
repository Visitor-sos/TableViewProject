//
//  ViewController.m
//  VRTableViewDemo
//
//  Created by Visitor on 16/6/1.
//  Copyright © 2016年 Visitor. All rights reserved.
//

#import "ViewController.h"
#import "VRTableView.h"
#import "VRCell.h"
#import "VRSlideView.h"

#define PANVIEW_WIDTH [self screenBounds]
#define PANVIEW_HEIGHT PANVIEW_WIDTH
#define KEY_TITLE @"title"
#define KEY_IMAGE @"image"

@interface ViewController ()  <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) VRTableView *mTableView;
@property (nonatomic, retain) NSMutableArray *mDataSource;
@property (nonatomic, assign) BOOL isScroll;    // is scrolling?

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    [self initialData];
    
    self.mTableView = [[VRTableView alloc] initWithFrame:CGRectMake(40.0f, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width - 40.0f, 420) style:UITableViewStylePlain];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.enableInfiniteScrolling = YES;
    self.mTableView.contentAlignment = eBBTableViewContentAlignmentRight;
    self.mTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mTableView];
    
    VRSlideView *slideView = [[VRSlideView alloc] init];
    if([UIScreen mainScreen].bounds.size.height == 480.0f)
    {
        slideView.frame =  CGRectMake(-PANVIEW_WIDTH/2, [UIScreen mainScreen].bounds.size.height - PANVIEW_HEIGHT/2, PANVIEW_WIDTH, PANVIEW_HEIGHT);
    }
    else
    {
        slideView.frame = CGRectMake(-PANVIEW_WIDTH/2, [UIScreen mainScreen].bounds.size.height - PANVIEW_HEIGHT/2, PANVIEW_WIDTH, PANVIEW_HEIGHT);
    }
    slideView.backgroundColor = [UIColor clearColor];
    slideView.layer.cornerRadius = 30.0f;
    [self.view addSubview:slideView];
    
    UIImageView *topTriangle = [[UIImageView alloc] init];
    topTriangle.frame = CGRectMake(10.0f, slideView.frame.origin.y - 25.0f, 15.0, 15.0);
    topTriangle.image = [UIImage imageNamed:@"indexleft.png"];
    [self.view addSubview:topTriangle];
    
    UIImageView *rightTriangle = [[UIImageView alloc] init];
    rightTriangle.frame = CGRectMake(slideView.frame.size.width/2 + 5.0f, [UIScreen mainScreen].bounds.size.height - 30.0f, 15.0, 15.0);
    rightTriangle.image = [UIImage imageNamed:@"indexdown.png"];
    [self.view addSubview:rightTriangle];
    [self.view bringSubviewToFront:slideView];
}

static float tableViewScrollDirection = 0;
static UITableViewCell *frontCell = nil;
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //当table正在滚动、同时单击关于按钮，界面碎片跳转动画无
    if(tableViewScrollDirection == 0) {
        tableViewScrollDirection = self.mTableView.contentOffset.y;
    }
    
    //往下滑动
    NSNumber *number = nil;
    if(tableViewScrollDirection - self.mTableView.contentOffset.y > 0) {
        number = [NSNumber numberWithBool:NO];
        self.isScroll = YES;
    }
    else {
        number = [NSNumber numberWithBool:YES];
        self.isScroll = YES;
    }
    tableViewScrollDirection = self.mTableView.contentOffset.y;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidScroll" object:number];
    
    //设置渐变色
    NSArray *rowsArray = [self.mTableView visibleCells];
    if(!frontCell) {
        frontCell = (UITableViewCell *)rowsArray[0];
    }
    
    //获取数组首元素，设置透明度
    UITableViewCell *firstCell = (UITableViewCell *)rowsArray[0];
    if (![number boolValue]) {
        if(firstCell.contentView.alpha >= 1.0f)
            firstCell.contentView.alpha = 0.0f;
        
        //向下滑动则设置透明度减少
        if(firstCell.contentView.alpha <= 1.0f && firstCell.contentView.alpha >= 0) {
            if(firstCell.frame.origin.x > 40.0f) {
                firstCell.contentView.alpha += 0.8/60.0f;
                if(firstCell.contentView.alpha > 1.0f)
                    firstCell.contentView.alpha = 1.0f;
            }
        }
    }
    else {
        //向上滑动则设置透明度增加
        if(firstCell.contentView.alpha <= 1.0f && firstCell.contentView.alpha >= 0) {
            //NSLog(@"设置透明度为透明");
            firstCell.contentView.alpha -= 4/60.0f;
            if(firstCell.contentView.alpha < 0)
                firstCell.contentView.alpha = 0.0f;
        }
    }
    
    if(rowsArray[0] != frontCell) {
        //当存储cells的数组首元素被替换时，需要设置数组第二个元素的alpha为不透明
        for (int i = 1;i < rowsArray.count-1; i ++) {
            UITableViewCell *subCell = (UITableViewCell *)rowsArray[i];
            subCell.contentView.alpha = 1.0f;
        }
        
        //除第一个元素之外的其它元素都需要重设
        //重新赋值首元素
        frontCell = (UITableViewCell *)rowsArray[0];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.isScroll = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *test = @"table";
    VRCell *cell = (VRCell*)[tableView dequeueReusableCellWithIdentifier:test];
    if( !cell )
    {
        cell = [[VRCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:test];
    }
    NSDictionary *info = [self.mDataSource objectAtIndex:indexPath.row ];
    [cell setCellTitle:[info objectForKey:KEY_TITLE]];
    [cell setIcon:[UIImage imageNamed:[info objectForKey:KEY_IMAGE]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click..");
}

#pragma mark - initial data
- (void)initialData {
    NSDictionary *yunDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"云端骚扰电话拦截",KEY_TITLE,@"indexcloud.png",KEY_IMAGE, nil];
    NSDictionary *anDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"安全二维码",KEY_TITLE,@"indexcloud.png",KEY_IMAGE, nil];
    NSDictionary *liuDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"流量监控",KEY_TITLE,@"indexcloud.png",KEY_IMAGE, nil];
    NSDictionary *wangDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"网络测速",KEY_TITLE,@"indexcloud.png",KEY_IMAGE, nil];
    NSDictionary *yinDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"隐私保护",KEY_TITLE,@"indexcloud.png",KEY_IMAGE, nil];
    NSDictionary *shouDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"手机U盘",KEY_TITLE,@"indexcloud.png",KEY_IMAGE, nil];
    self.mDataSource = [[NSMutableArray alloc] initWithObjects:yunDic,anDic,liuDic,wangDic,yinDic,shouDic,yunDic,anDic,liuDic,wangDic,yinDic,shouDic, nil];
}

- (float) screenBounds {
    if([UIScreen mainScreen].bounds.size.height == 480.0f)
        return 300.0f;
    else
        return 340.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
