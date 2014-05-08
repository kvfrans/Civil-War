//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Bur.h"
#import "Tank.h"

@implementation MainScene
{
    CCNode* pengu;
    CCLabelTTF* _foodLabel;
    int food;
    int framespast;
    
    int limit;
    
    NSMutableArray* bears;
    NSMutableArray* tanks;
    NSMutableArray* CANNONBALLS;
    NSMutableArray* muskets;
    NSMutableArray* muskethorses;
    NSMutableArray* horses;
    NSMutableArray* dragoons;
    NSMutableArray* shots;
    
    NSMutableArray* e_bears;
    NSMutableArray* e_tanks;
    NSMutableArray* e_CANNONBALLS;
    NSMutableArray* e_muskets;
    NSMutableArray* e_muskethorses;
    NSMutableArray* e_horses;
    NSMutableArray* e_dragoons;
    NSMutableArray* e_shots;
    
    
    
    
    CCNode* _contentNode;
    
    bool movingLeft;
    bool movingRight;
}

- (id)init {
    self = [super init];
    
    if (self) {
        
        limit = 2200;
        
        bears = [[NSMutableArray alloc] init];
        tanks = [[NSMutableArray alloc] init];
        CANNONBALLS = [[NSMutableArray alloc] init];
        muskets = [[NSMutableArray alloc] init];
        muskethorses = [[NSMutableArray alloc] init];
        horses = [[NSMutableArray alloc] init];
        dragoons = [[NSMutableArray alloc] init];
        shots = [[NSMutableArray alloc] init];

        e_bears = [[NSMutableArray alloc] init];
        e_tanks = [[NSMutableArray alloc] init];
        e_CANNONBALLS = [[NSMutableArray alloc] init];
        e_muskets = [[NSMutableArray alloc] init];
        e_muskethorses = [[NSMutableArray alloc] init];
        e_horses = [[NSMutableArray alloc] init];
        e_dragoons = [[NSMutableArray alloc] init];
        e_shots = [[NSMutableArray alloc] init];
        
        //vars
        food = 1000;
        framespast = 0;
        
        self.userInteractionEnabled = true;
    }
    return self;
}

- (void)update:(CCTime)delta
{
    [self updateFood];
    [self moveGoodUnits];
    [self moveBadUnits];
    [self updateScrolls];
    framespast++;
}




