//
//  Tank.m
//  CivilWar
//
//  Created by Kevin Frans on 4/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tank.h"

@implementation Tank
{
    int health;
}

- (id)init {
    self = [super init];
    
    if (self) {
        health = 20;
        NSLog(@"bear made");
    }
    return self;
}

@end
