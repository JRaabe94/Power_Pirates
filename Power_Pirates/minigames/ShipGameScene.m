//
//  ShipGameScene.m
//  Power_Pirates
//
//  Created by Codecamp on 21.08.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ShipGameScene.h"
#import "ShipWelcomeScene.h"
#import "Storage.h"
#import "TypeDef.h"

@interface ShipGameScene()

@property BOOL sceneCreated;
@property int objectCount;
@property int goldCount;
@property int score;
@property int shipSpeed;
@property float objectSpeed;

@property NSMutableArray *movingObjects;
@property Storage *storage;

@end

@implementation ShipGameScene

static const uint32_t shipCategory = 0x1 << 0;
static const uint32_t enemyCategory = 0x1 << 1;
static const uint32_t goldCategory = 0x1 << 2;

- (void)didMoveToView:(SKView *)view {
    if (!self.sceneCreated)
    {
        self.score = 0;
        self.objectCount = 25;
        self.goldCount = 3;
        self.shipSpeed = 0;
        self.objectSpeed = 5;
        
        _movingObjects = [[NSMutableArray alloc] init];
        _storage = [[Storage alloc] init];
        [_storage loadData];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0); // unable Gravity so objects dont just fall down
        self.physicsWorld.contactDelegate = self;
        
        [self initShipGameScene];
        self.sceneCreated = YES;
    }
}

- (void) update:(NSTimeInterval)currentTime {
    
    _objectSpeed += 0.03;
    
    // move ship
    SKNode *shipNode = [self childNodeWithName:@"shipNode"];
    if(shipNode.position.x > self.frame.origin.x && shipNode.position.x < self.frame.size.width) {
        // so ship stops at left/right border
        shipNode.position = CGPointMake(shipNode.position.x + _shipSpeed, shipNode.position.y);
    }
    // so the ship doesnt get stuck on either side
    else if(shipNode.position.x < self.frame.origin.x) {
        shipNode.position = CGPointMake(shipNode.position.x + 5, shipNode.position.y);
    }
    else if(shipNode.position.x > self.frame.size.width) {
        shipNode.position = CGPointMake(shipNode.position.x - 5, shipNode.position.y);
    }
    
    // move objects spawning from top
    for (int i = 0; i < _movingObjects.count; i++) {
        SKSpriteNode *object = (SKSpriteNode*) _movingObjects[i];
        object.position = CGPointMake(object.position.x, object.position.y - _objectSpeed);
        
        if(object.position.y > self.frame.size.height) { // objects out of screen can be removed
            [_movingObjects removeObjectAtIndex:i];
            [_movingObjects[i] removeFromParent];
        }
    }
}

- (void) initShipGameScene {
    SKSpriteNode *backgroundImage = [[SKSpriteNode alloc] initWithImageNamed:@"ShipMinigameIngameBackground"];
    backgroundImage.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addChild:backgroundImage];
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    // create left and right Button
    [self createMoveButtons];
    
    // create player/ship
    SKSpriteNode *shipNode = [self createShipNode];
    [self addChild:shipNode];

    // spawn objects at top screen
    SKAction *spawnObjects = [SKAction sequence:@[[SKAction performSelector:@selector(createIncomingObject) onTarget:self], [SKAction waitForDuration:1]]];
    
    [self runAction: [SKAction repeatAction:spawnObjects count:self.objectCount]
            completion:^{ [self wonGameOver]; }];
    
    SKAction *spawnGold = [SKAction sequence:@[[SKAction performSelector:@selector(createGold) onTarget:self], [SKAction waitForDuration:5]]];
    
    [self runAction: [SKAction repeatAction:spawnGold count:self.goldCount]];
}

//****************** Gameobject-Creation Methods ******************
- (SKSpriteNode *)createShipNode {
    SKSpriteNode *shipNode =
    [[SKSpriteNode alloc] initWithImageNamed:@"ShipGameBoat.png"];
    
    shipNode.name = @"shipNode";
    shipNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + 50);
    
    // for collisions
    shipNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:shipNode.frame.size];
    shipNode.physicsBody.usesPreciseCollisionDetection = YES;
    shipNode.physicsBody.categoryBitMask = shipCategory;
    shipNode.physicsBody.collisionBitMask = shipCategory | enemyCategory;
    shipNode.physicsBody.contactTestBitMask = shipCategory | enemyCategory;
    
    return shipNode;
}

