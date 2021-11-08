public class Challenge5_Methods {
    
    //Set<I> oppIds = new Set<Id>();
    
    public static void HandleIsInsert(List<Opportunity> opp){
        List<Task> InsertTasks = new List<Task>();
        
        //When the trigger is run, create FollowUpTask
        //task.ActivityDate = TODAY()+10;
        //task.OwnerId = UserId;
        //task.Subject = 'Follow Up' (case matters!)';
        //task.WhatId = opp.Id;
        
        //Get Fatima User ID
        
        String fatimaID = [Select Id from User where Name = 'Fatima Altaf Hussain' Limit 1].id;
        
        for(Opportunity myopp: opp){
            Task newtask = new Task();
            newtask.ActivityDate = Date.today() + 10;
            newtask.OwnerId = myopp.OwnerId;
            newtask.Subject = 'Follow Up\' (case matters!)';
            newtask.WhatId = myopp.Id;
            InsertTasks.add(newtask); 
            
            //Check Opportunity Amount for Reduce Value Task
            if(myopp.Amount > 500000){
                //Create Reduce Value Task
                Task rvtask = new Task();
                rvtask.ActivityDate = Date.today() + 2;
                rvtask.OwnerId = fatimaID;
                rvtask.Subject = 'Reduce Value';
                rvtask.Status ='New';
                rvtask.WhatId = myopp.Id;
                InsertTasks.add(rvtask); 
            }
        }
        insert InsertTasks;
    }
    
    public static void HandleIsUpdate(List<Opportunity> opp){
        List<Task> InsertTasks = new List<Task>(); 
        //Get Fatima User ID
        String fatimaID = [Select Id from User where Name = 'Fatima Altaf Hussain' Limit 1].id;
        
        for(Opportunity myopp: opp){
            //Create Reduce Value Task
            Task rvtask = new Task();
            rvtask.ActivityDate = Date.today() + 2;
            rvtask.OwnerId = fatimaID;
            rvtask.Subject = 'Reduce Value';
            rvtask.Status ='New';
            rvtask.WhatId = myopp.Id;
            InsertTasks.add(rvtask); 
        }
        insert InsertTasks;
    }
    
    public static void UpdateOpportunityAmount(List<Task> taskList, List<Id> oppid){
        //Making key value pair of opportunities where opp = task.whatId from trigger
        Map<Id, Opportunity> opp = new Map<Id, Opportunity>([Select id, amount from Opportunity where id IN: oppid]);
        
       //List of opportunities to update after for loop
        List<Opportunity> updateoppAmt = new List<Opportunity>();
        
        //Map<String, CustomObject__c> myMap = new Map<String, CustomObject__c>([Select z.Name, z.Id From CustomObject__c z]);
        
        //tasks --> opporunity id [list]
        // task -- opportunity ..
        // array type list  0,1
        
        for(Task updateAmt: taskList){    
            //Opportunity. Amount 1/2
            Opportunity opprec = new Opportunity();
            //get Opportunity from Task
            opprec = opp.get(updateAmt.whatId);
            opprec.Amount *= 0.5;
            updateoppAmt.add(opprec);
        }
		update updateoppAmt;       
    }
}