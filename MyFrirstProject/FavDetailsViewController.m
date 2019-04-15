//
//  FavDetailsViewController.m
//  MyFrirstProject
//
//  Created by sara galal on 3/31/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import "FavDetailsViewController.h"

@interface FavDetailsViewController ()

@end

@implementation FavDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    _favTitle.text=[_movie titles];
    
    _favover.text=[_movie overview];
 
    _ratingLabel.text=[_movie rate];
   
    _releaseLabel.text=[_movie releaseDate];
    
    
    NSString *posterstr =@"http://image.tmdb.org/t/p/w185";
    if([_movie imagePath] && ![[_movie imagePath] isKindOfClass:[NSNull class]]){
        
        NSString *imgStr= [posterstr stringByAppendingString:[_movie imagePath]];
     
        [_favImg sd_setImageWithURL:[NSURL URLWithString:imgStr]
                    placeholderImage:[UIImage imageNamed:@"1.png"]];
    } else {
        UIImage *image= [UIImage imageNamed:@"noimage.png"];
        
        [_favImg setImage:image];
    }
    
}
    


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)unfavbt:(id)sender {
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:[_movie movieID]];
//   _favarray = [_favarray filteredArrayUsingPredicate:predicate];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:_favarray];
    for (int i=0; i<[_favarray count]; i++) {
        if([_favarray[i] isEqualToString:[_movie movieID]]) {
            [_favarray removeObject:_favarray[i]];
        }
    }
  
    _favarray = arr;
}
@end
