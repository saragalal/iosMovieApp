//
//  MovieModel.h
//  MyFrirstProject
//
//  Created by sara galal on 3/29/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieModel : NSObject

@property NSString *movieID;
@property  NSString *overview;
@property  NSString *rate;
@property  NSString *imagePath;
@property  NSString *releaseDate;
@property  NSString *titles;
@property NSString *backPath;
-(id)initWithDictionary:(NSDictionary *)sourceDictionary;


@end


