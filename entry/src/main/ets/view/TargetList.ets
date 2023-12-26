import { CommonConstants } from '../constant/CommonConstant';
import { TaskItemBean } from '../viewmodel/DataModel';
@Component
export default struct TargetList{
  @Consume overAllProgressChanged:boolean;
  @State isEditMode:boolean = false;
  @State selectArray:Array<boolean> = [];
  @State selectAll:boolean = false;
  @State clickIndex:number = CommonConstants.DEFAULT_CLICK_INDEX;
  @Link targetData:Array<TaskItemBean>;
  onAddClick?:() => void;

  build(){
    Column(){
      Row(){
        Text($r('app.string.sub_goals'))
          .fontSize($r('app.float.secondary_title'))
          .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
          .fontColor($r('app.color.title_black_color'))
        Blank()
        if(this.targetData.length>0){
          if(this.isEditMode){
            Text($r('app.string.cancel_button'))
              .operateTextStyle($r('app.color.main_blue'))
              .margin({ left: $r('app.float.operate_button_margin') })
              .onClick(() => {
                this.selectAll = false;
                this.isEditMode = false;
                this.selectAllOrCancel(false);
              })
            Text($r('app.string.select_all_button'))
              .operateTextStyle($r('app.color.main_blue'))
              .margin({
                left: $r('app.float.operate_button_margin')
              })
            Checkbox()
              .select(this.selectAll)
              .selectedColor($r('app.color.main_blue'))
              .width(CommonConstants.CHECKBOX_WIDTH)
              .onClick(() =>{
                this.selectAll = !this.selectAll;
                this.selectAllOrCancel(this.selectAll);
              })
          }else{
            Text($r('app.string.edit_button'))
              .operateTextStyle($r('app.color.main_blue'))
              .onClick(() => {
                this.isEditMode = true;
                this.selectAllOrCancel(false);
              })
          }
        }
      }
      .width(CommonConstants.FULL_WIDTH)
      .height($r('app.float.history_line_height'))
      .padding({
        left: $r('app.float.list_padding'),
        right: $r('app.float.list_padding_right')
      })

      List({space: CommonConstants.LIST_SPACE}){
        ForEach(this.targetData,(item:TaskItemBean,index:number) =>{
          ListItem(){
            TargetListItem({

            })
          }
        })
      }
    }
  }

  selectAllOrCancel(selectStatus:boolean){
    let newSelectArray:Array<boolean> = [];
    this.targetData.forEach(() =>{
      newSelectArray.push(selectStatus);
    });
    this.selectArray = newSelectArray;
  }
}

@Extend(Text) function operateTextStyle(color: Resource) {
  .fontSize($r('app.float.text_button_font'))
  .fontColor(color)
  .lineHeight($r('app.float.text_line_height'))
  .fontWeight(CommonConstants.FONT_WEIGHT)
}

/**
 * Custom button style.
 */
@Extend(Button) function operateButtonStyle(color: Resource) {
  .width($r('app.float.button_width'))
  .height($r('app.float.button_height'))
  .fontSize($r('app.float.button_font'))
  .fontWeight(CommonConstants.FONT_WEIGHT)
  .fontColor(color)
  .backgroundColor($r('app.color.button_background'))
}