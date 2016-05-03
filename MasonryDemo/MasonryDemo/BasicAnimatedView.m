//
//  BasicAnimatedView.m
//  MasonryDemo
//
//  Created by Mr.LuDashi on 16/5/3.
//  Copyright © 2016年 zeluli. All rights reserved.
//

#import "BasicAnimatedView.h"

@interface BasicAnimatedView()

@property (nonatomic, strong) NSMutableArray *animatableConstraints;
@property (nonatomic, assign) int padding;
@property (nonatomic, assign) BOOL animating;

@end

@implementation BasicAnimatedView
-(instancetype)init {
    self = [super init];
    [self addView];
    return self;
}

- (void)addView {
    UIView *greenView = [UIView new];
    greenView.backgroundColor = [UIColor greenColor];
    greenView.layer.borderWidth = 2;
    greenView.layer.borderColor = [[UIColor blackColor] CGColor];
    [self addSubview:greenView];
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    redView.layer.borderWidth = 2;
    redView.layer.borderColor = [[UIColor blackColor] CGColor];
    [self addSubview:redView];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.layer.borderWidth = 2;
    blueView.layer.borderColor = [[UIColor blackColor] CGColor];
    [self addSubview:blueView];
    
    UIView *superview = self;
    self.padding = 10;
    UIEdgeInsets insets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
    self.animatableConstraints = NSMutableArray.new;
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
              make.edges.equalTo(superview).insets(insets).priorityLow(), //先设置默认值，等级比较低
              make.bottom.equalTo(blueView.mas_top).offset(-self.padding)
        ]];
        
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
             make.edges.equalTo(superview).insets(insets).priorityLow(),
             make.bottom.equalTo(blueView.mas_top).offset(-self.padding),
             make.left.equalTo(greenView.mas_right).offset(self.padding)
        ]];
        make.size.equalTo(greenView);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.animatableConstraints addObjectsFromArray:@[
            make.edges.equalTo(superview).insets(insets).priorityLow()
        ]];
        make.height.equalTo(@[redView, greenView]);
    }];
}

- (void)didMoveToWindow {
    [self layoutIfNeeded];
    
    if (self.window) {
        self.animating = YES;
        [self animateWithInvertedInsets:NO];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    self.animating = newWindow != nil;
}

- (void)animateWithInvertedInsets:(BOOL)invertedInsets {
    if (!self.animating) return;
    
    int padding = invertedInsets ? 100 : self.padding;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    for (MASConstraint *constraint in self.animatableConstraints) {
        constraint.insets = paddingInsets;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        //repeat!
        [self animateWithInvertedInsets:!invertedInsets];
    }];
}



@end
