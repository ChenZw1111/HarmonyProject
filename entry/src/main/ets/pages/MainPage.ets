import promptAction from '@ohos.promptAction';
import { CommonConstants } from '../constant/CommonConstant';
import getCurrentTime from '../utils/DateUtil';
import AddTargetDialog from '../view/AddTargetDialog';
import TargetInformation from '../view/TargetInformation';
import DataModel, { TaskItemBean } from '../viewmodel/DataModel';
@Entry
@Component
struct MainPage {
  @State targetData:Array<TaskItemBean> = DataModel.getData();
  @State totalTaskNumber:number = 0;
  @State completedTaskNumber:number = 0;
  @State latestUpdateDate:string = CommonConstants.DEFAULT_PROGRESS_VALUE;
  @Provide @Watch('onProgressChanged') overAllProgressChanged:boolean = false;
  dialogController:CustomDialogController = new CustomDialogController({
    builder:AddTargetDialog({
      onClickOk:(value:string):void => this.saveTask(value)
    }),
    alignment:DialogAlignment.Bottom,
    offset:{
      dx:CommonConstants.DIALOG_OFFSET_X,
      dy:$r('app.float.dialog_offset_y')
    },
    customStyle:true,
    autoCancel:false
  });

  onProgressChanged(){
    this.totalTaskNumber = this.targetData.length;
    this.completedTaskNumber = this.targetData.filter((item:TaskItemBean) =>{
      return item.progressValue == CommonConstants.SLIDER_MAX_VALUE;
    }).length;
    this.latestUpdateDate = getCurrentTime();
  }

  build(){
    Column(){
      this.titleBar()
      TargetInformation({
        totalTasksNumber:this.totalTaskNumber,
        latestUpdateDate:this.latestUpdateDate,
        completedTaskNumber:this.completedTaskNumber
      })
    }
  }

  @Builder
  titleBar(){
    Text($r('app.string.title'))
      .width(CommonConstants.TITLE_WIDTH)
      .height($r('app.float.title_height'))
      .fontSize($r('app.float.title_font'))
      .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
      .textAlign(TextAlign.Start)
      .margin({
        top: $r('app.float.title_margin'),
        bottom: $r('app.float.title_margin')
      })
  }

  saveTask(taskName:string){
    if (taskName === '') {
      promptAction.showToast({
        message: $r('app.string.cannot_input_empty'),
        duration: CommonConstants.TOAST_TIME,
        bottom: CommonConstants.TOAST_MARGIN_BOTTOM
      });
      return;
    }
    DataModel.addData(new TaskItemBean(taskName,0,getCurrentTime()));
    this.targetData = DataModel.getData();
    this.overAllProgressChanged =!this.overAllProgressChanged;
    this.dialogController.close();
  }
}