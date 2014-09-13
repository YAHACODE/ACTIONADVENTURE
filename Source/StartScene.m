//
//  StartScene.m
//  GameArchitecture
//
//  Created by YAHIA BOUHLEL on 10/06/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "StartScene.h"

@implementation StartScene

- (void)startGame {
  CCScene *firstLevel = [CCBReader loadAsScene:@"Level1"];
  CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
  [[CCDirector sharedDirector] presentScene:firstLevel withTransition:transition];
}


- (void)level {
    CCScene *levelselect = [CCBReader loadAsScene:@"levelselect"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:levelselect withTransition:transition];
}


                            
@end
