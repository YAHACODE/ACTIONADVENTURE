//
//  WinPopup.m
//  GameArchitecture
//
//  Created by Yahia Bouhlel on 10/06/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "WinPopup.h"

@implementation WinPopup

- (void)loadNextLevel {
  CCScene *nextLevel = [CCBReader loadAsScene:self.nextLevelName];
  CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
  [[CCDirector sharedDirector] presentScene:nextLevel withTransition:transition];
}

@end
