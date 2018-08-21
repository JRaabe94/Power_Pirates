//
//  ShipWelcomeScene.m
//  Power_Pirates
//
//  Created by Codecamp on 21.08.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ShipWelcomeScene.h"
#import "ShipGameScene.h"

@interface ShipWelcomeScene()

@property bool sceneCreated;

@end

@implementation ShipWelcomeScene

- (void) didMoveToView:(SKView *)view {
    if (!self.sceneCreated)
    {
        // create Welcome Screen for the game
        SKSpriteNode *backgroundImage = [[SKSpriteNode alloc] initWithImageNamed:@"ShipMinigameBackground"];
        backgroundImage.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:backgroundImage];
        
        self.scaleMode = SKSceneScaleModeAspectFill;
        [self addChild: [self createWelcomeNode]];
        self.sceneCreated = YES;
    }
}

- (SKLabelNode *) createWelcomeNode {
    SKLabelNode *welcomeNode =
    [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
    
    welcomeNode.name = @"welcomeNode";
    welcomeNode.text = @"ShipMinigame - Tap Screen to Play";
    welcomeNode.fontSize = 25;
    welcomeNode.fontColor = [SKColor whiteColor];
    
    welcomeNode.position =
    CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    return welcomeNode;
}

// changes to the actual gameScene when screen is tapped
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKNode *welcomeNode = [self childNodeWithName:@"welcomeNode"];
    
    if (welcomeNode != nil)
    {
        SKAction *fadeAway = [SKAction fadeOutWithDuration:1.0];
        
        [welcomeNode runAction:fadeAway completion:^{
            SKScene *shipGameScene =
            [[ShipGameScene alloc]initWithSize:self.size];
            
            SKTransition *doors =
            [SKTransition doorwayWithDuration:1.0];
            
            [self.view presentScene:shipGameScene transition:doors];
        }
         ];
    }
}

@end
