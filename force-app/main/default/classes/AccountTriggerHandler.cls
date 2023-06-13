public class AccountTriggerHandler {
    public static void createNewContact(List<Account> newAccount, Map<Id, Account> oldAccounts) {
        Map<Id, Account> accMap = new Map<Id, Account>();
        List<Contact> contactsToInsert = new List<Contact>();

        if (!newAccount.isEmpty()) {
            for (Account acc : newAccount) {
                if (acc.Type == 'Customer - Direct' || acc.Type == 'Customer - Channel') {
                    if (acc.Active__c == true) {
                        accMap.put(acc.Id, acc);
                        if (oldAccounts != null) {
                            if (oldAccounts.get(acc.Id).Active__c != acc.Active__c) {
                                accMap.put(acc.Id, acc);
                            }
                        }
                    }
                }
            }
            for (Account acc : newAccount) {
                if (accMap.containsKey(acc.Id)) {
                    Contact con = new Contact();
                    con.AccountId = acc.Id;
                    con.LastName = 'Customer Representative';
                    con.FirstName = acc.Name;
                    con.Email = acc.Company_Email__c;
                    con.Phone = acc.Phone;

                    contactsToInsert.add(con);
                }
            }
        }
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}
