//
//  KLPickerView.m
//  CloudMoney
//
//  Created by nice on 16/9/18.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "KLPickerView.h"
static CGFloat row_height = 30;
@interface KLPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
/*UIPickerView*/
@property (nonatomic, strong) UIPickerView * pickerView;

@property (nonatomic, strong) UIToolbar * pickerToolbar;
/*确定按钮*/
@property (nonatomic, strong) UIBarButtonItem * doneBtn;
@property (nonatomic, strong) UIWindow * window;
/*背景*/
@property (nonatomic, strong) UIView * bgView;
/*省、直辖市*/
@property (nonatomic, strong) NSArray * provinces;
/*城市*/
@property (nonatomic, strong) NSArray * citys;
/*县*/
@property (nonatomic, strong) NSArray * counties;
/*省*/
@property (nonatomic, copy) NSString * state;
/*城市*/
@property (nonatomic, copy) NSString * city;
/*县*/
@property (nonatomic, copy) NSString * county;

/**
 *  数据模型
 */
@property (nonatomic,strong)ChinaArea *chinaModel;
/**
 *  选择的省份ID
 */
@property (nonatomic,strong)NSString *selectedProvinceID;
/**
 *  选择的城市ID
 */
@property (nonatomic,strong)NSString *selectedCityID;
/**
 *  选择的区域ID
 */
@property (nonatomic,strong)NSString *selectedAreaID;
@end

@implementation KLPickerView

- (instancetype)init {
    if (self = [super init]) {
        [self commandUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commandUI];
    }
    return self;
}

- (instancetype)initWithType:(kLPickerType)type {
    if (self = [super init]) {
        self.pickType = type;
        if (type == kLSecondType) {
            self.provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
            self.citys = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
            _city = [_citys objectAtIndex:0];
        } else {
            // 模型的初始化
            self.chinaModel = [[ChinaArea alloc] init];
            
            // 默认
            self.selectedProvinceID = @"2";  // 北京市
            self.selectedCityID = @"52";     // 北京市
            self.selectedAreaID = @"500";    // 东城区
            self.chinaModel.provinceModel = ((ProvinceModel *)[self.chinaModel getProvinceDataByID:self.selectedProvinceID]);
            self.chinaModel.cityModel = ((CityModel *)[self.chinaModel getCityDataByID:self.selectedCityID]);
            self.chinaModel.areaModel = ((AreaModel *)[self.chinaModel getAreaDataByID:self.selectedAreaID]);
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }
        _state = [[_provinces objectAtIndex:0] objectForKey:@"state"];
        [self.pickerView selectRow:0 inComponent:0 animated:YES];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];

    }
    return self;
}

