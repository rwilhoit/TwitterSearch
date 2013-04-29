//
//  Globals.m
//  TwitterSearch
//
//  Created by Raj Wilhoit on 3/14/13.
//
//

#import "Globals.h"

@implementation Globals

+(NSMutableArray*)globalArray {
    static NSMutableArray *statArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        statArray = [NSMutableArray array];
    });
    return statArray;
}

@end
