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
    NSMutableArray* bears;
    NSMutableArray* tanks;
    NSMutableArray* CANNONBALLS;
    CCNode* _contentNode;
    
    bool movingLeft;
    bool movingRight;
}

- (id)init {
    self = [super init];
    
    if (self) {
        
        bears = [[NSMutableArray alloc] init];
        tanks = [[NSMutableArray alloc] init];
        CANNONBALLS = [[NSMutableArray alloc] init];
        
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
    [self updateScrolls];
    framespast++;
}

//actions of the good units.
-(void) moveGoodUnits
{
    for(int i = 0; i < [bears count];i++)
    {
        Bur* temp = [bears objectAtIndex:i];
        temp.position = ccp(temp.position.x + 5, temp.position.y);
        
        
        //out of range
        if(temp.position.x > 960)
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
        temp.position = ccp(temp.position.x + 3, temp.position.y);
        
        if((framespast % 120) == 0)
        {
            CCNode* CANNONBALL = [CCBReader load:@"CANNNONBALL"];
            CANNONBALL.position = temp.position;
            [_contentNode addChild:CANNONBALL];
            [CANNONBALLS addObject:CANNONBALL];
        }
        
        
        
        //if it goes out of range
        if(temp.position.x > 960)
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
        temp.position = ccp(temp.position.x + 8, temp.position.y);
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
    [Bur setHealth:bur forInt:[Bur getHealth:bur]-dmg];
    id tint = [CCActionTintTo actionWithDuration:0.2f color:[CCColor colorWithCcColor3b:ccc3(255,0,0)]];
    id tintback = [CCActionTintTo actionWithDuration:0.2f color:[CCColor colorWithCcColor3b:ccc3(255,255,255)]];

    [bur runAction:[CCActionSequence actions:tint,tintback, nil]];
    
    
    
    if([Bur getHealth:bur] <= 0)
    {
        [bears removeObject:bur];
        [bur removeFromParentAndCleanup:YES];
    }
}

-(void) makeBear
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


-(void) makeTank
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


-(void) makeEvilBear
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
@end
