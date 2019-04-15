//
//  DBmanager.m
//  MyFrirstProject
//
//  Created by sara galal on 4/5/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import "DBmanager.h"

@implementation DBmanager {
    
    NSString *docsDir;
    NSArray *dirPaths;
    Boolean flag;
   NSMutableArray *movies;
    MovieModel *movie;
}
+(DBmanager *)sharedInstance{
    
    static DBmanager *db = nil;
    
    static dispatch_once_t onec_predicate;
    
    
    dispatch_once(&onec_predicate, ^{
        
        db = [DBmanager new];
        
    });
  
    return db;
   
}

-(id)init{
    self=[super init];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"mymoviesapp.db"]];
    
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS MOVIES (ID INTEGER PRIMARY KEY AUTOINCREMENT,MOVIEID TEXT, TITLE TEXT, OVERVIEW TEXT , RDATE TEXT , RATE TEXT ,IMGPATH TEXT)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create movietable");
        }
        
        const char *sql_stmt1 =
        "CREATE TABLE IF NOT EXISTS FAVMOVIES (ID INTEGER PRIMARY KEY AUTOINCREMENT,MOVIEID TEXT, TITLE TEXT, OVERVIEW TEXT , RDATE TEXT , RATE TEXT ,IMGPATH TEXT)";
        
        if (sqlite3_exec(_contactDB, sql_stmt1, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create favtable");
        }
        
        
        sqlite3_close(_contactDB);
    } else {
        printf("Failed to open/create favdatabase");
    }
    
    
    return self;
}

-(Boolean)insertMovie :(MovieModel *)m {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO MOVIES (movieid, title, overview,  rdate, rate ,imgpath) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\")",
                               m.movieID,m.titles, m.overview, m.releaseDate, m.rate, m.imagePath];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            flag=YES;
        } else {
            
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
    return flag;
}

-(Boolean)insertFavMovie :(MovieModel *)m {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO FAVMOVIES (movieid, title, overview, rdate, rate ,imgpath) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                               m.movieID,m.titles, m.overview, m.releaseDate, m.rate, m.imagePath];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            flag=YES;
        } else {
            
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
    return flag;
}



-(NSMutableArray*)selectMovies {
    
    movies=[NSMutableArray new];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT movieid, title, overview, rdate, rate, imgpath FROM movies "];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            { movie =[MovieModel new];
                movie.movieID = [[NSString alloc]
                          initWithUTF8String:
                          (const char *) sqlite3_column_text(
                                                             statement, 0)];
                
                
                movie.titles = [[NSString alloc]
                             initWithUTF8String:
                             (const char *) sqlite3_column_text(
                                                                statement, 1)];
                
                movie.overview = [[NSString alloc]
                           initWithUTF8String:(const char *)
                           sqlite3_column_text(statement, 2)];
               
                movie.releaseDate=[[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 3)];
               movie.rate=[[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 4)];
               
                movie.imagePath=[[NSString alloc]
                                 initWithUTF8String:(const char *)
                                 sqlite3_column_text(statement, 5)];
                
                [movies addObject:movie];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    return movies;
    
}

-(NSMutableArray*)selectFavMovies {
    
    movies=[NSMutableArray new];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT movieid, title, overview ,rdate ,rate ,imgpath FROM favmovies "];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            { movie =[MovieModel new];
                movie.movieID = [[NSString alloc]
                                 initWithUTF8String:
                                 (const char *) sqlite3_column_text(
                                                                    statement, 0)];
                
                
                movie.titles = [[NSString alloc]
                                initWithUTF8String:
                                (const char *) sqlite3_column_text(
                                                                   statement, 1)];
                
                movie.overview = [[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 2)];
            
                movie.releaseDate=[[NSString alloc]
                                   initWithUTF8String:(const char *)
                                   sqlite3_column_text(statement, 3)];
                movie.rate=[[NSString alloc]
                            initWithUTF8String:(const char *)
                            sqlite3_column_text(statement, 4)];
                movie.imagePath=[[NSString alloc]
                            initWithUTF8String:(const char *)
                            sqlite3_column_text(statement, 5)];
                
                [movies addObject:movie];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    return movies;
    
}

-(Boolean)findFavMovie:(MovieModel *)m{
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT movieid, title, overview ,rdate ,rate ,imgpath FROM favmovies WHERE movieid=\"%@\"",
                              m.movieID];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                flag=YES;
            } else {
                flag=NO;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    
    return flag;
}



-(Boolean)deletemovie :(MovieModel*) m {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    
    {
        
        NSString *deleteSQL = [NSString stringWithFormat:
                               @"DELETE FROM movies WHERE movieid=\"%@\"",m.movieID];
      
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            flag=YES;
        } else {
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return flag;
}

-(Boolean)deleteFavMovie :(MovieModel*) m {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        
    {
        
        NSString *deleteSQL = [NSString stringWithFormat:
                               @"DELETE FROM favmovies WHERE movieid=\"%@\"",m.movieID];
        
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            flag=YES;
        }else {
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return flag;
}
-(Boolean)removeall {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        
    {
        
        NSString *deleteSQL = [NSString stringWithFormat:
                               @"DELETE FROM movies "];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            flag=YES;
        } else {
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return flag;

}


@end