-(void) moveBadUnits
{
    for(int i = 0; i < [e_bears count];i++)
    {
        Bur* temp = [e_bears objectAtIndex:i];
        
        [self meleeCheckBad:temp damage:5];
        
        if([Bur getState:temp] == 1)
        {
            
            temp.position = ccp(temp.position.x - 3, temp.position.y);
            
        }
        
        
        
        //out of range
        if(temp.position.x < 0)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [e_muskets count];i++)
    {
        Bur* temp = [e_muskets objectAtIndex:i];
        temp.position = ccp(temp.position.x - 3, temp.position.y);
        
        if((framespast % 100) == 0)
        {
            CCNode* CANNONBALL = [CCBReader load:@"Shot"];
            CANNONBALL.position = ccp(temp.position.x,temp.position.y + 15);
            [_contentNode addChild:CANNONBALL];
            [e_shots addObject:CANNONBALL];
        }
        
        //out of range
        if(temp.position.x < 0)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [e_muskethorses count];i++)
    {
        Bur* temp = [e_muskethorses objectAtIndex:i];
        temp.position = ccp(temp.position.x - 5, temp.position.y);
        
        if((framespast % 100) == 0)
        {
            CCNode* CANNONBALL = [CCBReader load:@"Shot"];
            CANNONBALL.position = ccp(temp.position.x,temp.position.y + 30);
            [_contentNode addChild:CANNONBALL];
            [e_shots addObject:CANNONBALL];
        }
        
        
        //out of range
        if(temp.position.x < 0)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [e_horses count];i++)
    {
        Bur* temp = [e_horses objectAtIndex:i];
        [self meleeCheckBad:temp damage:5];
        
        if([Bur getState:temp] == 1)
        {
        temp.position = ccp(temp.position.x - 5, temp.position.y);
        }
        
        
        //out of range
        if(temp.position.x < 0)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [e_dragoons count];i++)
    {
        Bur* temp = [e_dragoons objectAtIndex:i];
        temp.position = ccp(temp.position.x - 7, temp.position.y);
        
        
        //out of range
        if(temp.position.x < 0)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [e_tanks count];i++)
    {
        
        
        
        Tank* temp = [e_tanks objectAtIndex:i];
        temp.position = ccp(temp.position.x - 1, temp.position.y);
        
        if((framespast % 120) == 0)
        {
            CCNode* CANNONBALL = [CCBReader load:@"CANNNONBALL"];
            CANNONBALL.position = temp.position;
            [_contentNode addChild:CANNONBALL];
            [e_CANNONBALLS addObject:CANNONBALL];
        }
        
        
        
        //if it goes out of range
        if(temp.position.x < 0)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [e_CANNONBALLS count];i++)
    {
        CCNode* temp = [e_CANNONBALLS objectAtIndex:i];
        temp.position = ccp(temp.position.x - 6, temp.position.y);
        
        
        
        
        
        if(temp.position.x < 0)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    
    
    for(int i = 0; i < [e_shots count];i++)
    {
        CCNode* temp = [e_shots objectAtIndex:i];
        temp.position = ccp(temp.position.x - 20, temp.position.y);
        
        
        
        
        
        if(temp.position.x < 0)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
}



-(void) meleeCheckGood:(Bur *)attacker damage:(int)damage
{
    
}
//{
//    
//    bool areEnemies = false;
//    
//    for(int i = 0; i < [e_bears count];i++)
//    {
//        areEnemies = true;
//        Bur* temp = [e_bears objectAtIndex:i];
//        if(abs(attacker.position.x - temp.position.x) < 50)
//        {
//            [Bur setState:attacker forInt:2];
//            if((framespast % 60) == 0)
//            {
//                
//                [self damageBear:temp withDamage:damage];
//                NSLog(@"attack");
//            }
//        }
//        else
//        {
//            [Bur setState:attacker forInt:1];
//        }
//    }
//    
//    for(int i = 0; i < [e_muskets count];i++)
//    {
//        areEnemies = true;
//        Bur* temp = [e_muskets objectAtIndex:i];
//        if(abs(attacker.position.x - temp.position.x) < 50)
//        {
//            [Bur setState:attacker forInt:2];
//            if((framespast % 60) == 0)
//            {
//                
//                [self damageBear:temp withDamage:damage];
//                NSLog(@"attack");
//            }
//        }
//        else
//        {
//            [Bur setState:attacker forInt:1];
//        }
//    }
//    
//    for(int i = 0; i < [e_tanks count];i++)
//    {
//        areEnemies = true;
//        Bur* temp = [e_tanks objectAtIndex:i];
//        if(abs(attacker.position.x - temp.position.x) < 50)
//        {
//            [Bur setState:attacker forInt:2];
//            if((framespast % 60) == 0)
//            {
//                
//                [self damageBear:temp withDamage:damage];
//                NSLog(@"attack");
//            }
//        }
//        else
//        {
//            [Bur setState:attacker forInt:1];
//        }
//    }
//    
//    for(int i = 0; i < [e_muskethorses count];i++)
//    {
//        areEnemies = true;
//        Bur* temp = [e_muskethorses objectAtIndex:i];
//        if(abs(attacker.position.x - temp.position.x) < 50)
//        {
//            [Bur setState:attacker forInt:2];
//            if((framespast % 60) == 0)
//            {
//                
//                [self damageBear:temp withDamage:damage];
//                NSLog(@"attack");
//            }
//        }
//        else
//        {
//            [Bur setState:attacker forInt:1];
//        }
//    }
//    
//    for(int i = 0; i < [e_horses count];i++)
//    {
//        areEnemies = true;
//        Bur* temp = [e_horses objectAtIndex:i];
//        if(abs(attacker.position.x - temp.position.x) < 50)
//        {
//            [Bur setState:attacker forInt:2];
//            if((framespast % 60) == 0)
//            {
//                
//                [self damageBear:temp withDamage:damage];
//                NSLog(@"attack");
//            }
//        }
//        else
//        {
//            [Bur setState:attacker forInt:1];
//        }
//    }
//    
//    for(int i = 0; i < [e_dragoons count];i++)
//    {
//        areEnemies = true;
//        Bur* temp = [e_dragoons objectAtIndex:i];
//        if(abs(attacker.position.x - temp.position.x) < 50)
//        {
//            [Bur setState:attacker forInt:2];
//            if((framespast % 60) == 0)
//            {
//                
//                [self damageBear:temp withDamage:damage];
//                NSLog(@"attack");
//            }
//        }
//        else
//        {
//            [Bur setState:attacker forInt:1];
//        }
//    }
//    
//    
//    if(areEnemies == false)
//    {
//        [Bur setState:attacker forInt:1];
//    }
//}

-(void) meleeCheckBad:(Bur *)attacker damage:(int)damage
{
    for(int i = 0; i < [bears count];i++)
    {
        Bur* temp = [bears objectAtIndex:i];
        if(abs(attacker.position.x - temp.position.x) < 50)
        {
            [Bur setState:attacker forInt:2];
            if((framespast % 60) == 0)
            {
                
                [self damageBear:temp withDamage:damage];
                NSLog(@"attack");
            }
        }
        else
        {
            [Bur setState:attacker forInt:1];
        }
    }
    
    for(int i = 0; i < [horses count];i++)
    {
        Bur* temp = [horses objectAtIndex:i];
        if(abs(attacker.position.x - temp.position.x) < 50)
        {
            [Bur setState:attacker forInt:2];
            if((framespast % 60) == 0)
            {
                
                [self damageBear:temp withDamage:damage];
                NSLog(@"attack");
            }
        }
        else
        {
            [Bur setState:attacker forInt:1];
        }
    }
    
    for(int i = 0; i < [muskethorses count];i++)
    {
        Bur* temp = [muskethorses objectAtIndex:i];
        if(abs(attacker.position.x - temp.position.x) < 50)
        {
            [Bur setState:attacker forInt:2];
            if((framespast % 60) == 0)
            {
                
                [self damageBear:temp withDamage:damage];
                NSLog(@"attack");
            }
        }
        else
        {
            [Bur setState:attacker forInt:1];
        }
    }
    
    for(int i = 0; i < [muskets count];i++)
    {
        Bur* temp = [muskets objectAtIndex:i];
        if(abs(attacker.position.x - temp.position.x) < 50)
        {
            [Bur setState:attacker forInt:2];
            if((framespast % 60) == 0)
            {
                
                [self damageBear:temp withDamage:damage];
                NSLog(@"attack");
            }
        }
        else
        {
            [Bur setState:attacker forInt:1];
        }
    }
    
    for(int i = 0; i < [tanks count];i++)
    {
        Bur* temp = [tanks objectAtIndex:i];
        if(abs(attacker.position.x - temp.position.x) < 50)
        {
            [Bur setState:attacker forInt:2];
            if((framespast % 60) == 0)
            {
                
                [self damageBear:temp withDamage:damage];
                NSLog(@"attack");
            }
        }
        else
        {
            [Bur setState:attacker forInt:1];
        }
    }
    
    for(int i = 0; i < [dragoons count];i++)
    {
        Bur* temp = [dragoons objectAtIndex:i];
        if(abs(attacker.position.x - temp.position.x) < 50)
        {
            [Bur setState:attacker forInt:2];
            if((framespast % 60) == 0)
            {
                
                [self damageBear:temp withDamage:damage];
                NSLog(@"attack");
            }
        }
        else
        {
            [Bur setState:attacker forInt:1];
        }
    }
}



-(void) shootBulletGood:(CGPoint)pos
{
    CCNode* CANNONBALL = [CCBReader load:@"Shot"];
    CANNONBALL.position = ccp(pos.x,pos.y + 15);
    [_contentNode addChild:CANNONBALL];
    [shots addObject:CANNONBALL];
}

//actions of the good units.
-(void) moveGoodUnits
{
    for(int i = 0; i < [bears count];i++)
    {
        Bur* temp = [bears objectAtIndex:i];
        
        [self meleeCheckGood:temp damage:5];
        
        if([Bur getState:temp] == 1)
        {
            temp.position = ccp(temp.position.x + 3, temp.position.y);
        }
        //out of range
        if(temp.position.x > limit)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [muskets count];i++)
    {
        Bur* temp = [muskets objectAtIndex:i];
        
        [self meleeCheckGood:temp damage:5];
        
        if([Bur getState:temp] == 1)
        {
            temp.position = ccp(temp.position.x + 3, temp.position.y);
            
        }
        
        if((framespast % 100) == 0)
        {
            [self shootBulletGood:temp.position];
        }
        
        //out of range
        if(temp.position.x > limit)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [muskethorses count];i++)
    {
        Bur* temp = [muskethorses objectAtIndex:i];
        [self meleeCheckGood:temp damage:2];
        
        if([Bur getState:temp] == 1)
        {
            
        temp.position = ccp(temp.position.x + 5, temp.position.y);
            
        }
        
        if((framespast % 100) == 0)
        {
            CCNode* CANNONBALL = [CCBReader load:@"Shot"];
            CANNONBALL.position = ccp(temp.position.x,temp.position.y + 30);
            [_contentNode addChild:CANNONBALL];
            [shots addObject:CANNONBALL];
        }
        
        
        //out of range
        if(temp.position.x > limit)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [horses count];i++)
    {
        Bur* temp = [horses objectAtIndex:i];
        
        [self meleeCheckGood:temp damage:5];
        
        if([Bur getState:temp] == 1)
        {
            
        temp.position = ccp(temp.position.x + 5, temp.position.y);
        }
        
        
        //out of range
        if(temp.position.x > limit)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [dragoons count];i++)
    {
        Bur* temp = [dragoons objectAtIndex:i];
        
        [self meleeCheckGood:temp damage:5];
        
        if([Bur getState:temp] == 1)
        {
            
        temp.position = ccp(temp.position.x + 7, temp.position.y);
        }
        
        
        //out of range
        if(temp.position.x > limit)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [tanks count];i++)
    {
        

        
        Tank* temp = [tanks objectAtIndex:i];
        
        [self meleeCheckGood:temp damage:0];
        
        if([Bur getState:temp] == 1)
        {
            
        temp.position = ccp(temp.position.x + 1, temp.position.y);
        }
        
        if((framespast % 120) == 0)
        {
            CCNode* CANNONBALL = [CCBReader load:@"CANNNONBALL"];
            CANNONBALL.position = temp.position;
            [_contentNode addChild:CANNONBALL];
            [CANNONBALLS addObject:CANNONBALL];
        }
        
        
        
        //if it goes out of range
        if(temp.position.x > limit)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    for(int i = 0; i < [CANNONBALLS count];i++)
    {
        CCNode* temp = [CANNONBALLS objectAtIndex:i];
        
        
        temp.position = ccp(temp.position.x + 6, temp.position.y);
        
        

        
        
        if(temp.position.x > limit)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
    
    
    
    for(int i = 0; i < [shots count];i++)
    {
        CCNode* temp = [shots objectAtIndex:i];
        temp.position = ccp(temp.position.x + 20, temp.position.y);
        
        
        
        
        
        if(temp.position.x > limit)
        {
            if((framespast % 20) == 0)
            {
                [self damageBear:temp withDamage:5];
                NSLog([NSString stringWithFormat:@"%d",[Bur getHealth:temp]]);
            }
        }
    }
}

-(void) updateScrolls
{
    if(movingLeft)
    {
        _contentNode.position = ccp(_contentNode.position.x + 20,_contentNode.position.y);
    }
    
    if(movingRight)
    {
        _contentNode.position = ccp(_contentNode.position.x - 20,_contentNode.position.y);
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self];
    // create a 'hero' sprite
    
    
    if(touchLocation.x > 400 )
    {
        movingRight = true;
    }
    
    if(touchLocation.x < 80 )
    {
        movingLeft = true;
    }
    
}


- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self];
    // create a 'hero' sprite
    
    
    
    movingLeft = false;
    movingRight = false;
    
    
}


-(void) updateFood
{
    if((framespast % 2) == 0)
    {
        if(food > 0)
        {
            food++;
        }
    }
    
    
    [_foodLabel setString:[NSString stringWithFormat:@"%d food",food]];
}


-(void) damageBear:(Bur*)bur withDamage:(int) dmg
{
//    [Bur setHealth:bur forInt:[Bur getHealth:bur]-dmg];
//    id tint = [CCActionTintTo actionWithDuration:0.2f color:[CCColor colorWithCcColor3b:ccc3(255,0,0)]];
//    id tintback = [CCActionTintTo actionWithDuration:0.2f color:[CCColor colorWithCcColor3b:ccc3(255,255,255)]];
//
//    [bur runAction:[CCActionSequence actions:tint,tintback, nil]];
//    
//    
    
//    if([Bur getHealth:bur] <= 0)
//    {
//        if([bears containsObject:bur])
//        {
//            [bears removeObject:bur];
//        }
//        if([horses containsObject:bur])
//        {
//            [horses removeObject:bur];
//        }
//        if([muskethorses containsObject:bur])
//        {
//            [muskethorses removeObject:bur];
//        }
//        if([muskets containsObject:bur])
//        {
//            [muskets removeObject:bur];
//        }
//        if([dragoons containsObject:bur])
//        {
//            [dragoons removeObject:bur];
//        }
//        if([CANNONBALLS containsObject:bur])
//        {
//            [CANNONBALLS removeObject:bur];
//        }
//        if([shots containsObject:bur])
//        {
//            [shots removeObject:bur];
//        }
//        if([tanks containsObject:bur])
//        {
//            [tanks removeObject:bur];
//        }
//        
//        
//        if([e_bears containsObject:bur])
//        {
//            [e_bears removeObject:bur];
//        }
//        if([e_horses containsObject:bur])
//        {
//            [e_horses removeObject:bur];
//        }
//        if([e_muskethorses containsObject:bur])
//        {
//            [e_muskethorses removeObject:bur];
//        }
//        if([e_muskets containsObject:bur])
//        {
//            [e_muskets removeObject:bur];
//        }
//        if([e_dragoons containsObject:bur])
//        {
//            [e_dragoons removeObject:bur];
//        }
//        if([e_CANNONBALLS containsObject:bur])
//        {
//            [e_CANNONBALLS removeObject:bur];
//        }
//        if([e_shots containsObject:bur])
//        {
//            [e_shots removeObject:bur];
//        }
//        if([e_tanks containsObject:bur])
//        {
//            [e_tanks removeObject:bur];
//        }
//        
//        
//
//        
//        [bur removeFromParentAndCleanup:YES];
//    }
}

-(void) makeEnemy
{
    [self makeHorse_e];
}

-(void) makePikeman
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Bur"];
        bear.position = ccp(0,50);
        [_contentNode addChild:bear];
        [bears addObject:bear];
        
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}




-(void) makeMusket
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Bur"];
       // Bur* bear = [CCSprite spriteWithImageNamed:@"bear.png"];
        bear.position = ccp(0,50);
        [_contentNode addChild:bear];
        [muskets addObject:bear];
        
        [Bur setHealth:bear forInt:15];
        [Bur setType:bear forInt:1];
        
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}

