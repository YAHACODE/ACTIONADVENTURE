//
//  Level1.m
//  GameArchitecture
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "Level1.h"
#import "WinPopup.h"
#import "CCActionFollow+CurrentOffset.h"
#define CP_ALLOW_PRIVATE_ACCESS 1
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Character.h"
#import "bullet.h"

@implementation Level1 {
    Character *_character;

  CCPhysicsNode *_physicsNode;
  BOOL _jumped;
    CCSprite*_rightButton;
    CCSprite*_leftButton;
    CCSprite*_jumpbutton;
    CCSprite*_restartlevel1;
    CCSprite*_Startscene;
    CCNode*_contentNode;
    
    BOOL _gameOver;

    CCSprite*_ground1;
    CCSprite*_ground2;
    CCSprite*_ground3;



}

- (void)didLoadFromCCB {
  _physicsNode.collisionDelegate = self;
    self.physicsBody.collisionType = @"goal";
    self.physicsBody.collisionType = @"goal2";
    self.physicsBody.collisionType = @"goal3";

    
    self.physicsBody.sensor = YES;
    
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
           [self launchbullet ];
    }

    
    
}
- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [_character stopActionByTag:11];
    [_character stopActionByTag:12];
    [_character stopActionByTag:13];

    
}

-(void) stopActionByTag:(NSInteger)tag {
    [_character stopActionByTag:tag];
    
    
}

- (void)launchbullet {
    
   // [self bullet];
    CCNode* bullet = [CCBReader load:@"bullet"];
    bullet.position = ccpAdd(_character.position, ccp(0, 0));
    [_physicsNode addChild:bullet];
    bullet.physicsBody.sensor=true;
    
    // manually create & apply a force to launch the bullet
    CGPoint launchDirection;
    if (_character.flipX) {
        launchDirection = ccp(-1, 0);
    }
    else
        launchDirection = ccp(1, 0);
    
    CGPoint force = ccpMult(launchDirection, 7000);
    [bullet.physicsBody applyForce:force];
    
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair bullet:(CCNode *)bullet ground:(CCNode *)ground
{
    
    [ground removeFromParent];

    [bullet removeFromParent];
    return FALSE;
}

//-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero saloum:(CCNode *)saloum
//{
//    
//    [_character.physicsBody applyImpulse:ccp(0, 1800.f)];
//
//    return FALSE;
//}
//
//-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero goal:(CCNode *)goal {
//    
//    _character.position  = _ground1.position ;
//    
//    return FALSE;
//}
//
//-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero goal2:(CCNode *)goal2 {
//    
//    _character.position  = _ground2.position ;
//    
//    return FALSE;
//}
//
//-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero goal3:(CCNode *)goal3 {
//    
//    _character.position  = _ground3.position ;
//    
//    return FALSE;
//}


@end
