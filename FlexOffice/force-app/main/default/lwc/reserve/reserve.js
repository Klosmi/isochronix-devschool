import { LightningElement, track, wire, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Reservation__c.Date__c';
import getReservation from '@salesforce/apex/FlexOfficeController.getRes';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns =  [
    {label: 'Name', fieldName: 'Name' }, 
    {label: 'Id', fieldName: 'Id' },
    {label: 'Status', fieldName: 'Status' },
];

export default class Reserve extends LightningElement {
    @api objectApiName = "Reservation__c" ;
    @api recordId = "";
     nameField = NAME_FIELD;

    @track data;

    // show reservation record in a datatabl on the html
    recData;
    columns;
    // get reservation records
    @wire(getReservation)
    wiredAccounts({ error, data }) {
        if (data) {
        let sData = JSON.parse(JSON.stringify(data));

        sData.forEach(function(item){
            console.log('item : ' + JSON.stringify(item));
                item.Name = item.Name!=undefined ? item.Name : '';
            });
            this.recData =sData; 
            this.columns = columns;
            this.error = undefined;
            } 
            else if (error) {
                this.error = error;
                this.data = undefined;
        }
    }



    // actual date as min value to datepicker
    today; 
    connectedCallback(){
    this.today = new Date().toISOString().slice(0,10);
    } 


    // toast message
    handleSuccess(){
         const evt = new ShowToastEvent({
                title: "New reservation",
                message: "your reservation is succefully created.",
                variant: "success"
            })
            this.dispatchEvent(evt);
    }

        retreiveReservations(){
        getRes({})
        .then(d => {
            this.data_res = JSON.parse(d);
        })
    }
    
}