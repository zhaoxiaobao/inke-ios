//
//  GZViewController.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/6.
//  Copyright © 2016年 times. All rights reserved.
//

#import "GZViewController.h"
#import "GZTableViewCell.h"
#import "DetailViewController.h"
#import "LivesModel.h"
#import "KxMovieViewController.h"
#import "GZTableViewCellTop.h"


@interface GZViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_listData;
}

@property(nonatomic, strong) UITableView *tableView;
@property (assign, nonatomic) CGFloat bottomBarY;
@property (assign, nonatomic) CGPoint pointNow;
@property (strong, nonatomic) CCActivityIndicatorView *activityView;


@end

@implementation GZViewController

-(void)viewDidLoad{
    [self  initView];
    [self  initData];
    self.activityView = [CCActivityIndicatorView new];
    self.activityView.isTheOnlyActiveView = NO;
    [self.activityView show];
    
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    refreshControl.tintColor = navigationBarColor;
    refreshControl.activityIndicatorViewColor = navigationBarColor;
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];

}


- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl{
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
    });
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


# pragma mark Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(void)viewWillAppear:(BOOL)animated{
    
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
        [self.activityView dismiss];

        
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
    
    return 30;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //    GZTableViewCellTop *headerView = [[GZTableViewCellTop alloc] init];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GZTableViewCellTop" owner:self options:nil];
    UIView *headerView = [nib objectAtIndex:0];
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _listData.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 59+screen_width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    GZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GZTableViewCell" owner:nil options:nil]firstObject];
    }
    
    LivesModel *model=_listData[indexPath.row];
    
    [cell setCellDataModel:model];
    
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
-(NSString *)decodeString:(NSString*)encodedString{
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



@end
