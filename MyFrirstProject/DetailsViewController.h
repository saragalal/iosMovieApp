//
//  DetailsViewController.h
//  MyFrirstProject
//
//  Created by sara galal on 3/31/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

#import "HCSStarRatingView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NetworkController.h"
#import "DBmanager.h"

@interface DetailsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *lDate;
@property (weak, nonatomic) IBOutlet UITextView *overTxt;
@property (weak, nonatomic) IBOutlet UILabel *lrating;
- (IBAction)favBt:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UITextView *lname;
- (IBAction)youtubeBt:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (weak, nonatomic) IBOutlet UIButton *btfav;

@property (weak, nonatomic) IBOutlet UIView *noReviewsView;

@property NSMutableArray *fav;
@property MovieModel *movie ;
@property NSString *key;
@property NSMutableArray *reviews;
@end


