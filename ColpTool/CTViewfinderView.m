//
//  CTViewfinderView.m
//  ColpTool
//
//  Created by Alda Luong on 10/8/14.
//  Copyright (c) 2014 Alda Luong. All rights reserved.
//

#import "CTViewfinderView.h"
#import "CTImports.h"

static NSString *const kGridSwitchLabel = @"grid";
static NSString *const kFilterSwitchLabel = @"filter";
static NSString *const kFlashButtonOffImage = @"flash-off.png";
static NSString *const kFlashButtonOnImage = @"flash-on.png";
static NSString *const kGridImage = @"ClockGrid.png";
static NSString *const kVideoSwitchLabel = @"video";

static const CGFloat kToolBarHeight = 20.0;
//static const CGFloat kToolBarButtonWidth = 20.0;

static const NSInteger kToolBarGridIndex = 0;
static const NSInteger kToolBarFilterIndex = 1;
static const NSInteger kToolBarPhotoIndex = 2;
static const NSInteger kToolBarVideoIndex = 3;
static const NSInteger kToolBarFlashIndex = 4;

@interface CTViewfinderView()

@property (nonatomic, strong) CTFilterCamera *camera;
@property (nonatomic, strong) UISwitch *gridSwitch;
@property (nonatomic, strong) UILabel *gridSwitchLabel;
@property (nonatomic, assign) BOOL gridOn;
@property (nonatomic, strong) UISwitch *filterSwitch;
@property (nonatomic, strong) UILabel *filterSwitchLabel;
@property (nonatomic, strong) UIButton *flashModeButton;
@property (nonatomic, strong) UIImageView *grid;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UISwitch *videoSwitch;
@property (nonatomic, strong) UILabel *videoSwitchLabel;
@end

@implementation CTViewfinderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        self.camera = [CTSharedServiceLocator sharedServiceLocator].filterCamera;
        self.backgroundColor  = [UIColor clearColor];
        
        /*
        [self addSubview:self.gridSwitch];
        [self addSubview:self.gridSwitchLabel];
        [self addSubview:self.filterSwitch];
        [self addSubview:self.filterSwitchLabel];
        [self addSubview:self.flashModeButton];
        */
        
        [self addSubview:self.videoSwitch];
        [self addSubview:self.videoSwitchLabel];
        
        [self addSubview:self.toolBar];
        self.gridOn = NO;
    }
    return self;
}

- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        CGRect frame = (CGRect) {
            .origin.x = CGRectGetMinX(self.bounds),
            .origin.y = CGRectGetMaxY(self.bounds) - kToolBarHeight,
            .size = (CGSize) {self.bounds.size.width, kToolBarHeight}
        };
        
        UIBarButtonItem *gridItem = [[UIBarButtonItem alloc]
                                        initWithTitle:@"Grid" style:UIBarButtonItemStylePlain
                                        target:self action:@selector(didFlipGridSwitch:)];
        UIBarButtonItem *filterItem = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Filter" style:UIBarButtonItemStylePlain
                                     target:self action:@selector(didFlipFilterSwitch:)];
        UIBarButtonItem *photoItem = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Photo" style:UIBarButtonItemStylePlain
                                     target:self action:@selector(takePhoto:)];
        UIBarButtonItem *videoItem = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Record" style:UIBarButtonItemStylePlain
                                     target:self action:@selector(toggleRecord:)];
        UIBarButtonItem *flashItem = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Flash" style:UIBarButtonItemStylePlain
                                      target:self action:@selector(didTouchUpInsideFlashModeButton:)];
        
        NSArray *buttonItems = @[gridItem, filterItem, photoItem, videoItem, flashItem];
        
        _toolBar = [[UIToolbar alloc] initWithFrame:frame];
        [_toolBar setBarStyle:UIBarStyleBlackOpaque];
        [_toolBar setItems:buttonItems];
        
    }
    return _toolBar;
}

