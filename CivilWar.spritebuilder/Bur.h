//
//  Bur.h
//  CivilWar
//
//  Created by Kevin Frans on 4/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Bur : CCSprite


+(int) getHealth:(Bur*) bur;

+(void) setHealth:(Bur*) bur forInt:(int) health;

+(int) getType:(Bur*) bur;

+(void) setType:(Bur*) bur forInt:(int) type;

+(int) getState:(Bur*) bur;

+(void) setState:(Bur*) bur forInt:(int) state;




    


@end
