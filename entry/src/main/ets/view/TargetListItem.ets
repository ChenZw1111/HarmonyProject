import { CommonConstants } from '../constant/CommonConstant';
import { TaskItemBean } from '../viewmodel/DataModel';
import ProgressEditPanel from './ProgressEditPanel';

@Component
export default struct TargetListItem {
  private taskItem?: TaskItemBean;
  @State latestProgress?: number = 0;
  @State updateDate?: string = '';
  @Link selectArr: Array<boolean>;
  @Prop isEditMode: boolean;
  @Link @Watch('onClickIndexChanged') clickIndex: number;
  @State isExpanded: boolean = false;
  @Consume overAllProgressChanged: boolean;
  @State sliderMode: number = CommonConstants.DEFAULT_SLIDER_MODE;
  public index: number = 0;

  aboutToAppear(){
    this.latestProgress = this.taskItem?.progressValue;
    this.updateDate = this.taskItem?.updateDate;
  }

  onClickIndexChanged(){
    if(this.clickIndex != this.index){
      this.isExpanded = false;
    }
  }

  build(){
    Stack({
      alignContent:Alignment.Start
    }){
      Column(){
        this.TargetItem()
        if(this.isExpanded){
          Blank()
          ProgressEditPanel({
            slidingProgress:this.latestProgress,
            onCancel:() => this.isExpanded = false,
            onClickOK:()

          })
        }
      }
    }
  }

  @Builder TargetItem() {
    Row() {
      Text(this.taskItem?.taskName)
        .fontSize($r('app.float.list_font'))
        .fontWeight(CommonConstants.FONT_WEIGHT)
        .fontColor($r('app.color.title_black_color'))
        .width(CommonConstants.TASK_NAME_WIDTH)
        .textAlign(TextAlign.Start)
        .maxLines(CommonConstants.MAX_LINES)
      Blank()
      Column() {
        Text(`${this.latestProgress}%`)
          .fontSize($r('app.float.list_font'))
          .fontWeight(CommonConstants.FONT_WEIGHT)
          .fontColor($r('app.color.title_black_color'))
        Row() {
          Text($r('app.string.latest_updateTime'))
            .opacityTextStyle()
          Text(this.updateDate)
            .opacityTextStyle()
        }
        .margin({ top: $r('app.float.text_margin') })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width(CommonConstants.FULL_WIDTH)
  }
}

@Extend(Text) function opacityTextStyle() {
  .fontSize($r('app.float.text_font'))
  .fontColor($r('app.color.title_black_color'))
  .opacity(CommonConstants.OPACITY)
  .fontWeight(CommonConstants.FONT_WEIGHT)
}