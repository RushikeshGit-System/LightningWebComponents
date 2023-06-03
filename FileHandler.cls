public with sharing class FileHandler {
    public FileHandler() {

    }
   @AuraEnabled
  public static String uploadFile(String base64, String filename, String recordId){
     ContentVersion ctv = new ContentVersion(VersionData=EncodingUtil.base64Decode(base64),Title=filename,PathOnClient=filename);
     insert ctv;
     ContentDocumentLink cdl = new ContentDocumentLink();
     cdl.ContentDocumentId = [SELECT ContentDocumentId 
      FROM ContentVersion 
      WHERE Id =: ctv.id
    ].ContentDocumentId;

    cdl.LinkedEntityId=recordId;
    cdl.ShareType='V';
    insert cdl;
     
    return cdl.Id;
     
    }
}