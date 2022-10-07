import { LightningElement, track, wire, api } from 'lwc';
import getDesks from '@salesforce/apex/FlexOfficeController.getDesks';
import createReservation from '@salesforce/apex/FlexOfficeController.createReservation';
import getReservations from '@salesforce/apex/FlexOfficeController.getReservations';
import NAME_FIELD from '@salesforce/schema/Reservation__c.Date__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class Reserve extends LightningElement {

    @track combobox = [];

    @api objectApiName = "Reservation__c" ;
    @api recordId = "";
     nameField = NAME_FIELD;

    // actual date as min value to datepicker
    today; 
    connectedCallback(){
    this.today = new Date().toISOString().slice(0,10);
    } 

    handleChangeDate(event) {
        this.dateValue = event.detail.value;
        console.log(event.dateValue)
    }

    connectedCallback(){
        this.retreiveDesk();
    }

    // created reservation object {}
    reservation = {};
    changeValue(event){
        this.reservation[event.target.name] = event.target.value
    }

    // submit button > create reservation + toaster
    submitReservation(){
        createReservation({reservation:JSON.stringify(this.reservation)})
        .then(data=> {
            const evt = new ShowToastEvent({
                title: "New reservation",
                message: "your reservation is succefully created.",
                variant: "success"
            })
            this.dispatchEvent(evt);
        })
    }

    // get the desk data from apex
    retreiveDesk(){
        getDesks({})
        .then(d => {
            let data_desks = JSON.parse(d);
            let c = [];
            data_desks.forEach(element => {
                c.push({label: element.Name , value: element.Id})
            });
            this.combobox = c;
            console.log('hello', c);
        })
    }

     retreiveReservation(){
        getReservations({})
        .then(reserv => {
            this.data_reservs = JSON.parse(reserv);
        })
    } 

    handleSuccess(){
         const evt = new ShowToastEvent({
                title: "New reservation",
                message: "your reservation is succefully created.",
                variant: "success"
            })
            this.dispatchEvent(evt);
    }
    
}