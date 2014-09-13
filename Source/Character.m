//
//  Character.m
//  GameArchitecture
//
//  Created by yahya on 9/10/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Character.h"

@implementation Character
{
    
    CCSprite *_character;
    BOOL _jumped;
    float timerTillJump;

}



-(void) jump
{
    NSLog(@"jump");
    if (!_jumped) {
       [_character.physicsBody applyImpulse:ccp(0,4900)];
        _jumped = TRUE;
        [self performSelector:@selector(resetJump) withObject:nil afterDelay:1.2f];
    }
    
}


- (void)resetJump {
    _jumped = FALSE;
}
@end
