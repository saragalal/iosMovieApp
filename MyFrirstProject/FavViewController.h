//
//  FavViewController.h
//  MyFrirstProject
//
//  Created by sara galal on 3/31/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

#import "NetworkController.h"

@interface FavViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTable;





@end