- (void)commandUI {
    @weakity(self);
    [self removeFromSuperview];
    [self.bgView removeFromSuperview];
    [self.window addSubview:self.bgView];
    self.bgView.frame = self.window.bounds;
    [self.window addSubview:self];
    [self remakeConstraints:^(MASConstraintMaker *make) {
        @strongity(self);
        make.left.equalTo(self.window);
        make.height.equalTo(297);
        make.bottom.equalTo(self.window).offset(297);
        make.width.equalTo(ScreenWidth);
    }];
    [self.window layoutIfNeeded];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.bgView addGestureRecognizer:tapGesture];
    
    [self.pickerView removeFromSuperview];
    [self.pickerToolbar removeFromSuperview];
    [self addSubview:self.pickerToolbar];
    [self addSubview:self.pickerView];
    [self.pickerToolbar remakeConstraints:^(MASConstraintMaker *make) {
        @strongity(self);
        make.left.top.right.equalTo(self);
        make.width.equalTo(ScreenWidth);
        make.height.equalTo(44);
    }];
    
    [self.pickerView remakeConstraints:^(MASConstraintMaker *make) {
        @strongity(self);
        make.top.equalTo(self.pickerToolbar.bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
}

- (void)setPickType:(kLPickerType)pickType {
    _pickType = pickType;
}

#pragma -mark --UIPickerView Delegate && DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_pickType == kLSecondType) {
        return 2;
    } else if (_pickType == kLThirdType) {
        return 3;
    }
    return 0;
}
/**
 *  设置每一列显示的数量
 *
 *  @param pickerView pickerView description
 *  @param component  列
 *
 *  @return 美列的数量
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_pickType == kLSecondType) {
        switch (component) {
            case 0:
                return _provinces.count;
                break;
            case 1:
                return _citys.count;
                break;
            default:
                return 0;
                break;
        }
    }else {
        switch (component) {
            case 0:
                return [self.chinaModel getAllProvinceData].count;
                break;
            case 1:
                return [self.chinaModel getCityDataByParentID:self.selectedProvinceID].count;
                break;
            case 2:
                return [self.chinaModel getAreaDataByParentID:self.selectedCityID].count;
            default:
                return 0;
                break;
        }
    }
    
}
/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (_pickType == kLThirdType) {
        switch (component) {
            case 0:
                return [[_provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [[_citys objectAtIndex:row] objectForKey:@"city"];
                break;
            case 2:
                if (_counties > 0) {
                    return [_counties objectAtIndex:row];
                    break;
                }
            default:
                return @"";
                break;
        }
    } else {
        switch (component) {
            case 0:
                return [[_provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [_citys objectAtIndex:row];
            default:
                return @"";
                break;
        }
    }
}
*/
/**
 *  设置每一列的宽度
 *
 *  @param pickerView pickerView description
 *  @param component  列
 *
 *  @return 每列的宽度
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//    if (_pickType == kLSecondType) {
//        return (SCREEN_WIDTH - 20) / 2;
//    }
    return (ScreenWidth - 20)/3;
}

/**
 *  设置每一行的高度
 *
 *  @param pickerView pickerView description
 *  @param component  列
 *
 *  @return 每一行的高度
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return row_height;
}
/**
 *  设置每一行的显示视图
 *
 *  @param pickerView pickerView description
 *  @param row        每一类的row
 *  @param component  列
 *  @param view       view description
 *
 *  @return 每一列每一行的视图
 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (component == 0) { // 省份
        if (!view) {
            view = [[UIView alloc] init];
        }
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(0, 0, (ScreenWidth - 20)/3, row_height);
        textLabel.textAlignment = NSTextAlignmentCenter;
        if (_pickType == kLSecondType) {
            textLabel.text = _provinces[row][@"state"];
        } else {
           textLabel.text = ((ProvinceModel *)[self.chinaModel getAllProvinceData][row]).NAME;
        }
        textLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:textLabel];
        return view;
    }
    else if (component == 1){ // 城市
        if (!view) {
            view = [[UIView alloc] init];
        }
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(0, 0, (ScreenWidth - 20)/3, row_height);
        textLabel.textAlignment = NSTextAlignmentCenter;
        if (_pickType == kLSecondType) {
            textLabel.text = _citys[row];
        } else {
            textLabel.text = ((CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][row]).NAME;
        }
        
        textLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:textLabel];
        return view;
    }
    else{ // 区域
        if (!view) {
            view = [[UIView alloc] init];
        }
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(0, 0, (ScreenWidth - 20)/3, row_height);
        textLabel.textAlignment = NSTextAlignmentCenter;
        if (_pickType == kLSecondType) {
            textLabel.text = @"";
        } else {
            textLabel.text = ((AreaModel *)[self.chinaModel getAreaDataByParentID:self.selectedCityID][row]).NAME;
        }
        
        textLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:textLabel];
        return view;
    }
    
}
/**
 *  pickerView选中代理
 *
 *  @param pickerView pickerView description
 *  @param row        选中的row
 *  @param component  列
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.pickType == kLThirdType) {
        switch (component) {
            case 0:{ // 选择省份
                self.selectedProvinceID = ((ProvinceModel *)[self.chinaModel getAllProvinceData][row]).ID;
                [pickerView reloadComponent:1]; // 重载城市
                [pickerView selectRow:0 inComponent:1 animated:YES];
                self.chinaModel.provinceModel = (ProvinceModel *)[self.chinaModel getAllProvinceData][row];
                // 选择了省份就自动定位到该省的第一个市
                self.selectedCityID = ((CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][0]).ID;
                self.chinaModel.cityModel = (CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][0];
                
                // 选择了省份就自动定位到该省的第一个市的第一个区
                [pickerView  reloadComponent:2]; // 重载区域
                [pickerView selectRow:0 inComponent:2 animated:YES];
                // 海南 有的市没有区  真是坑啊
                if ([self.chinaModel getAreaDataByParentID:self.selectedCityID].count > 0) {
                    self.chinaModel.areaModel = (AreaModel *)[self.chinaModel getAreaDataByParentID:self.selectedCityID][0];
                }
                else{
                    self.chinaModel.areaModel.NAME = @"";
                    self.chinaModel.areaModel.ID = @"";
                    self.chinaModel.areaModel.PARENT_AREA_ID = @"9";
                    self.chinaModel.areaModel.GRADE = @"3";
                }
                break;
            }
            case 1:{ // 选择城市
                self.selectedCityID = ((CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][row]).ID;
                [pickerView  reloadComponent:2]; // 重载区域
                [pickerView selectRow:0 inComponent:2 animated:YES];
                self.chinaModel.cityModel = (CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][row];
                // 选择了市就定位到该市的第一个区
                // 海南 有的市没有区  真是坑啊
                if ([self.chinaModel getAreaDataByParentID:self.selectedCityID].count > 0) {
                    self.chinaModel.areaModel = (AreaModel *)[self.chinaModel getAreaDataByParentID:self.selectedCityID][0];
                }
                else{
                    self.chinaModel.areaModel.NAME = @"";
                    self.chinaModel.areaModel.ID = @"";
                    self.chinaModel.areaModel.PARENT_AREA_ID = @"9";
                    self.chinaModel.areaModel.GRADE = @"3";
                }
                
                break;
            }
            case 2: // 选择区域
                // 海南 有的市没有区  真是坑啊
                if ([self.chinaModel getAreaDataByParentID:self.selectedCityID].count > 0) {
                    self.chinaModel.areaModel = (AreaModel *)[self.chinaModel getAreaDataByParentID:self.selectedCityID][row];
                }
                else{
                    self.chinaModel.areaModel.NAME = @"";
                    self.chinaModel.areaModel.ID = @"";
                    self.chinaModel.areaModel.PARENT_AREA_ID = @"9";
                    self.chinaModel.areaModel.GRADE = @"3";
                }
                break;
            default:
                break;
        }
        _state = self.chinaModel.provinceModel.NAME;
        _city = self.chinaModel.cityModel.NAME;
        _county = self.chinaModel.areaModel.NAME;
    } else {
        switch (component) {
            case 0:
                _citys = [[_provinces objectAtIndex:row] objectForKey:@"cities"];
                [_pickerView selectRow:0 inComponent:1 animated:YES];
                [_pickerView reloadComponent:1];
                //第二遍刷新，不然会出现bug(显示的位置可能会不正确)
                [_pickerView selectRow:0 inComponent:1 animated:YES];
                [_pickerView reloadComponent:1];
                _state = [[_provinces objectAtIndex:row] objectForKey:@"state"];
                _city = [_citys objectAtIndex:0];
                break;
            case 1:
                _city = [_citys objectAtIndex:row];
            default:
                break;
        }
    }
}

#pragma  -mark -- BtnAction
- (void)toolBarBtnDone:(UIBarButtonItem *)sender {
    if (_selectAction) {
        NSString * address;
        if (_pickType == kLSecondType) {
            address = [NSString stringWithFormat:@"%@%@", _state, _city];
        } else {
            address = [NSString stringWithFormat:@"%@%@%@", _state, _city, _county];
        }
        _selectAction(address);
    }
    [self hidePickerView];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self hidePickerView];
}

#pragma -mark -- Public  Event
- (void)showPickerView {
    [self commandUI];
    @weakity(self);
    [self updateConstraints:^(MASConstraintMaker *make) {
        @strongity(self);
        make.bottom.equalTo(self.window);
    }];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.window layoutIfNeeded];
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidePickerView];
}

- (void)hidePickerView {
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.window).offset(297);
    }];

    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.superview layoutIfNeeded];
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.bgView removeFromSuperview];
    }];
}

- (void)dealloc
{
    DLog(@"KLPickerview dealloc");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma -mark -- get
- (UIWindow *)window {
    if (!_window) {
        _window  = [[UIApplication sharedApplication].windows firstObject];
    }
    return _window;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return _bgView;
}

- (UIToolbar *)pickerToolbar {
    if (!_pickerToolbar) {
        _pickerToolbar = [[UIToolbar alloc] init];
        _pickerToolbar.barStyle = UIBarStyleDefault;
        _pickerToolbar.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:0.1];
        UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        rightSpace.width = 15;
        [_pickerToolbar setItems:@[leftSpace, self.doneBtn, rightSpace] animated:YES];
    }
    return _pickerToolbar;
}

- (UIBarButtonItem *)doneBtn {
    if (!_doneBtn) {
        _doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(toolBarBtnDone:)];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#333333"], NSForegroundColorAttributeName,[UIFont systemFontOfSize:16], NSFontAttributeName, nil];
        [_doneBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    return _doneBtn;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

@end



@interface ChinaArea ()

@property (nonatomic,strong)FMDatabaseQueue *fmdbQueue;
@property (nonatomic,strong)FMDatabase *dataBase;
@property (nonatomic,copy)NSString *dbPath;
@end

@implementation ChinaArea

- (instancetype)init{
    if (self = [super init]) {
        [self initDataBase];
        //        [self creatProvinceTabel];
        //        [self creatCityTabel];
        //        [self creatAreaTabel];
    }
    return self;
}

/**
 *  初始化数据库
 */
