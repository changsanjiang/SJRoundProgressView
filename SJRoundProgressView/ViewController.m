//
//  ViewController.m
//  SJRoundProgressView
//
//  Created by BlueDancer on 2017/11/2.
//  Copyright © 2017年 lanwuzhe. All rights reserved.
//

#import "ViewController.h"
#import "SJRoundProgressView.h"
#import "TmpView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic, strong) SJRoundProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slider addTarget:self action:@selector(slide) forControlEvents:UIControlEventValueChanged];

    _progressView = [SJRoundProgressView new];
    _progressView.center = self.view.center;
    _progressView.backgroundColor = [UIColor blackColor];
    _progressView.bounds = CGRectMake(0, 0, 300, 300);
    _progressView.layer.cornerRadius = 150;
    _progressView.clipsToBounds = YES;
//    _progressView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.view addSubview:_progressView];
    [self slide];
    
    TmpView *tmpView = [TmpView new];
    tmpView.backgroundColor = [UIColor lightTextColor];
    tmpView.bounds = CGRectMake(0, 0, 150, 150);
    tmpView.layer.cornerRadius = tmpView.frame.size.width * 0.5;
    tmpView.center = _progressView.center;
    [self.view addSubview:tmpView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)slide {
    _progressView.progress = _slider.value;
}

@end