- (void) createIncomingObject {
    SKSpriteNode *incomingObject;
    
    // choose randomly between images
    int randomImage = arc4random_uniform(2);
    switch (randomImage) {
        case 0:
            incomingObject = [[SKSpriteNode alloc] initWithImageNamed:@"Seamonster.png"];
            break;
            
        case 1:
            incomingObject = [[SKSpriteNode alloc] initWithImageNamed:@"Island_Minigame.png"];
            break;
        default:
            break;
    }
    
    int randomX = arc4random_uniform(self.size.width);
    incomingObject.position = CGPointMake(randomX, self.size.height - 75);
    
    incomingObject.name = @"incomingNode";
    
    incomingObject.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:incomingObject.frame.size];
    incomingObject.physicsBody.usesPreciseCollisionDetection = YES;
    incomingObject.physicsBody.categoryBitMask = enemyCategory;
    
    [_movingObjects addObject:incomingObject];
    
    [self addChild:incomingObject];
}

- (void) createGold {
    SKSpriteNode *goldObject = [[SKSpriteNode alloc] initWithImageNamed:@"Goldcoin.png"];;
    
    int randomX = arc4random_uniform(self.size.width);
    goldObject.position = CGPointMake(randomX, self.size.height - 75);
    
    goldObject.name = @"goldNode";
    
    goldObject.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:goldObject.frame.size];
    goldObject.physicsBody.usesPreciseCollisionDetection = YES;
    goldObject.physicsBody.categoryBitMask = goldCategory;
    goldObject.physicsBody.collisionBitMask = shipCategory | goldCategory;
    goldObject.physicsBody.contactTestBitMask = shipCategory | goldCategory;
    
    [_movingObjects addObject:goldObject];
    
    [self addChild:goldObject];
}

- (void) createMoveButtons {
    SKSpriteNode *leftButton = [[SKSpriteNode alloc] initWithImageNamed:@"ButtonLeft.png"];
    SKSpriteNode *rightButton = [[SKSpriteNode alloc] initWithImageNamed:@"ButtonRight.png"];
    
    leftButton.position = CGPointMake(CGRectGetMinX(self.frame) + 100
                                      , CGRectGetMinY(self.frame) + 100);
    leftButton.name = @"leftButton";
    
    rightButton.position = CGPointMake(CGRectGetMaxX(self.frame) - 100
                                      , CGRectGetMinY(self.frame) + 100);
    rightButton.name = @"rightButton";
    
    [self addChild:leftButton];
    [self addChild:rightButton];
}

//****************** handle touches ******************
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    // if buttonsTouched change speed of ship
    if ([node.name isEqualToString:@"leftButton"]) {
        _shipSpeed = -5;
    }
    else if ([node.name isEqualToString:@"rightButton"]) {
        _shipSpeed = 5;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _shipSpeed = 0;
}

//****************** handle collisions ******************
- (void) didBeginContact:(SKPhysicsContact *)contact {
    SKSpriteNode *firstNode, *secondNode;
    
    firstNode = (SKSpriteNode *)contact.bodyA.node;
    secondNode = (SKSpriteNode *) contact.bodyB.node;
    
    // collision with island/monster
    if ( ( (contact.bodyA.categoryBitMask == shipCategory) && (contact.bodyB.categoryBitMask == enemyCategory) )
        || ( (contact.bodyA.categoryBitMask == enemyCategory) && (contact.bodyB.categoryBitMask == shipCategory) )) {
        [self crashGameOver];
    }
    // collision with gold
    else if ( ( (contact.bodyA.categoryBitMask == shipCategory) && (contact.bodyB.categoryBitMask == goldCategory) )
            || ( (contact.bodyA.categoryBitMask == goldCategory) && (contact.bodyB.categoryBitMask == shipCategory) )) {
        
        [_storage give:MONEY];
        
        // look which node was the gold object and remove that one
        if( firstNode.physicsBody.categoryBitMask == goldCategory) {
            [_movingObjects removeObject:firstNode];
            [firstNode removeFromParent];
        } else {
            [_movingObjects removeObject:secondNode];
            [secondNode removeFromParent];
        }
    }
}

//****************** Game Over ******************
- (void) crashGameOver {
    SKAction *welcomeReturn = [SKAction runBlock:^{
        
        SKTransition *transition =
        [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        
        ShipWelcomeScene *shipWelcomeScene = [[ShipWelcomeScene alloc] initWithSize:self.size];
        
        [self.scene.view presentScene: shipWelcomeScene transition:transition];
    }];
    
    SKAction *sequence = [SKAction sequence:@[welcomeReturn]];
    
    [self runAction:sequence];
}

- (void) wonGameOver {
    
    SKAction *fadeOut = [SKAction sequence:@[[SKAction waitForDuration:3.0],
                                          [SKAction fadeOutWithDuration:3.0]]];
    
    SKAction *welcomeReturn = [SKAction runBlock:^{
        
        SKTransition *transition =
        [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        
        ShipWelcomeScene *shipWelcomeScene = [[ShipWelcomeScene alloc] initWithSize:self.size];
        
        [self.scene.view presentScene: shipWelcomeScene transition:transition];
    }];
    
    SKAction *sequence = [SKAction sequence:@[fadeOut, welcomeReturn]];
    
    [self runAction:sequence];
}


@end
