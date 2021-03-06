extends Node


const SQLite = preload("res://lib/gdsqlite.gdns")
var dbPath = null

var db = null
var query = ""
var result = null
var connected = false

var TestEmployee = {
		"eid":999,
		"first_name":"",
		"last_name":"",
		"position":"",
		"pin":"",
		"startDate":"",
		"phone":"",
		"email":"",
		"canRemoteReport":0,
		"canRemoteLogIn":0,
		"active":0
	}

func _ready():
	if not settings.get_first_run():
		dbPath = settings.get_db_location()
		connected = connectDB()
	pass # Replace with function body.

func make_db():
	connected = connectDB()
	
	#prep table if not created to hold users
	query = "CREATE TABLE IF NOT EXISTS users ("
	query += "eid integer PRIMARY KEY,"
	query += "first_name text NOT NULL,"
	query += "last_name text NOT NULL,"
	query += "position text NOT NULL,"
	query += "pin text NOT NULL,"
	query += "startDate text NOT NULL,"
	query += "phone text NOT NULL,"
	query += "email text NOT NULL,"
	query += "canRemoteReport integer NOT NULL,"
	query += "canRemoteLogIn integer NOT NULL,"
	query += "active integer NOT NULL"
	query += ");"
	
	result = db.query(query)
	
	query = "INSERT INTO users (eid, first_name, last_name, position, pin, startDate, phone, email, canRemoteReport, canRemoteLogIn, active) VALUES ('"
	query += str(TestEmployee['eid']) + "','" 
	query += TestEmployee['first_name'] + "','" 
	query += TestEmployee['last_name'] + "','" 
	query += TestEmployee['position'] + "','" 
	query += TestEmployee['pin'] + "','" 
	query += TestEmployee['startDate'] + "','"
	query += TestEmployee['phone'] + "','" 
	query += TestEmployee['email'] + "'," 
	query += str(TestEmployee['canRemoteReport']) + "," 
	query += str(TestEmployee['canRemoteLogIn']) + "," 
	query += str(TestEmployee['active']) + ")"

	result = db.query(query) #add employee to DB
	pass
	
func connectDB():
	dbPath = settings.get_db_location()
	db = SQLite.new()
	if(!db.open_db(dbPath)):
		#Connect to db or make it if it does not exist
		print("ERR: %s" % db.get_errormsg())
		return false
		
	return true
	
func closeDB():
	if not connected:
		return
		
	db.close()
	connected = false

func getEmployeeTableName(eid):
	if eid == null: return null
	return "EMP" + str(eid)
	
func canEmployeeLogTime(eid, fromRemote = false):
	if not connected: return null
	
	query = "SELECT * FROM users WHERE " 
	query += "eid = " + str(eid)
	result = db.fetch_array(query)
	
	if result == null or result[0]['active'] == 0:
		return false
		
	if fromRemote and result[0]['canRemoteLogIn'] == 0:
		return false
		
	return true

func addEmployee(employee):
	#employee is going to be a json data set
	if not connected: return null
	
	query = "SELECT * FROM users WHERE " 
#	if employee["eid"] != null:
#		query += "eid = '" + str(employee["eid"]) + "' OR "
	query += "(first_name = '" + employee["first_name"] + "' "
	query += "AND last_name = '" + employee["last_name"] + "')"

	result = db.fetch_array(query)
	
	if len(result) != 0:
		#Duplicate employee?
		print("EMPLOYEE ALREADY ADDED")
		return false
		#TODO: what happens when its a dulicate employee
		
	query = "INSERT INTO users (first_name, last_name, position, pin, startDate, phone, email, canRemoteReport, canRemoteLogIn, active) VALUES ('"
	
	query += employee['first_name'] + "','" 
	query += employee['last_name'] + "','" 
	query += employee['position'] + "','" 
	query += employee['pin'] + "','" 
	query += str(employee['startDate']) + "','"
	query += employee['phone'] + "','" 
	query += employee['email'] + "'," 
	query += str(employee['canRemoteReport']) + "," 
	query += str(employee['canRemoteLogIn']) + "," 
	query += str(employee['active']) + ")"

	result = db.query(query) #add employee to DB
	
	query = "SELECT * FROM users WHERE "
	query += "(first_name = '" + employee["first_name"] + "' "
	query += "AND last_name = '" + employee["last_name"] + "')"
	
	result = db.fetch_array(query)
	employee["eid"] = result[0]["eid"]
	
	#Make a table to keep the time records
	query = "CREATE TABLE IF NOT EXISTS EMP" + str(employee['eid']) + " ("
	query += "id integer PRIMARY KEY, "
	query += "signIn integer NOT NULL,"
	query += "signOut integer NOT NULL"
	query += ");"
	
	result = db.query(query)
	
	if not result:
		print("Error adding employee")
		#What happens in an employee is not added
	pass
	
