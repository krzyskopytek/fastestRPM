//
//  ViewController.m
//  fastestRPM
//
//  Created by Krzysztof Kopytek on 2016-05-12.
//  Copyright © 2016 Krzysztof Kopytek. All rights reserved.
//

#import "ViewController.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define MIN_DEGREES      -135.0
#define MAX_DEGREES      135.0
#define RANGE_DEGREES    (MAX_DEGREES - MIN_DEGREES)

#define LIMIT_VELOCITY           7500.0 // Points per second
#define LIMIT_VELOCITY_DELTA 10.0 // Points per second

#define RESET_DELAY      0.1 // Seconds
#define VELOCITY_DELAY   0.1 // Seconds

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *needleImageView;
@property float maxVelocity;
@property float currVelocity;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.needleImageView.transform = CGAffineTransformMakeRotation(RADIANS(135));
    
    UIPanGestureRecognizer *movement = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(weMoved:)];
    [self.view addGestureRecognizer:movement];
    
}

-(void) weMoved:(id)sender {

    CGPoint componentVelocity = [sender velocityInView:self.view];
    CGFloat velocity = sqrt(pow(componentVelocity.x, 2) + pow(componentVelocity.y, 2));
    NSLog(@"%f", velocity);
    [self moveNeedleWithVelocity:velocity];
    
    
}

- (void)moveNeedleWithVelocity:(CGFloat)velocity {
    
    self.currVelocity = velocity;
    
    // Calculate velocity of pan motion
    self.maxVelocity = MAX(self.maxVelocity, velocity);
    
    // Calculate proportion of current velocity to velocity limit
    CGFloat velocityProportion = velocity / LIMIT_VELOCITY;
    
    // Calculate proportion of RPM needle degree range
    CGFloat degrees = MIN(RANGE_DEGREES * velocityProportion, RANGE_DEGREES);
    
    // Move needle in degree range proportionate to velocity
//    self.needleImageView.transform = CGAffineTransformRotate(self.minRotationTransform, RADIANS(degrees));
    self.needleImageView.transform = CGAffineTransformMakeRotation(RADIANS(degrees));
}





@end
