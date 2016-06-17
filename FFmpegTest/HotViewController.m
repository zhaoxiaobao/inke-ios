//
//  HotViewController.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/6.
//  Copyright © 2016年 times. All rights reserved.
//

#import "HotViewController.h"
#import "ListTableViewCell.h"
#import "DetailViewController.h"
#import "NetworkSingleton.h"
#import "MJExtension.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import "LivesModel.h"
#import "KxMovieViewController.h"

#import "ListTableViewCell.h"

#import "UIImageView+WebCache.h"

@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_listData;
    
}

@property(nonatomic, strong) UITableView *tableView;


@property (assign, nonatomic) CGFloat bottomBarY;

@property (assign, nonatomic) CGPoint pointNow;

@end



@implementation HotViewController

-(void)viewDidLoad{
    [self  initView];
    [self  initData];
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView sendSubviewToBack:refreshControl];
    
       
}

- (void)handleRefresh:(UIRefreshControl *)refreshControl {
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    [refreshControl endRefreshing];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    _bottomBarY = self.tabBarController.tabBar.y;
    
    [UIView animateWithDuration:0.3 animations:^{
                    self.tabBarController.tabBar.y = screen_height-49;
        //            [self.tabBarController.tabBar layoutIfNeeded];
        self.tabBarController.tabBar.hidden = NO;
        self.navigationController.navigationBar.barTintColor=navigationBarColor;
        
    }];
}


# pragma mark Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    NSLog(@"%f-%f=%f",scrollView.contentOffset.y ,_pointNow.y,scrollView.contentOffset.y -_pointNow.y);
    if (scrollView.contentOffset.y < _pointNow.y) {
        [UIView animateWithDuration:0.3 animations:^{
//            self.tabBarController.tabBar.y = screen_height-49;
//            [self.tabBarController.tabBar layoutIfNeeded];
            self.tabBarController.tabBar.hidden = NO;
            self.navigationController.navigationBarHidden=YES;

        }];
    } else if (scrollView.contentOffset.y > _pointNow.y) {
        [UIView animateWithDuration:0.3 animations:^{
//            [self.tabBarController.tabBar layoutIfNeeded];
            self.tabBarController.tabBar.hidden = YES;
            self.navigationController.navigationBarHidden=NO;

        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _pointNow = scrollView.contentOffset;
}


-(void)viewWillAppear:(BOOL)animated{
    
//    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

-(void)initData{
    _listData = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        [self getListData];
        dispatch_async(dispatch_get_main_queue(), ^{
            //update UI
        });
    });
    
    
    
}


-(void)getListData{
    
    //含有中文请求会出错
    NSString *url = [@"http://101.200.29.199/api/live/simpleall?cc=TG0001&conn=Wifi&cv=IK2.5.10_Iphone&devi=44d94653f9a0934cc94f12e542d7d363fae4256b&idfa=07506DA9-419B-460D-BAC8-E035DD6099BC&idfv=3D5EC291-4DDF-44FE-8AC7-B9598B532319&imei=&imsi=&lc=0000000000000014&multiaddr=1&osversion=ios_9.200000&proto=1&sid=EE3qPwpb4VuMR65ShMqfaS8i3&ua=iPhone%205s&uid=509195" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[NetworkSingleton sharedManager] getJsonData:nil url:url successBlock:^(id responseBody){
        NSLog(@"%@",responseBody);
        
        NSMutableArray *dataDic = [responseBody objectForKey:@"lives"];
        
        for (int i=0; i<dataDic.count; i++) {
            LivesModel *model=[LivesModel mj_objectWithKeyValues:dataDic[i]];
            [_listData addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failureBlock:^(NSString *error){
        NSLog(@"%@",error);
    }];
    
    
}


-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _listData.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return screen_width+115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    LivesModel *model=_listData[indexPath.row];
    
    NSString *urlStr;
    if ([model.creator.portrait rangeOfString:@"http"].location !=NSNotFound) {
        //$$字符串判断
        urlStr= model.creator.portrait;
        
    }else{
        
        urlStr= [NSString stringWithFormat:@"http://img.meelive.cn/%@",model.creator.portrait];
        
    }
    
    
    [cell.prodImgeView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_room.jpg"] options:SDWebImageCacheMemoryOnly];
    [cell.bgImgeView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_room.jpg"] options:SDWebImageCacheMemoryOnly];
    
    cell.titleLabel.text = model.creator.nick;
    cell.priceLabel.text = model.city;
    cell.nameLabel.text = model.name;
    cell.onlineLabel.text = model.online_users;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

+(NSString*)encodeString:(NSString*)unencodedString{
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

//URLDEcode
-(NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LivesModel *model=_listData[indexPath.row];
    
    if (model.stream_addr==nil) {
        return;
    }
    NSString *path=model.stream_addr;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // increase buffering for .wmv, it solves problem with delaying audio frames
    if ([path.pathExtension isEqualToString:@"wmv"])
        parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    
    // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    
    
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                               parameters:parameters];
    vc.LivesModel=model;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}








@end
