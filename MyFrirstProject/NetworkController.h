//
//  NetworkController.h
//  MyFrirstProject
//
//  Created by sara galal on 3/29/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "MovieModel.h"
#import "FirstViewController.h"
@interface NetworkController : NSObject

-(void)getMoviesData :(NSString *) str1 :(id) vc;
-(void)getVideoData :(NSString *)str1 :(id) detailsvc;
//@property id vc;
//@property id detailsvc;

+(NetworkController*) sharedInstance;
-(void)getReviewsData :(NSString *)str1 :(id) detailsvc;
@end


