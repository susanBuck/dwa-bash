
## Instructions `install-student-project`

### Setup
1. Navigate into the `dwa-bash` directory on your computer
2. Give the script executable permissions: `chmod +x install-student-project`

### Usage
Invoke the script including 2 params: 1) studentname 2) their project github URL
Example:
```bash
$ ./install-student-project susan https://github.com/susanBuck/foobooks
```

This will create a directory at `./students/susan`.

The one manual step you'll have to do is set your localhost to point to the project (there's code below to do this, but it does not work properly on all systems).

I have a http://student.loc URL I use, and just switch the document root to whatever student project I'm working on.


## Instructions `refresh-student-project`

### Setup
1. Navigate into the `dwa-bash` directory on your computer
2. Give the script executable permissions: `chmod +x refresh-student-project`.

### Usage
Navigate into the existing student project
Invoke the script including 1 params: studentname
Example:

```bash
$ refresh-student-project susan
```