- (void)initDataBase{
    self.dbPath=[[NSBundle mainBundle]pathForResource:@"china_citys_name.db" ofType:nil];
    self.fmdbQueue = [[FMDatabaseQueue alloc] initWithPath:self.dbPath];
    self.dataBase = [[FMDatabase alloc] initWithPath:self.dbPath];
}
/**
 *  创建省份表单
 */
- (void)creatProvinceTabel{
    [self.dataBase open];
    [self.dataBase executeUpdate:@"CREATE TABLE IF  NOT EXISTS Province (rowid INTEGER PRIMARY KEY AUTOINCREMENT, GRADE text,ID text,NAME text,PARENT_AREA_ID text)"];
    [self.dataBase close];
}
/**
 *  创建城市表单
 */
- (void)creatCityTabel{
    [self.dataBase open];
    [self.dataBase executeUpdate:@"CREATE TABLE IF  NOT EXISTS City (rowid INTEGER PRIMARY KEY AUTOINCREMENT, GRADE text,ID text,NAME text,PARENT_AREA_ID text)"];
    [self.dataBase close];
}
/**
 *  创建区域表单
 */
- (void)creatAreaTabel{
    [self.dataBase open];
    [self.dataBase executeUpdate:@"CREATE TABLE IF  NOT EXISTS Area (rowid INTEGER PRIMARY KEY AUTOINCREMENT, GRADE text,ID text,NAME text,PARENT_AREA_ID text)"];
    [self.dataBase close];
}
/**
 *  插入省份数据
 *
 *  @param province 省份模型
 */
