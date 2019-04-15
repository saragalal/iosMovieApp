//
//  NetworkController.m
//  MyFrirstProject
//
//  Created by sara galal on 3/29/19.
//  Copyright © 2019 sara galal. All rights reserved.
//

#import "NetworkController.h"
#import "AFNetworking.h"
@implementation NetworkController {

NSMutableArray *results;
  NSMutableArray *videos;
    NSMutableArray *reviews;
    NSString *BaseURL;
}

+(NetworkController *)sharedInstance{
    
    static NetworkController *net = nil;
    
    static dispatch_once_t onec_predicate;
    
    
    dispatch_once(&onec_predicate, ^{
        
        net = [NetworkController new];
        
    });
   
    return net;
   
}


-(void)getMoviesData :(NSString *)str1 :(id) vc{
    BaseURL =@"http://api.themoviedb.org/3";
   results =[NSMutableArray new];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *str =[BaseURL stringByAppendingString:str1];
    NSURL *url=[NSURL URLWithString:str];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
   NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSDictionary *resultDictinary = [responseObject objectForKey:@"results"];
            for (NSDictionary *userDictionary in resultDictinary)
            {
                //allocating new user from the dictionary
                MovieModel *movie=[[MovieModel alloc]initWithDictionary:userDictionary];
                [self->results addObject:movie];
            
           }

            
            [vc setMovies:self->results];
            
        }
       
       
    }]; [dataTask resume];
   
}

-(void)getVideoData :(NSString *)str1 :(id) detailsvc{
    BaseURL =@"http://api.themoviedb.org/3";
    videos =[NSMutableArray new];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *str =[[[BaseURL stringByAppendingString:@"/movie/"] stringByAppendingString:str1] stringByAppendingString:@"/videos?api_key=facd2bc8ee066628c8f78bbb7be41943&append_to_response=videos"];
    

    
    NSURL *url=[NSURL URLWithString:str];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSMutableArray *resultArray = [responseObject objectForKey:@"results"];
        
            if ([resultArray count] !=0) {
            NSString *keyresult =[resultArray objectAtIndex:0][@"key"];
            
            [detailsvc setKey:keyresult];
            
        }
        }
    }]; [dataTask resume];
    
    
}



-(void)getReviewsData :(NSString *)str1 :(id) detailsvc{
    BaseURL =@"http://api.themoviedb.org/3";
    videos =[NSMutableArray new];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *str =[[[BaseURL stringByAppendingString:@"/movie/"] stringByAppendingString:str1] stringByAppendingString:@"/reviews?api_key=facd2bc8ee066628c8f78bbb7be41943"];
    
   NSURL *url=[NSURL URLWithString:str];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSMutableArray *resultArray = [responseObject objectForKey:@"results"];
            
            [detailsvc setReviews:resultArray];
            
        }
        
        
    }]; [dataTask resume];
    
    
}

@end
