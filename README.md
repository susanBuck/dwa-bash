
## Script: install-student-project

Clones a student's project and takes all the necessary steps to boot it up (set up .env file, composer install, create database, etc.)

### Setup
1. Navigate into the `dwa-bash` directory on your computer
2. Skim through the `install-student-project` file to see what it does
2. Give the script executable permissions: `chmod +x install-student-project`

### Usage
Invoke the script including 2 params: 
1) studentname 
2) Their project's github URL

Example:
```bash
$ ./install-student-project susan https://github.com/susanBuck/foobooks
```

This will create a directory at `./students/susan/foobooks`.

The one manual step you'll have to do is set your localhost to point to the project's `public` directory. 

Or you could create a local path (e.g. `http://student.loc`) and just switch the document root of that.


## Script: refresh-student-project

Syncs up your copy of a student's project with the latest of what they have on Github.

Use if you've already installed their project and just want to update it, discarding any changes you might have.

### Setup
1. Navigate into the `dwa-bash` directory on your computer
2. Skim through the `refresh-student-project` file to see what it does
2. Give the script executable permissions: `chmod +x refresh-student-project`.

### Usage
From within your `dwa-bash` directory, invoke with 1 param, the student's name. The student name must be the name you used when you installed the project.

```bash
$ ./refresh-student-project susan
```

