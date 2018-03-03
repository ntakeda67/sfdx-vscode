public with sharing class CaseService {

    public static void closeCases(Set<Id> caseIDs, String reason){
        List<Case> closingCases = new List<Case>();
        for(Case c: [select Id, Reason, Status from Case]) {
            c.Reason = reason;
            c.Status = 'Closed';
            closingCases.add(c);
        }
        update closingCases;
    }
}
