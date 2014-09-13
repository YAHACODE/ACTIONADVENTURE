//
//  levelselect.m
//  GameArchitecture
//
//  Created by yahya on 9/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "levelselect.h"

@implementation levelselect




- (void)back {
    CCScene *StartScene = [CCBReader loadAsScene:@"StartScene"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:StartScene withTransition:transition];
}

@end
 