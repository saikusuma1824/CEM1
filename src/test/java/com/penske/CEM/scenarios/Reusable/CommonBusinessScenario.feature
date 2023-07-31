@Reusable @Ignore
Feature: To re-utilize the common scenarios across all other Feature Files, which aren't specific to a application module

  @SSOLogin
  Scenario: [Reuse] Login into Customer Enrollment Application
    Given driver {}
    When I_Open_The_Application_With_URL_(CemURL)
    Then I_Verify_Title_Of_('Password Services')
    When I_Clear_And_Enter_Text_In_The_Field_(PasswordServices.SSOID_Input_Field,ssoid)
    And  I_Enter_Text_On_(PasswordServices.Password_Field,app_password)
    And  I_Wait_And_Click_On_(PasswordServices.Login_Button)
    Then I_Verify_Title_Of_('Customer Enrollment Management')




