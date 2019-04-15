//
//  DetailsViewController.m
//  MyFrirstProject
//
//  Created by sara galal on 3/31/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import "DetailsViewController.h"


@interface DetailsViewController ()
{
    float r;
    NetworkController *net;
    UILabel *author;
    UITextView *content1;
    NSString *s;
    DBmanager *db;
    Boolean flag;
}

@end

@implementation DetailsViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _fav= [NSMutableArray new];
    [_mytable setDelegate:self];
    [_mytable setDataSource:self];
    db=[DBmanager sharedInstance];
    net=[NetworkController sharedInstance];
   // [net setDetailsvc:self];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
    _reviews=@[];
    s= [NSString stringWithFormat:@"%@",[_movie movieID]];
    [net getReviewsData:s :self];
   // NSLog(@"movie details %@",_movie);
    _lname.text=[_movie titles];
   // NSLog(@"title %@", [_movie titles]);
    _overTxt.text=[_movie overview];
   // NSLog(@"overview %@", [_movie overview]);
   _rateLabel.text=[NSString stringWithFormat:@"%@",[_movie rate]];
   // NSLog(@"rating %@", [_movie rate]);
   _lDate.text=[_movie releaseDate];
   // NSLog(@"release %@", [_movie releaseDate]);
    
    r=[[_movie rate] floatValue];
    
    
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(190, 270, 145, 30)];
    starRatingView.maximumValue = 10;
    starRatingView.minimumValue = 0;
    starRatingView.backgroundColor=[UIColor blackColor];
    starRatingView.value = r;
    starRatingView.tintColor = [UIColor redColor];
    starRatingView.accurateHalfStars = YES;
    starRatingView.allowsHalfStars = YES;
    [self.view addSubview:starRatingView];
 

    NSString *posterstr =@"http://image.tmdb.org/t/p/w185";
    if([_movie imagePath] && ![[_movie imagePath] isKindOfClass:[NSNull class]]){
        
        NSString *imgStr= [posterstr stringByAppendingString:[_movie backPath]];
      
      
        [_imgView sd_setImageWithURL:[NSURL URLWithString:imgStr]
                     placeholderImage:[UIImage imageNamed:@"noimage.png"]];
    } else {
        UIImage *image= [UIImage imageNamed:@"noimage.png"];
        
        [_imgView setImage:image];
    }

    flag= [db findFavMovie:_movie];
    if(flag){
      
        [_btfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic_act.png"] forState:UIControlStateNormal];
    } else {
     
        [_btfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic.png"] forState:UIControlStateNormal];
    }
    
    
}

- (void)setReviews:(NSMutableArray *)reviews{
    _reviews=reviews;
    [self.mytable reloadData];
    
}

- (void)setKey:(NSString *)key{
    _key=key;
    if(_key && ![_key isKindOfClass:[NSNull class]]){
    NSString *keystr=[@"youtube://" stringByAppendingString:_key];
    NSURL *str=[NSURL URLWithString:keystr];
    if ([[UIApplication sharedApplication] canOpenURL:str])
    {  [[UIApplication sharedApplication] openURL:str];
        
    } else {
        NSString *keystr=[@"http://www.youtube.com/watch?v=" stringByAppendingString:_key];
        NSURL *str=[NSURL URLWithString:keystr];
        [[UIApplication sharedApplication] openURL:str];
    }
    }
}


- (IBAction)favBt:(id)sender {
    Boolean f;
    flag= [db findFavMovie:_movie];
    if(flag){
          [_btfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic.png"] forState:UIControlStateHighlighted];
     f=   [db deleteFavMovie:_movie];
      
    } else {
        [_btfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic_act.png"] forState:UIControlStateHighlighted];
     f= [db insertFavMovie:_movie];
        
    }
    
}

- (IBAction)youtubeBt:(id)sender {
    
 
    [net getVideoData:s :self];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = 1;
    if ([_reviews count] != 0)
    {
        self.mytable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [_noReviewsView setHidden:YES];
        
        
    }
    else
    {
        [_noReviewsView setHidden:NO];
        
    }
    return numOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger numOfRows=0;
    if([_reviews count] != 0){
        numOfRows=[_reviews count];
    }
    
    return numOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *cellIdentifier = @"reviewCell";
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    author=[cell viewWithTag:11];
    content1=[cell viewWithTag:12];
    
    author.text=_reviews[indexPath.row][@"author"];
    content1.text=_reviews[indexPath.row][@"content"];
  
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 100;
    
}


@end
