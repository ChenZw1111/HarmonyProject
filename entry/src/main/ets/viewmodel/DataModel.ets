
import { CommonConstants } from '../constant/CommonConstant';
import Logger from '../utils/Logger';
const TAG ='[DataModel]'

export class DataModel{
  private targetData:Array<TaskItemBean> = [];

  getData():Array<TaskItemBean>{
    return this.targetData;
  }

  deleteData(selectArr:Array<boolean>){
    if (!selectArr) {
      Logger.error(TAG, 'Failed to delete data because selectArr is ' + selectArr);
    }
    let dataLen = this.targetData.length - CommonConstants.ONE_TASK;
    for(let i = dataLen; i >=0;i--){
      if(selectArr[i]){
        this.targetData.splice(i,CommonConstants.ONE_TASK);
      }
    }
  }

  addData(data:TaskItemBean){
    if (!data) {
      Logger.error(TAG, 'addData error because data is: ' + data);
      return;
    }
    this.targetData.push(data);
  }

  getLatestProgressValue():number{
    if(this.targetData.length ==0){
      return 0;
    }
    return this.targetData[this.targetData.length - CommonConstants.ONE_TASK].progressValue
  }

  updateProgress(index:number,updateValue:number,updateDate:string):boolean{
    if(!this.targetData[index]){
      return false;
    }
    this.targetData[index].progressValue = updateValue;
    this.targetData[index].updateDate = updateDate;
    return true;
  }
}
export default new DataModel();
export class TaskItemBean{
  taskName: string;
  updateDate: string;
  progressValue: number;

  constructor(taskName:string,progressValue:number,updateDate:string) {
    this.taskName = taskName;
    this.updateDate = updateDate;
    this.progressValue = progressValue
  }
}