//
//  Bur.m
//  CivilWar
//
//  Created by Kevin Frans on 4/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Bur.h"

@implementation Bur
{
    int health;
    int type;
    int speed;
}

- (id)init {
    self = [super init];
    
    if (self) {
        health = 10;
        type = 1;
        NSLog(@"bear made");
    }
    return self;
}


+(int) getHealth:(Bur*) bur
{
    return bur->health;
}

+(void) setHealth:(Bur*) bur forInt:(int) health
{
    bur->health = health;
}


+(int) getType:(Bur*) bur
{
    return bur->type;
}

+(void) setType:(Bur*) bur forInt:(int) type
{
    bur->type = type;
}

+(int) getSpeed:(Bur*) bur
{
    return bur->speed;
}

+(void) setSpeed:(Bur*) bur forInt:(int) speed
{
    bur->speed = speed;
}

@end
