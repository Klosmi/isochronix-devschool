import { LightningElement, track } from 'lwc';
import createDesk from '@salesforce/apex/FlexOfficeController.createDesk';
import getDesks from '@salesforce/apex/FlexOfficeController.getDesks';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DeskList extends LightningElement {
   
    // rerenders and displays the new value of desks -> show in the table
    @track data_desks = [];
   
    columns = [
        { label: 'Id', fieldName: 'Id', type: 'text' },
        { label: 'Name', fieldName: 'Name', type: 'text' },
    ];

    // connectedCallback assign the value to the picklist
    connectedCallback(){
            this.retreiveDesk();
    }

    // reach out to desk from Apex: retreiveDesk() calls getDesks from Apex
    retreiveDesk(){
        getDesks({})
        .then(d => {
            this.data_desks = JSON.parse(d);
        })
    }
    
    // desk object recives the 'name of the desk', changeValue gets fired whenever field value changes
    desk = {};
    changeValue(event){
        this.desk[event.target.name] = event.target.value
    }

    // submit button: calls createDesk func to send the data to Apex
    //  .then(data=>
    submitDesk(){
        console.log(this.desk, this.value, 'Hi there');
        createDesk({
            desk:JSON.stringify(this.desk)})
        .then(data=> {
            console.log('hello: ', data)
            this.retreiveDesk();
            // toaster
            const evt = new ShowToastEvent({
                title: "New desk",
                message: `succefully created. Check out your reservation.`,
                variant: "success"
            })
            this.dispatchEvent(evt);
        })
    }
    
}



