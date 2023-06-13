@isTest
public class AccountTriggerHandlerTest {
    @isTest
    public static void testCreateNewContact() {
        List<Account> testAccountList = new List<Account>();

        for (integer i = 0; i < 50; i++) {
            Account testAccount = new Account(
                Name = 'Test Credex Account' + i,
                Type = 'Customer - Direct',
                Active__c = true,
                Company_Email__c = 'testCredex@test.com',
                Phone = '1234567890'
            );
            testAccountList.add(testAccount);
        }
        test.startTest();
        insert testAccountList;
        test.stopTest();

        List<Contact> createdContact = [
            SELECT Id, AccountId, LastName, FirstName, Email, Phone
            FROM Contact
            WHERE AccountId = :testAccountList[0].id
        ];
        System.assert(createdContact != null, 'not created');
    }
}