-(void) makeHorse
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Horse"];
        bear.position = ccp(0,50);
        [_contentNode addChild:bear];
        [horses addObject:bear];
        
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}

-(void) makeHorseMusket
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Horse"];
        bear.position = ccp(0,50);
        
       // [Bur setType:bear forInt:4]
        
        [_contentNode addChild:bear];
        [muskethorses addObject:bear];
        
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}

-(void) makeDragoon
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Dragoon"];
        bear.position = ccp(0,50);
        [_contentNode addChild:bear];
        [dragoons addObject:bear];
        
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}


-(void) makeArtillery
{
    if(food >= 300)
    {
        food = food - 300;
        CCNode* tank = [CCBReader load:@"Tank"];
        tank.position = ccp(0,50);
        [_contentNode addChild:tank];
        [tanks addObject:tank];
        
        
      //  CCActionFollow *follow = [CCActionFollow actionWithTarget:tank worldBoundary:self.boundingBox];
     //  [_contentNode runAction:follow];
        
    }
}



















-(void) makePikeman_e
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Bur"];
        bear.position = ccp(2200,50);
        [_contentNode addChild:bear];
        [e_bears addObject:bear];
        bear.scaleX = -1;
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}




-(void) makeMusket_e
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Bur"];
        bear.position = ccp(2200,50);
        [_contentNode addChild:bear];
        [e_muskets addObject:bear];
        bear.scaleX = -1;
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}

