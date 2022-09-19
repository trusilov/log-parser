#   Log Parser 
##  Description
Shell script to convert log files to CSV format

##  Cheatsheet
| Argument        | Description             | Example                   		                | Status             |
|-----------------|-------------------------|---------------------------------------------|--------------------|
| `-a`			         | *Path to log file.*     | `./convert.sh -a nginx.log`    			          | Default convert.	  |
| `-p`         	  | *Path to log file.*     | `./convert.sh -p nginx.log`    			          | Only with filter.	 |
| `-i`          	 | *Filter by IP-Address*  | `./convert.sh -p nginx.log -i 162.55.33.98` | Only with filter.	 |
| `-d`			         | *Filter by Date*		      | `./convert.sh -p nginx.log -d 26/Apr/2021`  | Only with filter.	 |
| `-c`			         | *Filter by Status Code* | `./convert.sh -p nginx.log -c 200` 		       | Only with filter.	 |



##  Synopsis
### Default convert:
```sh 
-a [path to log file]
``` 
Convert all log lines to CSV format

Example commands:
```sh
./convert.sh -a nginx.log
``` 
 or
 ```sh
 ./convert.sh -p /SomeFolder/MyLogs.log
 ``` 
 
## Filters:

**Required arguments for filters:** 
```sh
-p [path to log file]
 ``` 
Path to your log file

Example commands:
```sh
./convert.sh -p nginx.log
 ``` 
 or
 ```sh
./convert.sh -p /SomeFolder/MyLogs.log
 ``` 
> Note: `Required argument` 


**Optional arguments:**

---

**Filter by IP-Address**
 ```sh
-i [IP-ADDRESS] 
 ```

Example command:
 ```sh
./convert.sh -p nginx.log -i 162.55.33.98
 ```
---

**Filter by Date**
 ```sh
-d [DATE] 
 ```

Example command:
 ```sh
./convert.sh -p nginx.log -d 26/Apr/2021
 ```

---
**Filter by HTTP status code**
 ```sh
-c [STATUS CODE] 
 ```

Example command:
 ```sh
./convert.sh -p nginx.log -c 200
 ```
