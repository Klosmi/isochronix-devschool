import { LightningElement, track, wire, api } from 'lwc';
import { getRecord } from "lightning/uiRecordApi";
import USERID from "@salesforce/user/Id";
import PROFILE_FIELD from "@salesforce/schema/User.Profile.Name";
// import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class pdf extends LightningElement {


@api recordId;
@track show = true;
// @track item = ;

//profiles and their names
Profile;

 @wire(getRecord, { recordId: USERID, fields: [PROFILE_FIELD] })
  myuser({ error, data }) {
    if (data) {
      this.ProfileName = data.fields.Profile.value.fields.Name.value;
    }
    if (error) {
        console.log("error");
    } 
    if (this.ProfileName != "user02") {
        this.show = true;
      } else this.show = false;
    }

  
 // PDF
    vfp = "/apex/pdf?Id=a037Q000002zLNSQA2";
    // vfp = `/apex/pdf?Id=${item}`;
    get url() {
        return this.vfp;
    }
}