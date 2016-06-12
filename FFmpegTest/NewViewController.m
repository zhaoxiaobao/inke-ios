//
//  NewViewController.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/6.
//  Copyright © 2016年 times. All rights reserved.
//

#import "NewViewController.h"
#import "UIImageView+WebCache.h"
#import "NetworkSingleton.h"
#import "LivesModel.h"
#import "MJExtension.h"
#import "PicCollectionViewCell.h"

static NSString *const CollectionViewCellIdentifier = @"cell";

@interface NewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    
    NSMutableArray *_listData;
    
}


@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation NewViewController


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
    
    NSString *url = [@"http://101.200.29.199/api/live/simpleall?cc=TG0001&conn=Wifi&cv=IK2.5.10_Iphone&devi=44d94653f9a0934cc94f12e542d7d363fae4256b&idfa=07506DA9-419B-460D-BAC8-E035DD6099BC&idfv=3D5EC291-4DDF-44FE-8AC7-B9598B532319&imei=&imsi=&lc=0000000000000014&multiaddr=1&osversion=ios_9.200000&proto=1&sid=EE3qPwpb4VuMR65ShMqfaS8i3&ua=iPhone%205s&uid=509195" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[NetworkSingleton sharedManager] getJsonData:nil url:url successBlock:^(id responseBody){
        NSLog(@"%@",responseBody);
        
        NSMutableArray *dataDic = [responseBody objectForKey:@"lives"];
        
        for (int i=0; i<dataDic.count; i++) {
            LivesModel *model=[LivesModel mj_objectWithKeyValues:dataDic[i]];
            [_listData addObject:model];
        }
        
        [self.collectionView reloadData];
        
    } failureBlock:^(NSString *error){
        NSLog(@"%@",error);
    }];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(screen_width, 80);//头部
    layout.itemSize = CGSizeMake((screen_width-2*3-4)/3,(screen_width-2*3-4)/3);
    layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) collectionViewLayout:layout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.collectionView registerClass:[PicCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    [self.view addSubview:self.collectionView];
}


#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _listData.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(2, 8, screen_width-4, 80)];
    UILabel *label=[[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text=@"达人推荐";
    label.textColor=fontGray;
    label.textAlignment=0;
    [label setFont:[UIFont systemFontOfSize:12]];
    CGSize size =  [self sizeWithString:label.text font:label.font];
    label.frame = CGRectMake(10, 0, size.width, 40);
    [View  addSubview:label];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 4, 20)];
    line.backgroundColor=orange;
    [View  addSubview:line];
    
    UIView *bline = [[UIView alloc] initWithFrame:CGRectMake(0, line.bottom+20, screen_width-4, 0.5)];
    bline.backgroundColor=fontGray;
    [View  addSubview:bline];
    
    UILabel *blabel=[[UILabel alloc] initWithFrame:CGRectMake(0, line.bottom+20, 80, 30)];
    blabel.numberOfLines = 0;
    blabel.backgroundColor=[UIColor whiteColor];
    blabel.text=@"最新直播";
    blabel.textColor=fontGray;
    blabel.textAlignment=1;
    [blabel setFont:[UIFont systemFontOfSize:11]];
    blabel.center = bline.center;
    [View  addSubview:blabel];
    
    [headerView addSubview:View];//头部
    return headerView;
}


- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(screen_width-20-20, 20)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = navigationBarColor;
    [cell sizeToFit];
    if (!cell) {
        return cell;
        
    }
    LivesModel *model=_listData[indexPath.row];
    
    NSString *urlStr;
    if ([model.creator.portrait rangeOfString:@"http"].location !=NSNotFound) {
        //$$字符串判断
        urlStr= model.creator.portrait;
    }else{
        
        urlStr= [NSString stringWithFormat:@"http://img.meelive.cn/%@",model.creator.portrait];
        
    }
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_room.jpg"] options:SDWebImageCacheMemoryOnly];
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
