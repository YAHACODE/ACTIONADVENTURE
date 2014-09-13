//
//  Level2.m
//  GameArchitecture
//
//  Created by Yahia Bouhlel on 10/06/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Level2.h"
#import "WinPopup.h"
#import "CCActionFollow+CurrentOffset.h"
#define CP_ALLOW_PRIVATE_ACCESS 1
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Character.h"

@implementation Level2  {
    Character *_character;
    
    CCPhysicsNode *_physicsNode;
    BOOL _jumped;
    CCSprite*_rightButton;
    CCSprite*_leftButton;
    CCSprite*_jumpbutton;
    CCSprite*_restartlevel1;
    CCSprite*_Startscene;
    CCNode*_contentNode;
    
}

- (void)didLoadFromCCB {
    _physicsNode.collisionDelegate = self;
}

- (void)onEnter {
    [super onEnter];
    
    CCActionFollow *follow = [CCActionFollow actionWithTarget:_character worldBoundary:_physicsNode.boundingBox];
    _physicsNode.position = [follow currentOffset];
    [_physicsNode runAction:follow];
}

- (void)onEnterTransitionDidFinish {
    [super onEnterTransitionDidFinish];
    
    self.userInteractionEnabled = YES;
}



- (void)resetJump {
    _jumped = FALSE;
}



- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero flag:(CCNode *)flag {
    self.paused = YES;
    
    WinPopup *popup = (WinPopup *)[CCBReader load:@"WinPopup"];
    popup.positionType = CCPositionTypeNormalized;
    popup.position = ccp(0.5, 0.5);
    popup.nextLevelName = @"Level2";
    [self addChild:popup];
    
    return TRUE;
}


-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero obs:(CCNode *)obs {
    
    CCScene *restartScene = [CCBReader loadAsScene:@"Level1"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:restartScene withTransition:transition];
    
    return TRUE;
}

- (void)update:(CCTime)delta {
    if (CGRectGetMaxY([_character boundingBox]) <  CGRectGetMinY(_physicsNode.boundingBox)) {
        [self gameOver];
    }
}

- (void)gameOver {
    CCScene *restartScene = [CCBReader loadAsScene:@"Level1"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:restartScene withTransition:transition];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchLocation = [touch locationInNode: _contentNode];
    CGSize size = [[CCDirector sharedDirector] viewSize];
    id moveLeft = [CCActionMoveBy actionWithDuration:1.5 position:ccp(-size.width/1,5)];
    [moveLeft setTag:11];
    id moveRight = [CCActionMoveBy actionWithDuration:1.5 position:ccp(size.width/1,5)];
    [moveRight setTag:12];
    if(CGRectContainsPoint([_leftButton boundingBox], touchLocation)) {
        
        [_character runAction:moveLeft];
        NSLog(@"the left button was pressed");
        _character.flipX=YES;
        
    }
    if(CGRectContainsPoint([_rightButton boundingBox], touchLocation)) {
        
        [_character  runAction:moveRight];
        NSLog(@"the right button was pressed");
        _character.flipX=NO;
        
        
    }
    
    
    CGPoint touchLocation2 = [touch locationInNode: _contentNode];
    
    if(CGRectContainsPoint([_jumpbutton boundingBox], touchLocation2)) {
        
        
        [_character jump];
        NSLog(@"characterjump");
        
    }
    
    CGPoint touchLocation3 = [touch locationInNode: _contentNode];
    
    if(CGRectContainsPoint([_restartlevel1 boundingBox], touchLocation3)) {
        
        CCScene *firstLevel = [CCBReader loadAsScene:@"Level1"];
        CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
        [[CCDirector sharedDirector] presentScene:firstLevel withTransition:transition];
    }
    
    CGPoint touchLocation4 = [touch locationInNode: _contentNode];
    
    if(CGRectContainsPoint([_Startscene boundingBox], touchLocation4)) {
        
        CCScene *firstLevel = [CCBReader loadAsScene:@"StartScene"];
        CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
        [[CCDirector sharedDirector] presentScene:firstLevel withTransition:transition];
    }
    
    
    
}
- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [_character stopActionByTag:11];
    [_character stopActionByTag:12];
    
}

-(void) stopActionByTag:(NSInteger)tag {
    [_character stopActionByTag:tag];
    
    
}



@end
