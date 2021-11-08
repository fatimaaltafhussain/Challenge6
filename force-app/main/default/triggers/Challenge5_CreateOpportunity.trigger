trigger Challenge5_CreateOpportunity on Opportunity (after insert, before update) {
    
    //What do I have to do
    //On what events will the trigger run
    //
    if(Trigger.isInsert){
        Challenge5_Methods.HandleIsInsert(trigger.new);
        System.debug('Chal GAYA');
    }
    
    //new x old
    //new > 500k
    //old > 500 then do nothing
    //
    
    //new <500k --we dont care
    if(Trigger.isUpdate){
        List<Opportunity> updateList = new List<Opportunity>();
        for(Opportunity opp: trigger.new){
            //If New value is not equal to Old Value
            if(Trigger.NewMap.get(opp.Id).amount != Trigger.OldMap.get(opp.Id).amount){
                //if new value > 500k and Old value <=500k
                if(Trigger.NewMap.get(opp.Id).amount > 500000 && Trigger.OldMap.get(opp.Id).amount <=500000){
                    updateList.add(opp);
                }
            }
            Challenge5_Methods.HandleIsUpdate(updateList);
            System.debug('Chal GAYA 2');
        }
        
    }
}