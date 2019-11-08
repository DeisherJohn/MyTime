# MyTime
Latest Release: https://uploadfiles.io/1ifjmizl


Thank you for using MyTime.

This software was created by John Deisher to help small businesses manage employee time sheets without needing to hassle with monthly payment or lots of technical setup. 

This software uses a simple SQL database saved locally so that your information is always available to you. Should you even want to migrate to an enterprise level time tracking solution SQL database often can be migrated and since it is your data saved locally you won't lose it just because you change software. 

Should you have any inquiries about the software feel free to reach out to me via the following ways:

Github (Project Repo): https://github.com/DeisherJohn/MyTime

LinkedIn: https://www.linkedin.com/in/john-deisher/

User Guide: 

When the program is first opened you will be prompted to enter an administrator pin, this pin is used for any Admin level interactions (i.e. adding employees, update employee info, changing shift times, generating reports)

Once a pin has been entered the program is ready to use, the following is the options currently available. 

- Add Employee:
    This option opens a menu that allows new employees to be added to the program. 

- Update Employee: 
        This options allows an existing employees information to be updated, this option does NOT adjust employee time logs, only general information. 

- View Employee Log:
    - This options pulls an employees shift information for a selected time range, this will work with both the employee pin and the Admin pin, but only an Admin pin can change a time record. 
    - should an record need to be updated, once it has been selected the Admin can enter the pin to save any corrected data to the database. 

- Gen. Single Report:
    - This options allows two report types to be created for a single employee
        - Simple - This only has the total time worked for the selected date range
        - Full - This option shows all shifts worked during the date range and the time for each shift as well as the total time for the period. 

- Gen. Full Report:
    this option allows a report to be made that has the same options as the single employee but includes the data from all employees that have time logged for the period. 

- Settings:
    - This is where basic settings can be adjusted. 
        - Date Format: the default format is MM/DD/YYYY but there is support for DD/MM/YYYY as well. 
        - File Location: this is the default location that is loaded when a new file is created. 


!!! WARNING: THIS ERASES ANY SAVED DATA FROM THE PROGRAM!!!
CLEAR DATA:
    this button is used to clean up the data from testing, it will delete the user settings file and the database from the uses system. this is for testing purposes only. delete responsibly. 
