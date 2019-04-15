//
//  FavViewController.m
//  MyFrirstProject
//
//  Created by sara galal on 3/31/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import "FavViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface FavViewController () {
    DBmanager *db;
    NSMutableArray *favmovies;
    NSString *posterstr;
    Boolean flag;
}

@end

@implementation FavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Your Favorites Movies"];
    [_myTable setDelegate:self];
    [_myTable setDataSource:self];
    // Do any additional setup after loading the view.
    db=[DBmanager sharedInstance];
    favmovies=[NSMutableArray new];
    
}
- (void)viewWillAppear:(BOOL)animated {
    favmovies=[db selectFavMovies];
    [_myTable reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    NSUInteger numOfSection= 1;
    if([favmovies count] !=0){
        
        numOfSection=1;
    }
  
    return numOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   NSInteger numOfItems=0;
    if([favmovies count]!=0){
        numOfItems=[favmovies count];
    }
    return numOfItems;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favCell" forIndexPath:indexPath];
    MovieModel *movie=favmovies[indexPath.row] ;
    NSLog(@"%@",[movie imagePath]);
    UITextView *movieName=[cell viewWithTag:6];
    UIImageView *img=[cell viewWithTag:5];
     posterstr =@"http://image.tmdb.org/t/p/w185";
    movieName.text=[favmovies[indexPath.row] titles];
    
    if([favmovies[indexPath.row] imagePath]&& ![ [favmovies[indexPath.row] imagePath] isKindOfClass:[NSNull class]]) {
        NSString *imgStr= [posterstr stringByAppendingString:[favmovies[indexPath.row] imagePath]];
    [img sd_setImageWithURL:[NSURL URLWithString:imgStr]
                 placeholderImage:[UIImage imageNamed:@"noimage.png"]];
    
    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
       flag= [db deleteFavMovie:favmovies[indexPath.row]];
        if(flag){
        [favmovies removeObjectAtIndex:indexPath.row];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
    @end
