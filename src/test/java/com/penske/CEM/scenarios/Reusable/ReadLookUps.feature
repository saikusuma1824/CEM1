#Author : AkshayGawande
@Reusable @Ignore
Feature: Read LookUps Features
  To utilize the locators from json files in the regular scenarios across all other Feature Files.

  Scenario: [Reuse] Call Read Customer Enrollment LookUps
    * call read 'classpath:com/penske/CEM/locatorsLookup/CEM/commonLocator.json'
    * call read 'classpath:com/penske/CEM/locatorsLookup/CEM/TestData.json'
    * call read 'classpath:com/penske/CEM/locatorsLookup/CEM/XpathHelper.json'
    * call read('classpath:com/penske/CEM/scenarios/Reusable/CustomerEnrollmentAppFunctions.feature')


