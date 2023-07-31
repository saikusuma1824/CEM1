function() {

//Global retry setting. Interval in milliseconds
karate.configure('retry',{ count:10, interval:5000});
karate.configure('robot',{ highlight: true });

    var productConfig = Java.type('com.penske.CEM.config.ConfigCem').getInstance()

        var CemConfig = {
           browserName: 'chrome',
           remoteRun:'false',
           CemURL: 'https://ux-ce-status.acp.ptlapps.com/entry/ApplicationEntry',
           ssoid: productConfig.SSOID(),
           app_password:productConfig.APP_PASSWORD(),
           gridHub_url: 'http://localhost:4444/wd/hub'
        };

      // Selecting the browser
      var browser = karate.properties['browser.name'] || CemConfig.browserName;
      karate.log('KARATE-CONFIG : The browser set is = ' + browser);

      // grid flag, if not set it takes default. The grid url is in this format http://localhost:4444/wd/hub
      var remote_Run = karate.properties['remote.run'] || CemConfig.remoteRun;
      var grid_url = karate.properties['gridHub_url'] || CemConfig.gridHub_url;
      karate.log('KARATE-CONFIG : The grid url set is = ' + grid_url);
    //Switching between browser
      if (browser == 'chrome') {
          if (remote_Run == 'false') {
             karate.configure('driver', { type: 'chromedriver',executable:'C:/Users/akgawand/cf-customer-enrollment-management_api/src/test/resources/driver/chromedriver.exe' });
             karate.log('KARATE-CONFIG : Selected Chrome in local');
          } else {
             karate.configure('driver', { type: 'chromedriver', start: false, webDriverUrl: grid_url });
             karate.log('KARATE-CONFIG : Selected Chrome in grid : ' + grid_url);
          }
       } else if (browser == 'edge') {
          if (remote_Run == 'false') {
              karate.configure('driver', { type: 'msedgedriver', webDriverSession: { capabilities: { browserName: 'edge' } } });
              karate.log('KARATE-CONFIG : Selected Edge in local');
          } else {
              karate.configure('driver', {type : 'msedgedriver', webDriverSession : {capabilities : {browserName : 'MicrosoftEdge'}, desiredCapabilities : {browserName : 'MicrosoftEdge'}},  start: false, webDriverUrl: grid_url });
              karate.log('KARATE-CONFIG : Selected Edge in grid : ' + grid_url);
          }
       }
     //Calling product ReadLookUps
     var config = karate.callSingle('classpath:com/penske/CEM/scenarios/Reusable/ReadLookUps.feature', CemConfig);
     return config;
}
