//
//  EADateInterval.h
//  EASE
//
//  Created by Aladin TALEB on 03/02/2015.
//  Copyright (c) 2015 Aladin TALEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EADateInterval : NSObject

@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, strong) NSDate *endDate;

-(NSTimeInterval)timeInterval;
-(BOOL)intersects:(EADateInterval*)dateInterval;

@end
