### `install-student-project.sh`
Clones a student's project and takes all the necessary steps to boot it up (set up .env file, composer install, create database, setup vhost, etc.)

### Setup
1. Navigate into the `dwa-bash` directory on your computer
2. Skim through the `install-student-project` file to see what it does
2. Give the script executable permissions: `chmod +x install-student-project`

### Usage
Invoke the script including 2 params: 

1. `studentname` (Can be anything, first, last, firstlast, just as long as it's unique)
2. Their project's github URL, e.g. `https://github.com/susanBuck/foobooks`

Example:
```bash
$ ./install-student-project susan https://github.com/susanBuck/foobooks
```

This will create a directory at `./students/susan/foobooks`.

 
## 

Set up a host for `student.loc` and add the following to your vhosts file:

```
<VirtualHost *:80>
    ServerName student.loc
    DocumentRoot /Users/Susan/Sites/dwa-bash/students/jane/p4/public
    <Directory /Users/Susan/Sites/dwa-bash/students/jane/p4/public>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>
```