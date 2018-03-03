@RestResource(urlMapping='/case/*/close')
global with sharing class CaseCloseResource {
    @HttpPost
    global static void closeCase(String reason){
        Set<ID> caseIds = new Set<ID>{extractId()};
        CaseService.closeCases(caseIds, reason);
    }

    private static String extractId(){
        return RestContext.request.requestURI.substringBetween('/case/', '/close');
    }
}
