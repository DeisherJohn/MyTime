# MyTime
A program for small buisnesses to help track employee time digitally. 




Installation Read-Me

1: Once the package is unzipped navigate to the folder Release/Alpha_1_0
    
2: Copy the following files:
        -gdsqlite.64.dll
        -MyTime.exe
        -MyTime.pck

3: Save these files to the location you want to store the program, the reports and database are stored separately so this is just where you want the program. 

4: Open MyTime.exe


User Guide: 

When the program is first opened you will be prompted to enter an administrator pin, this pin is used for any admin level interactions (i.e. adding employees, update employee info, changing shift times, generating reports)

Once a pin has been entered the program is ready to use, the following is the options currently available. 

- Add Employee:
    This option opens a menu that allows new employees to be added to the program. 

- Update Employee: 
        This options allows an existing employees information to be updated, this option does NOT adjust employee time logs, only general information. 

- View Employee Log:
    This options pulls an employees shift information for a selected time range, this will work with both the employee pin and the admin pin, but only an admin pin can change a time record. 
    should an record need to be updated, once it has been selected the admin can enter the pin to save any corrected data to the database. 

- Gen. Single Report:
    This options allows two report types to be created for a single employee
        1: Simple - This only has the total time worked for the selected date range
        2: Full - This option shows all shifts worked during the date range and the time for each shift as well as the total time for the period. 

- Gen. Full Report:
    this option allows a report to be made that has the same options as the single employee but includes the data from all employees that have time logged for the period. 

- Settings:
    This is where basic settings can be adjusted. 
        1: Date Format: the default format is MM/DD/YYYY but there is support for DD/MM/YYYY as well. 
        2: File Location: this is the default location that is loaded when a new file is created. 


!!! WARNING: THIS ERASES ANY SAVED DATA FROM THE PROGRAM!!!
CLEAR DATA:
    this button is used to clean up the data from testing, it will delete the user settings file and the database from the uses system. this is for testing purposes only. delete responsibly. 
