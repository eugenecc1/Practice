#include <stdio.h>

// clientData structure definition               
struct clientData {
    int account;
    char lastName[15];
    char firstName[10];
    double balance;
};

void writing_data(void);
void reading_data(void);

int main(void) {

    writing_data();
    reading_data();

    return 0;

}

void writing_data(void) {
    
    FILE* cfPtr = NULL; // accounts.dat file pointer

    // fopen opens the file; exits if file cannot be opened
    if ((cfPtr = fopen("accounts.dat", "rb+")) == NULL) {
        puts("File could not be opened.");
    }
    else {
        // create clientData with default information
        struct clientData client = { 0, "", "", 0.0 };

        // require user to specify account number
        printf("%s", "Enter account number (1 to 100, 0 to end input): ");
        scanf("%d", &client.account);

        // user enters information, which is copied into file
        while (client.account != 0) {
            // user enters last name, first name and balance
            printf("%s", "Enter lastname, firstname, balance: ");

            // set record lastName, firstName and balance value
            fscanf(stdin, "%14s%9s%lf", client.lastName,
                client.firstName, &client.balance);

            // seek position in file to user-specified record
            fseek(cfPtr, (client.account - 1) *
                sizeof(struct clientData), SEEK_SET);

            // write user-specified information in file          
            fwrite(&client, sizeof(struct clientData), 1, cfPtr);

            // enable user to input another account number
            printf("%s", "\nEnter account number: ");
            scanf("%d", &client.account);
        }

        fclose(cfPtr); // fclose closes the file
    }
};

void reading_data(void) {
   
    FILE* cfPtr = NULL; // accounts.dat file pointer

    // fopen opens the file; exits if file cannot be opened
    if ((cfPtr = fopen("accounts.dat", "rb")) == NULL) {
        puts("File could not be opened.");
    }
    else {
        printf("%-6s%-16s%-11s%10s\n", "Acct", "Last Name",
            "First Name", "Balance");

        // read all records from file (until eof)
        while (!feof(cfPtr)) {
            // read a record
            struct clientData client = { 0, "", "", 0.0 };
            size_t result =
                fread(&client, sizeof(struct clientData), 1, cfPtr);

            // display record
            if (result != 0 && client.account != 0) {
                printf("%-6d%-16s%-11s%10.2f\n", client.account,
                    client.lastName, client.firstName, client.balance);
            }
        }

        fclose(cfPtr); // fclose closes the file
    }
};

