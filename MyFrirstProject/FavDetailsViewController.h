//
//  FavDetailsViewController.h
//  MyFrirstProject
//
//  Created by sara galal on 3/31/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FavDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *favImg;
@property (weak, nonatomic) IBOutlet UITextView *favover;
@property (weak, nonatomic) IBOutlet UILabel *favTitle;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
- (IBAction)unfavbt:(id)sender;

@property MovieModel *movie;

@property NSMutableArray *favarray;
@end