- (void)insterProvince:(ProvinceModel *)province{
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db executeUpdate:@"INSERT INTO Province (GRADE,ID,NAME,PARENT_AREA_ID) VALUES (?,?,?,?)",province.GRADE,province.ID,province.NAME,province.PARENT_AREA_ID];
        [db close];
    }];
}
/**
 *  插入城市数据
 *
 *  @param city 城市模型
 */
- (void)insterCity:(CityModel *)city{
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db executeUpdate:@"INSERT INTO City (GRADE,ID,NAME,PARENT_AREA_ID) VALUES (?,?,?,?)",city.GRADE,city.ID,city.NAME,city.PARENT_AREA_ID];
        [db close];
    }];
}
/**
 *  插入区域数据
 *
 *  @param area 区域模型
 */
- (void)insterArea:(AreaModel *)area{
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db executeUpdate:@"INSERT INTO Area (GRADE,ID,NAME,PARENT_AREA_ID) VALUES (?,?,?,?)",area.GRADE,area.ID,area.NAME,area.PARENT_AREA_ID];
        [db close];
    }];
}
/**
 *  获取所有省份模型的集合数组
 *
 *  @return 返回所有省份数据模型的集合
 */
- (NSMutableArray *)getAllProvinceData{
    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM Province"];
        while ([result next]) {
            ProvinceModel *model = [[ProvinceModel alloc] init];
            model.GRADE = [result stringForColumn:@"GRADE"];
            model.ID = [result stringForColumn:@"ID"];
            model.NAME = [result stringForColumn:@"NAME"];
            model.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
            [provinceArray addObject:model];
        }
        [db close];
    }];
    return provinceArray;
}
/**
 *  根据省份ID获取对应的省份数据模型
 *
 *  @param provinceID 省份ID
 *
 *  @return 省份数据模型
 */