func updateEmployee(employee):
	if not connected: return null
	
	query = "UPDATE users SET "
	query += "first_name='" + employee['first_name'] + "'," 
	query += "last_name='" + employee['last_name'] + "'," 
	query += "position='" + employee['position'] + "'," 
	query += "pin='" + employee['pin'] + "'," 
	query += "startDate='" + str(employee['startDate']) + "',"
	query += "phone='" + employee['phone'] + "'," 
	query += "email='" + employee['email'] + "'," 
	query += "canRemoteReport=" + str(employee['canRemoteReport']) + "," 
	query += "canRemoteLogIn=" + str(employee['canRemoteLogIn']) + "," 
	query += "active=" + str(employee['active'])
	query += " WHERE eid = " + str(employee['eid'])
	result = db.query(query)
	
func getEmployee(eid):
	if not connected: return null
	
	query = "SELECT * FROM users WHERE eid = " + str(eid)
	result = db.fetch_array(query)
	if len(result) == 0: return null
	
	return result[0]
	pass
	
func getEmployeeList(_active = true):
	if not connected: return null
	
	if _active:
		query = "SELECT * FROM users WHERE (eid != 999 and active = 1)"
	else:
		query = "SELECT * FROM users WHERE eid != 999"
		
	result = db.fetch_array(query)
	return result
	pass

func logEmplyoeeTime(eid, time = null, fromRemote = false):
	if not connected: return null
	
	if time == null: 
		time = get_time_offset(OS.get_datetime())
		
	#Check to see if employee can track time.
	if not canEmployeeLogTime(eid, fromRemote): return false
	
	var employeeTable = getEmployeeTableName(eid)
	
	query = "SELECT * FROM " + employeeTable +" WHERE " 
	query += "signOut = 0"
	
	result = db.fetch_array(query)
	
	if result == null or len(result) == 0:
		#sign in
		query = "INSERT INTO " + employeeTable + " (signIn, signOut) VALUES (" + str(time) + ",0)"
	else:
		#sign Out
		query = "UPDATE " + employeeTable + " SET signOut="+ str(time) +" WHERE signOut=0"
	
	result = db.query(query)


func getShiftTimes(eid, start = 0, end = null, itemLimit = null):
	if not connected: return null
	
	if end == null:
		end = get_time_offset(OS.get_datetime())
		
	var employeeTable = getEmployeeTableName(eid)
	
	query = "SELECT * FROM " + employeeTable
	query += " WHERE (signIn > " + str(start) + " AND signIn < "+ str(end) + ")"
	
	if itemLimit != null: query += " LIMIT " + str(itemLimit)
	
	result = db.fetch_array(query)
	return result
	

func checkStatus(eid):
	if not connected: return null
	
	
	var table = getEmployeeTableName(eid)
	query = "SELECT * FROM " + table +" WHERE " 
	query += "signOut = 0"
	result = db.fetch_array(query)
	
	if result == null or len(result) == 0:
		#False means the employee is signed out
		return false
	return true #True is signed in
	

func get_time_offset(time):
	var hour = time["hour"]
	var minute = time["minute"]
	time["hour"] = 0
	time["minute"] = 0
	time["second"] = 0
	time = OS.get_unix_time_from_datetime(time)
	
	time += (hour * 60 * 60) + (minute * 60)
	return time
	
	
func update_time_entry(eid, id, signIn, signOut = 0):
	if not connected: return null
	
	var table = getEmployeeTableName(eid)
	
	query = "UPDATE " + table + " SET signIn=" + str(signIn) + ", signOut=" + str(signOut) + " WHERE id=" + str(id)
	result = db.query(query)
	
	