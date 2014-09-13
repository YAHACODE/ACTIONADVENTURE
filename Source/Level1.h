//
//  Level1.h
//  GameArchitecture
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Character.h"
#import "bullet.h"

@interface Level1 : CCNode <CCPhysicsCollisionDelegate>

@property(nonatomic,readwrite) BOOL flipX;
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event;


@end