- (ProvinceModel *)getProvinceDataByID:(NSString *)provinceID{
    ProvinceModel *pmodel = [[ProvinceModel alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM Province WHERE ID = ?",provinceID];
        while ([result next]) {
            pmodel.GRADE = [result stringForColumn:@"GRADE"];
            pmodel.ID = [result stringForColumn:@"ID"];
            pmodel.NAME = [result stringForColumn:@"NAME"];
            pmodel.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
        }
        [db close];
    }];
    return pmodel;
}
/**
 *  根据省份ID获取该省份的所有城市数据模型的集合
 *
 *  @param parentID 省份ID
 *
 *  @return 一个省份的城市数据模型集合
 */
- (NSMutableArray *)getCityDataByParentID:(NSString *)parentID{
    NSMutableArray *cityArray = [[NSMutableArray alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM City WHERE PARENT_AREA_ID = ?",parentID];
        while ([result next]) {
            CityModel *model = [[CityModel alloc] init];
            model.GRADE = [result stringForColumn:@"GRADE"];
            model.ID = [result stringForColumn:@"ID"];
            model.NAME = [result stringForColumn:@"NAME"];
            model.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
            [cityArray addObject:model];
        }
        [db close];
    }];
    return cityArray;
}
/**
 *  根据城市ID获取对应的城市数据模型
 *
 *  @param cityID 城市ID
 *
 *  @return 城市数据模型
 */
- (CityModel *)getCityDataByID:(NSString *)cityID{
    CityModel *pmodel = [[CityModel alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM City WHERE ID = ?",cityID];
        while ([result next]) {
            pmodel.GRADE = [result stringForColumn:@"GRADE"];
            pmodel.ID = [result stringForColumn:@"ID"];
            pmodel.NAME = [result stringForColumn:@"NAME"];
            pmodel.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
        }
        [db close];
    }];
    return pmodel;
}
/**
 *  根据城市ID获取该城市的所有区域数据模型的集合
 *
 *  @param parentID 城市ID
 *
 *  @return 一个城市的区域数据模型集合
 */
