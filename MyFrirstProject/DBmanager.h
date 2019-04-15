//
//  DBmanager.h
//  MyFrirstProject
//
//  Created by sara galal on 4/5/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MovieModel.h"

@interface DBmanager : NSObject
@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

-(id)init;
+(DBmanager*) sharedInstance;

-(Boolean)insertMovie :(MovieModel *)m;
-(Boolean)insertFavMovie :(MovieModel *)m;
-(NSMutableArray*)selectMovies;
-(NSMutableArray*)selectFavMovies;
-(Boolean)findFavMovie:(MovieModel *)m;
-(Boolean)deletemovie :(MovieModel*) m;
-(Boolean)deleteFavMovie :(MovieModel*) m ;
-(Boolean)removeall;
@end


