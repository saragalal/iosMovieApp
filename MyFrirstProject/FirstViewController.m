//
//  FirstViewController.m
//  MyFrirstProject
//
//  Created by sara galal on 3/29/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import "FirstViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface FirstViewController () {
  
    NSString *posterstr;
    NSString *moviestr;
    NetworkController *net;

    DBmanager *db;
    DetailsViewController *vc;
     MovieModel *m;
    NSMutableArray *ids;
    FavViewController *fav;
    Boolean flag;
   
    
}

@end

@implementation FirstViewController
static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [_MyCollectionView setDelegate:self];
    [_MyCollectionView setDataSource:self];
    [_menuView setHidden:YES];
    // Do any additional setup after loading the view.
   
    db=[DBmanager sharedInstance];
    [self setTitle:@"Pop Movies"];
    _movies=[NSMutableArray new];

    m=[MovieModel new];
    
    vc=[self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    [self setTitle:@"Pop Movies"];
    
    net= [NetworkController sharedInstance];
    
    
    fav=[self.storyboard instantiateViewControllerWithIdentifier:@"favView"];
    
    
    moviestr =@"/discover/movie?sort_by=popularity.desc&api_key=facd2bc8ee066628c8f78bbb7be41943";
  [net getMoviesData:moviestr: self];
    
    if (![self connected]) {
        // Not connected
          _movies=[db selectMovies];
        
        NSLog(@"Yayyy, we have the interwebs!");
    } else {
        // Connected. Do some Internet stuff
        [net getMoviesData:moviestr :self];
        NSLog(@"no interwebs!");
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
  // [net getMoviesData:moviestr :self];
    if (![self connected]) {
        // Not connected
         _movies=[db selectMovies];
        [net getMoviesData:moviestr :self];
      
    } else {
        // Connected. Do some Internet stuff
        [net getMoviesData:moviestr :self];
        
    }
    [self.MyCollectionView reloadData];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)setMovies:(NSMutableArray *)movies{
    _movies=movies;
    [db removeall];
    for (int i=0; i<[_movies count]; i++) {
        [db insertMovie:_movies[i]];
    }
    [self.MyCollectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSUInteger numOfSection= 0;
    if([_movies count] !=0){
        
        numOfSection=1;
    }
    return numOfSection;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger numOfItems =0;
    if([_movies count] !=0){
        numOfItems=[_movies count];
    }
    return numOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  
   posterstr =@"http://image.tmdb.org/t/p/w185";
    
 
     UIImageView *imageView= [cell viewWithTag:2];
   
    
    if([_movies[indexPath.row] imagePath]&& ![ [_movies[indexPath.row] imagePath] isKindOfClass:[NSNull class]]) {
    NSString *imgStr= [posterstr stringByAppendingString:[_movies[indexPath.row] imagePath]];
    
    
   
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgStr]
                 placeholderImage:[UIImage imageNamed:@"noimage.png"]];
    } else {
        UIImage *image= [UIImage imageNamed:@"noimage.png"];
      
        [imageView setImage:image];
    }
    
    m=_movies[indexPath.row];
   

    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   m=_movies[indexPath.row];
    

    
        [vc setMovie:m];
       
        [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (IBAction)menuBt:(id)sender {
   
    if(_menuView.isHidden){
    [_menuView setHidden:NO];
    }else {
        [_menuView setHidden:YES];
    }
    
}
- (IBAction)popBt:(id)sender {
  
    [self setTitle:@"Pop Movies"];
    moviestr =@"/discover/movie?sort_by=popularity.desc&api_key=facd2bc8ee066628c8f78bbb7be41943";
    [_menuView setHidden:YES];
    [net getMoviesData:moviestr :self];
     [_menuView setHidden:YES];
}

- (IBAction)rateBt:(id)sender {
   
    moviestr =@"/discover/movie?sort_by=vote_average.desc&api_key=facd2bc8ee066628c8f78bbb7be41943";
    [self setTitle:@"Rated Movies"];
    [_menuView setHidden:YES];
    [net getMoviesData:moviestr :self];
  
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}





@end