- (NSMutableArray *)getAreaDataByParentID:(NSString *)parentID{
    NSMutableArray *areaArray = [[NSMutableArray alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM Area WHERE PARENT_AREA_ID = ?",parentID];
        while ([result next]) {
            AreaModel *model = [[AreaModel alloc] init];
            model.GRADE = [result stringForColumn:@"GRADE"];
            model.ID = [result stringForColumn:@"ID"];
            model.NAME = [result stringForColumn:@"NAME"];
            model.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
            [areaArray addObject:model];
        }
        [db close];
    }];
    return areaArray;
}
/**
 *  根据地区ID获取对应的地区数据模型
 *
 *  @param areaID 地区ID
 *
 *  @return 地区数据模型
 */
- (AreaModel *)getAreaDataByID:(NSString *)areaID{
    AreaModel *pmodel = [[AreaModel alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM Area WHERE ID = ?",areaID];
        while ([result next]) {
            pmodel.GRADE = [result stringForColumn:@"GRADE"];
            pmodel.ID = [result stringForColumn:@"ID"];
            pmodel.NAME = [result stringForColumn:@"NAME"];
            pmodel.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
        }
        [db close];
    }];
    return pmodel;
}
/**
 *  打开数据库
 *
 *  @param db db description
 */
- (void)openChinaAreaDB:(FMDatabase *)db{
    BOOL isOpen = [db open];
    if (isOpen == YES) {
        //        ITLog(@"数据库ChinaArea.db 打开成功!\n路径 = %@",self.dbPath);
    }
    else{
        //        ITLog(@"数据库ChinaArea.db 打开失败!\n路径 = %@",self.dbPath);
    }
}

/**
 *  制作省份数据模型
 *
 *  @param GRADE          GRADE
 *  @param ID             省份ID
 *  @param NAME           省份名称
 *  @param PARENT_AREA_ID 上一级ID
 *
 *  @return 省份数据模型
 */
- (ProvinceModel *)makeProvinceModel:(NSNumber *)GRADE provinceID:(NSNumber *)ID name:(NSString *)NAME parentId:(NSNumber *)PARENT_AREA_ID{
    ProvinceModel *model = [[ProvinceModel alloc] init];
    model.GRADE = [NSString stringWithFormat:@"%@",GRADE];
    model.ID = [NSString stringWithFormat:@"%@",ID];
    model.NAME = NAME;
    model.PARENT_AREA_ID = [NSString stringWithFormat:@"%@",PARENT_AREA_ID];
    return model;
}

/**
 *  制作城市数据模型
 *
 *  @param GRADE          GRADE
 *  @param ID             城市ID
 *  @param NAME           城市名称
 *  @param PARENT_AREA_ID 上一级省份ID
 *
 *  @return 城市数据模型
 */
- (CityModel *)makeCityModel:(NSNumber *)GRADE cityID:(NSNumber *)ID name:(NSString *)NAME parentId:(NSNumber *)PARENT_AREA_ID{
    CityModel *model = [[CityModel alloc] init];
    model.GRADE = [NSString stringWithFormat:@"%@",GRADE];
    model.ID = [NSString stringWithFormat:@"%@",ID];
    model.NAME = NAME;
    model.PARENT_AREA_ID = [NSString stringWithFormat:@"%@",PARENT_AREA_ID];
    return model;
}


/**
 *  制作区域数据模型
 *
 *  @param GRADE          GRADE
 *  @param ID             区域ID
 *  @param NAME           区域名称
 *  @param PARENT_AREA_ID 上一级城市D
 *
 *  @return 区域数据模型
 */
- (AreaModel *)makeAreaModel:(NSNumber *)GRADE areaID:(NSNumber *)ID name:(NSString *)NAME parentId:(NSNumber *)PARENT_AREA_ID{
    AreaModel *model = [[AreaModel alloc] init];
    model.GRADE = [NSString stringWithFormat:@"%@",GRADE];
    model.ID = [NSString stringWithFormat:@"%@",ID];
    model.NAME = NAME;
    model.PARENT_AREA_ID = [NSString stringWithFormat:@"%@",PARENT_AREA_ID];
    return model;
}
@end

@implementation AreaModel

@end


@implementation CityModel

@end



@implementation ProvinceModel

@end
