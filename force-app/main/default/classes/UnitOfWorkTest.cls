@IsTest
public with sharing class UnitOfWorkTest {
    @IsTest
    static void challengeComplete(){
        // Create a Unit Of Work
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[] {
                Account.SObjectType,
                Contact.SObjectType,
                Note.SObjectType
            }
        );

        for(Integer i=0; i<100; i++){
            Account acc = new Account(Name='Test Account ' + i);
            uow.registerNew(acc);

            for(Integer j=0; j<5; j++){
                Contact con = new Contact(FirstName = 'Contact ' + i, LastName='Test');
                uow.registerRelationship(con, Contact.AccountId, acc);
                uow.registerNew(con);

                Note n = new Note(Title = 'Note ' + i);
                uow.registerRelationship(n, Note.ParentId, con);
                uow.registerNew(n);
            }
        }

        uow.commitWork();

        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
    }
}