-(UIButton *)flashModeButton
{
    if (_flashModeButton == nil) {
        CGRect frame = (CGRect) {
            .origin.x = 20.f,
            .origin.y = 23.f,
            .size = (CGSize){75.f, 35.f}
        };
        
        _flashModeButton = [[UIButton alloc] initWithFrame:frame];
        [_flashModeButton setImage:[UIImage imageNamed:kFlashButtonOffImage] forState:UIControlStateNormal];
        [_flashModeButton addTarget:self action:@selector(didTouchUpInsideFlashModeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashModeButton;
}

-(UISwitch *)gridSwitch
{
    if (_gridSwitch == nil) {
        CGRect frame = (CGRect) {
            .origin.x = 138.f,
            .origin.y = 23.f,
            .size = (CGSize){40.f, 40.f}
        };
        
        _gridSwitch = [[UISwitch alloc] initWithFrame:frame];
        [_gridSwitch addTarget:self action:@selector(didFlipGridSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _gridSwitch;
}

-(UILabel *)gridSwitchLabel
{
    if (_gridSwitchLabel == nil) {
        CGRect frame = (CGRect) {
            .origin.x = 145.f,
            .origin.y = 54.f,
            .size = (CGSize){40.f, 15.f}
        };
        
        _gridSwitchLabel = [[UILabel alloc] initWithFrame:frame];
        _gridSwitchLabel.font = [_gridSwitchLabel.font fontWithSize:12.0];
        _gridSwitchLabel.text = kGridSwitchLabel;
        _gridSwitchLabel.textColor = [UIColor blackColor];
        _gridSwitchLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _gridSwitchLabel;
}

-(UISwitch *)filterSwitch
{
    if (_filterSwitch == nil) {
        CGRect frame = (CGRect) {
            .origin.x = 240.f,
            .origin.y = 23.f,
            .size = (CGSize){44.f, 35.f}
        };
        
        _filterSwitch = [[UISwitch alloc] initWithFrame:frame];
        [_filterSwitch addTarget:self action:@selector(didFlipFilterSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _filterSwitch;
}

-(UILabel *)filterSwitchLabel
{
    if (_filterSwitchLabel == nil) {
        CGRect frame = (CGRect) {
            .origin.x = 247.f,
            .origin.y = 54.f,
            .size = (CGSize){40.f, 15.f}
        };
        
        _filterSwitchLabel = [[UILabel alloc] initWithFrame:frame];
         _filterSwitchLabel.font = [_filterSwitchLabel.font fontWithSize:12.0];
        _filterSwitchLabel.text = kFilterSwitchLabel;
        _filterSwitchLabel.textColor = [UIColor blackColor];
        _filterSwitchLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _filterSwitchLabel;
}

-(UIImageView *)grid
{
    if (_grid == nil) {
        CGRect frame = (CGRect) {
            .origin.x = 2.f,
            .origin.y = 125.f,
            .size = (CGSize){310.f, 310.f}
        };
        UIImage *gridImage = [UIImage imageNamed:kGridImage];
        _grid = [[UIImageView alloc] initWithFrame:frame];
        _grid.image = gridImage;
    }
    return _grid;
}

-(UISwitch *)videoSwitch
{
    if (_videoSwitch == nil) {
        CGRect frame = (CGRect) {
            .origin.x = 240.f,
            .origin.y = 23.f,
            .size = (CGSize){44.f, 35.f}
        };
        
        _videoSwitch = [[UISwitch alloc] initWithFrame:frame];
        [_videoSwitch addTarget:self action:@selector(didFlipVideoSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _videoSwitch;
}

-(UILabel *)videoSwitchLabel
{
    if (_filterSwitchLabel == nil) {
        CGRect frame = (CGRect) {
            .origin.x = 247.f,
            .origin.y = 54.f,
            .size = (CGSize){40.f, 15.f}
        };
        
        _filterSwitchLabel = [[UILabel alloc] initWithFrame:frame];
        _filterSwitchLabel.font = [_filterSwitchLabel.font fontWithSize:12.0];
        _filterSwitchLabel.text = kVideoSwitchLabel;
        _filterSwitchLabel.textColor = [UIColor blackColor];
        _filterSwitchLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _filterSwitchLabel;
}

#pragma mark - Button & Switch Actions
- (void)didTouchUpInsideFlashModeButton:(id)sender
{
    if (sender == self.toolBar.items[kToolBarFlashIndex]) {
        if (self.flashModeToggleActionBlock != nil) {
            BOOL flashOn = [self.camera torchIsOn];
            if (flashOn == YES) {
                [self.flashModeButton setImage:[UIImage imageNamed:kFlashButtonOnImage] forState:UIControlStateNormal];
            } else {
                [self.flashModeButton setImage:[UIImage imageNamed:kFlashButtonOffImage] forState:UIControlStateNormal];
            }
            self.flashModeToggleActionBlock(flashOn);
        }
    }
}

-(void)didFlipGridSwitch:(id)sender
{
    if (sender == self.toolBar.items[kToolBarGridIndex]) {
        self.gridOn = !self.gridOn;
        
        if (self.gridOn == YES) {
            [self addSubview:self.grid];
        } else {
            [self.grid removeFromSuperview];
            self.grid = nil;
        }
    }
}

-(void)didFlipFilterSwitch:(id)sender
{
    if (sender == self.toolBar.items[kToolBarFilterIndex]) {
        if (self.filterToggleActionBlock) {
            self.filterToggleActionBlock();
        }
    }
}

-(void)didFlipVideoSwitch:(id)sender
{
    if (sender == self.videoSwitch) {
        if (self.toggleVideoActionBlock) {
            self.toggleVideoActionBlock(self.videoSwitch.on);
        }
    }
}

-(void)takePhoto:(id)sender
{
    if (sender == self.toolBar.items[kToolBarPhotoIndex]) {
        if (self.takePhotoActionBlock) {
            self.takePhotoActionBlock();
        }
    }
}

-(void)toggleRecord:(id)sender
{
    if (sender == self.toolBar.items[kToolBarVideoIndex]) {
        if (self.toggleRecordActionBlock) {
            self.toggleRecordActionBlock();
        }
    }
    
    NSString *barButtonTitle = self.camera.recording ? @"Recording" : @"Record";
    ((UIBarButtonItem *)(self.toolBar.items[kToolBarVideoIndex])).title = barButtonTitle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
