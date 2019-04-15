//
//  MovieModel.m
//  MyFrirstProject
//
//  Created by sara galal on 3/29/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

-(id)initWithDictionary:(NSDictionary *)sourceDictionary
{
    self = [super init];
    if (self != nil)
    {
        _movieID=[sourceDictionary valueForKey:@"id"];
        _overview=[sourceDictionary valueForKey:@"overview"];
        _imagePath=[sourceDictionary valueForKey:@"poster_path"];
        _backPath=[sourceDictionary valueForKey:@"backdrop_path"];
        _rate=[sourceDictionary valueForKey:@"vote_average"];
        _releaseDate=[sourceDictionary valueForKey:@"release_date"];
        _titles=[sourceDictionary valueForKey:@"title"];
    }
    return self;
    
}

@end
