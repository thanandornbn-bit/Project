## Compile

mvn compile

## Package

mvn clean package

## Start tomcat server

### for debug

c:\apache-tomcat-10.1.43\bin> .\catalina.bat jpda start

### for running

c:\apache-tomcat-10.1.43\bin> .\catalina.bat start

## VSCode config file for debug

.vscode/launch.json

```
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Debug (Attach)",
      "request": "attach",
      "hostName": "localhost",
      "port": 8000
    }
  ]
}
```

## URL for test on browser

http://localhost:8080/Thanachok03-0.0.1-SNAPSHOT


## Docker startup
`
docker compose up -d
docker compose down
`
