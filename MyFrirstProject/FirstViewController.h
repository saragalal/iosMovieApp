//
//  FirstViewController.h
//  MyFrirstProject
//
//  Created by sara galal on 3/29/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
#import "NetworkController.h"

#import "DetailsViewController.h"
#import "MovieModel.h"
#import "FavViewController.h"
#import "Reachability.h"
#import "DBmanager.h"
@interface FirstViewController : UIViewController <UICollectionViewDelegate , UICollectionViewDataSource>
{
    Reachability *internetReachableFoo;
}

@property (weak, nonatomic) IBOutlet UICollectionView *MyCollectionView;
@property (weak, nonatomic) IBOutlet UIView *menuView;

- (IBAction)menuBt:(id)sender;
- (IBAction)popBt:(id)sender;
- (IBAction)rateBt:(id)sender;

@property NSMutableArray *movies;
- (BOOL)connected;
//- (Boolean)testInternetConnection;
@end