-(void) makeHorse_e
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Horse"];
        bear.position = ccp(2200,50);
        [_contentNode addChild:bear];
        [e_horses addObject:bear];
        bear.scaleX = -1;
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}

-(void) makeHorseMusket_e
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Horse"];
        bear.position = ccp(2200,50);
        bear.scaleX = -1;
        // [Bur setType:bear forInt:4]
        
        [_contentNode addChild:bear];
        [e_muskethorses addObject:bear];
        
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}

-(void) makeDragoon_e
{
    if(food >= 100)
    {
        food = food - 100;
        Bur* bear = [CCBReader load:@"Dragoon"];
        bear.position = ccp(2200,50);
        [_contentNode addChild:bear];
        [e_dragoons addObject:bear];
        bear.scaleX = -1;
        
        //CCActionFollow *follow = [CCActionFollow actionWithTarget:bear worldBoundary:self.boundingBox];
        //[_contentNode runAction:follow];
        
    }
}


-(void) makeArtillery_e
{
    if(food >= 300)
    {
        food = food - 300;
        CCNode* tank = [CCBReader load:@"Tank"];
        tank.position = ccp(2200,50);
        [_contentNode addChild:tank];
        [e_tanks addObject:tank];
        tank.scaleX = -1;
        
        
        //  CCActionFollow *follow = [CCActionFollow actionWithTarget:tank worldBoundary:self.boundingBox];
        //  [_contentNode runAction:follow];
        
    }
}






@end
