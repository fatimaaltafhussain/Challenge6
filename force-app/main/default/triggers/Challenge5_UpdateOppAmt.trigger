trigger Challenge5_UpdateOppAmt on Task (after update) {
    
    if(Trigger.isUpdate){
        List<Task> updateList = new List<Task>();
        List<Id> oppid = new List<Id>();
        for(Task mytask: trigger.new){
            //If New value is not equal to Old Value
            if(Trigger.NewMap.get(mytask.Id).status != Trigger.OldMap.get(mytask.Id).status && Trigger.NewMap.get(mytask.Id).status == 'Completed' && Trigger.NewMap.get(mytask.Id).Subject == 'Reduce Value'){
                updateList.add(mytask);
                oppid.add(mytask.whatId);
            }
        }
        Challenge5_Methods.UpdateOpportunityAmount(updateList, oppid);
        System.debug('Chal GAYA 3');
    }
}