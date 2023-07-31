@Reusable @Ignore
Feature: Created/Modify functions specific to Coreconnect, used to enhance the script with respect to the application

  Scenario: [Reuse] Coreconnect Functions

    * def I_Select_Search_Criteria_From_Dropdown_ =
    """
    function(ele){
    I_Wait_And_Click_On_(RO_Management_Page.Select_Search_Criteria_DropDown)
    I_Wait_And_Click_On_(RO_Management_Page.Dropdown_List_Partial_Start+ele+XPATH.PARTIAL_END)
    }
    """

    * def I_Verify_Toast_Message_Text_ =
    """
    function(Toast_Message_Text){
    try {
    retry(2000,10).waitFor(Role_Management_Page.Toast_Message_Text+Toast_Message_Text+XPATH.PARTIAL_END)
    I_Wait_For_(5000)
    karate.log('Coreconnect-FUNCTION: The element ' + Toast_Message_Text + ' is displayed.')
    } catch(e) {
    karate.fail('Coreconnect-FUNCTION-ERROR : The locator '+Toast_Message_Text+' cannot be found after '+ retries)
    }}"""

    #Comman functions
    * def I_Click_And_Wait_ =
    """
    function(locator, waitTime) {
    I_Wait_And_Click_On_(locator)
    I_Wait_For_(waitTime)
    }
    """

    * def I_Click_On_Dropdown_And_Select_Element_ =
    """
    function(locator1, locator2){
    I_Wait_And_Click_On_(locator1)
    I_Wait_For_(3000)
    I_Wait_And_Click_On_(locator2)
    }"""

    * def I_Select_Date_From_Date_Picker_ =
    """
    function(InputLabel, selectedMonth, selectedYear, selectedDate){
    try{
    I_Wait_And_Click_On_(XPATH.INPUT_ID_PARTIAL_START+InputLabel+XPATH.PARTIAL_END)
    I_Wait_And_Click_On_(User_Management_Page.Calender_Previous_Button)
    while(true) {
    var month = getText(User_Management_Page.Month_Calender)
    var year = getText(User_Management_Page.Year_Calender)
    if(month.equalsIgnoreCase(selectedMonth) && year.equalsIgnoreCase(selectedYear)) {
    if(driver.enabled(User_Management_Page.Date_Calender_XPath_Partial_End+ selectedDate +XPATH.PARTIAL_END)){
    I_Wait_And_Click_On_(User_Management_Page.Date_Calender_XPath_Partial_End+ selectedDate +XPATH.PARTIAL_END)
    I_Wait_For_(1000)
    break;
    } else{
    karate.log("Coreconnect-FUNCTION: Selected date is not enabled")
    break;
    }} else {
    if(parseInt(year)>parseInt(selectedYear)){
    karate.fail('Coreconnect-FUNCTION-ERROR : Year is greater in calender :'+year+' Selected Year is :'+selectedYear)
    break;
    }
    I_Wait_For_(1000)
    I_Wait_And_Click_On_(User_Management_Page.Calender_Next_Button)
    }}} catch(err) {
    karate.fail('Coreconnect-FUNCTION-ERROR : Getting error in I_Select_Date_From_Date_Picker_() function '+err)
    }}"""

    * def I_Verify_Color_Of_Element_ =
    """
    function(locator,actualHexvalue){
    I_Wait_For_(5000)
    rgbvalue = script(locator,"function(e){ return getComputedStyle(e)['color'] }")
    removedrgb=rgbvalue.replace('rgb(','').replace(')','').replace(' ','')
    karate.log("Coreconnect-FUNCTION: The replaced string is "+removedrgb)
    rgblist=getList(removedrgb,',')
    expectedhexvalue=hexcode(rgblist[0],rgblist[1],rgblist[2])
    I_Match_And_Verify_With_(expectedhexvalue,actualHexvalue)
    }
    """

    * def I_Get_Element_From_Json_ =
    """
    function(str, response){
    try{
     var arr = []
    for(i=0; i<=response.length-1; i++){
    for (var key in response[i]) {
    if(str==key){
    arr.push(response[i][key])
    }}}
    return arr;
    } catch(err){
    karate.fail("Coreconnect-FUNCTION-ERROR : Getting error in I_Get_Element_From_Json_() function"+err)
    }}
    """

    * def I_Verify_Color_Of_Elements_ =
    """
    function(partialLocator, endLocator, actualHexvalue){
    I_Wait_For_(5000)
    for (var i = 0, j = arguments.length-3; i < j; i++){
    rgbvalue = script(partialLocator + arguments[i+3] + endLocator,"function(e){ return getComputedStyle(e)['color'] }")
    removedrgb=rgbvalue.replace('rgb(','').replace(')','').replace(' ','')
    karate.log("Coreconnect-FUNCTION: The replaced string is "+removedrgb)
    rgblist=getList(removedrgb,',')
    expectedhexvalue=hexcode(rgblist[0],rgblist[1],rgblist[2])
    I_Match_And_Verify_With_(expectedhexvalue,actualHexvalue)
    }
    }
    """

    * def I_Verify_Labels_In_The_Page_ =
    """function(partialLocator, endLocator) {
    for (var i = 0, j = arguments.length-2; i < j; i++){
    retry().waitFor(partialLocator + arguments[i+2] + endLocator);
    if(exists(partialLocator + arguments[i+2] + endLocator) == true){
    karate.log('Coreconnect-FUNCTION: Given label '+ arguments[i+2] +' with ['+partialLocator + arguments[i+2] + endLocator+'] is present')
    }else{
    karate.fail('Coreconnect-FUNCTION-ERROR: Given label '+ arguments[i+2] +' with ['+partialLocator + arguments[i+2] + endLocator+'] is not present')
    }
    }
    }"""

    * def I_Scroll_To_Element_ =
    """
    function(locator){
    retry().scroll(locator)
    }
    """
    * def I_Matches_Two_String_ =
    """
  function(str1, str2) {
  // Convert both strings to lowercase.
  str1 = str1.toLowerCase();
  str2 = str2.toLowerCase();
  // Compare the two strings.
  if(str1 === str2){
  karate.log('Coreconnect-FUNCTION:Given string'+str1+ ' matches with '+str2)
  }else{
  karate.fail('Coreconnect-FUNCTION-ERROR: Given string '+str1+' not match with '+str2)}
  }
    """

    * def I_Locate_All_Elements_ =
    """
    function(locator)
    {
    lst=driver.locateAll(locator)
    size=karate.sizeOf(lst)
    fun = function(i) { return lst[i].script('_.innerText')}
    new_lst = karate.repeat(size,fun)
    return new_lst;
    }
    """

    * def I_Get_Search_Result_Text_ =
    """
    function(text){
    let result = text.substring(5, 8);
    return result;
    }
    """

    * def I_Compare_List_ofAll_Elements_ =
"""
  function(str, list){
  if(list.length == 0){
  karate.fail("CoreConnect-FUNCTION-ERROR :List is empty")
  } else{
   var strList = str.split(',')
    for(i=0; i<strList.length; i++){
      if(list.includes(strList[i])==false){
          karate.fail('CoreConnect-FUNCTION-ERROR :'+strList[i]+" is not found in "+list+" in list")
      }
  }
  karate.log('KARATE-BASE:Success')
    }
      }
"""
    * def I_Verify_The_Elements_Present_ =
    """function(partialLocator, endLocator) {
    for (var i = 0, j = arguments.length-2; i < j; i++){
    if(driver.exists(partialLocator + arguments[i+2] + endLocator) == true) {
    karate.log('CoreConnect-FUNCTION: Given label '+ arguments[i+2] +' with ['+partialLocator + arguments[i+2] + endLocator+'] is present')
    }else{
    karate.fail('CoreConnect-FUNCTION-ERROR: Given label '+ arguments[i+2] +' with ['+partialLocator + arguments[i+2] + endLocator+'] is not present')
    }
    }
    }"""

    * def I_Verify_The_Elements_Is_Not_Present_ =
    """function(partialLocator, endLocator) {
    for (var i = 0, j = arguments.length-2; i < j; i++){
    if(driver.exists(partialLocator + arguments[i+2] + endLocator) == false) {
    karate.log('Coreconnect-FUNCTION: The element [ locator: '+partialLocator + arguments[i+2] + endLocator+' ] is not present')
    } else {   karate.fail('Coreconnect-FUNCTION-ERROR: Given label '+ arguments[i+2] +' with ['+partialLocator + arguments[i+2] + endLocator+'] is present') }
    }
    }"""

    * def I_Verify_The_Elements_Is_Not_Enabled_ =
    """function(partialLocator, endLocator) {
    for (var i = 0, j = arguments.length-2; i < j; i++){
     try {
         retry().waitFor(partialLocator + arguments[i+2] + endLocator);
        if(driver.enabled(partialLocator + arguments[i+2] + endLocator) == false) {
             karate.log("Coreconnect-FUNCTION: The element [ locator: "+partialLocator + arguments[i+2] + endLocator+" ] is not enabled")
        } else { karate.fail("Coreconnect-FUNCTION-ERROR: The element [ locator: "+partialLocator + arguments[i+2] + endLocator+" ] is enabled ") }
     }
     catch(e) {
         if(e.message.includes('Cannot read property')) {
             karate.fail('Coreconnect-FUNCTION-ERROR: The element [ locator : '+partialLocator + arguments[i+2] + endLocator+' ] cannot be found') }
         }
     }
    }"""

    * def I_Verify_The_Elements_Is_Enabled_ =
    """function(partialLocator, endLocator) {
    for (var i = 0, j = arguments.length-2; i < j; i++){
     try {
         retry().waitFor(partialLocator + arguments[i+2] + endLocator);
        if(driver.enabled(partialLocator + arguments[i+2] + endLocator) == true) {
             karate.log("Coreconnect-FUNCTION: The element [ locator: "+partialLocator + arguments[i+2] + endLocator+" ] is enabled")
        } else { karate.fail("Coreconnect-FUNCTION-ERROR: The element [ locator: "+partialLocator + arguments[i+2] + endLocator+" ] is not enabled ") }
     }
     catch(e) {
         if(e.message.includes('Cannot read property')) {
             karate.fail('Coreconnect-FUNCTION-ERROR: The element [ locator : '+partialLocator + arguments[i+2] + endLocator+' ] cannot be found') }
         }
     }
    }"""


    * def I_Verify_String_Is_Not_Match_ =
     """
    function(str1, str2){
    if(str1 != str2){
    karate.log('Coreconnect-FUNCTION: '+str1+' is not match with '+str2)
    }else{
    karate.fail('Coreconnect-FUNCTION-ERROR: '+str1+' is match with '+str2)
    }
    }
    """

    * def I_Verify_Element_Is_Present_In_List_ =
    """
    function(list, ele){
    var i = 0;
    if(list.length == 0){
    karate.fail('Coreconnect-FUNCTION-ERROR: List is Empty')
    }else{
    while(true){
    if(i==list.length){
    karate.fail('Coreconnect-FUNCTION-ERROR: '+ele+' Element is not present in the list')
    break;
    }
    if(list[i].replace(/[, ]+;/, " ").trim()==ele.trim()){
    karate.log('Coreconnect-FUNCTION: '+ele+' Element is present in the list')
    break;
    }else{
    i++;
    }}}}
    """

    * def I_Compare_String_To_All_Elements_Of_List_ =
    """
    function(str, list){
    if(list.length == 0){
    karate.fail("Coreconnect-FUNCTION-ERROR :List is empty")
    }else{
    for(i=0; i<list.length; i++){
    if(str == list[i]){
    if(list.length-1 == i){
    karate.log('Coreconnect-FUNCTION: '+str+" is match with all elements of list")
    break;
    }
    }else{
    karate.fail('Coreconnect-FUNCTION-ERROR :'+str+" is not match with "+list[i]+" in list")
    break;
    }}}}
    """

    * def I_Sort_The_Lists_And_Compare_ =
    """
    function(list1, list2){
    if(list1.length==0 || list2.length==0){
    karate.log("Coreconnect-FUNCTION: List is empty")
    }
    if(list1.length != list2.length){
    karate.fail("Coreconnect-FUNCTION-ERROR: Lists lengths are not equal List1 length: "+list1.length+"List2 length: "+list2.length)
    }else{
    list1.sort();
    list2.sort();
    for(i=0; i<=list1.length-1; i++){
    if(list1[i].trim() == list2[i].trim()){
    karate.log("Coreconnect-FUNCTION: Element Matching "+list1[i].trim()+" with "+list2[i].trim())
    }else{
    karate.fail("Coreconnect-FUNCTION-ERROR : Element not Matching "+list1[i].trim()+" with "+list2[i].trim())
    }}}}
    """

    * def I_Upload_File_On_ =
    """function(locator,filePath){
    var count = 0
    I_Enter_Text_On_(locator,filePath)
    count = count+1
    return count
    }"""

    * def I_Move_Mouse_To_Element_And_Click_ =
    """function(locator){
    mouse().move(locator).click()
    }"""
    * def I_Hover_Mouse_To_Element_And_Get_Text_ =
    """
    function(locator){
    mouse().move(locator).go()
    var text = getText(locator);
    return text;
    }
    """
    * def I_Match_And_Verify_With_ =
    """function(expectedValue,actualValue)
    {
    I_Wait_For_(2000)
    var result = karate.match(expectedValue,actualValue)
    if(result.pass == true)
    { karate.log('KARATE-BASE: The '+expectedValue+' matches with the '+actualValue) }
    else
    { karate.fail(result.message) }
    }"""

    * def I_Enter_Each_Character_After_Interval_Of_ =
    """function(locator, value, time){
    try{
    retry().input(locator, value, time)
    }catch(e)
    {
     karate.fail('Coreconnect-FUNCTION-ERROR: Getting error in I_Enter_Each_Character_After_Interval_Of_ function'+e)
    }
    }
    """
    * def I_Click_Until_Element_Is_Located_ =
    """
    function(locator){
     for(var i=1;i<10;i++){
      I_Click_And_Wait_(locator,3000)
      }
    }
    """

    * def I_Verify_Border_Color_Of_Element_ =
"""
function(locator,actualHexvalue){
I_Wait_For_(5000)
rgbvalue = script(locator,"function(e){ return getComputedStyle(e)['border-color'] }")
removedrgb=rgbvalue.replace('rgb(','').replace(')','').replace(' ','')
karate.log("Coreconnect-FUNCTION: The replaced string is "+removedrgb)
rgblist=getList(removedrgb,',')
expectedhexvalue=hexcode(rgblist[0],rgblist[1],rgblist[2])
I_Match_And_Verify_With_(expectedhexvalue,actualHexvalue)
}
"""

  * def I_Wait_And_Verify_Text_ =
  """
  function(expectedLocator,actualValue) {
  try {
  retry().waitForText(expectedLocator,actualValue)
  }
  catch(e) {
  if(e.message.includes('retries')) {
  var retries = e.message.toString().replace('waitUntil (js): failed after ','')
  karate.fail('ERROR : The locator [ locator : '+ expectedLocator +' ] cannot be found after ' + retries)
  } else {
  karate.fail('ERROR EXCEPTION : ' + e)
  }
  }
  }
  """
  * def I_Locate_And_Verify_Tooltips_ =
  """
function(locator1,locator2){
    list=driver.locateAll(locator1)
    var listtext = list.getText(locator1)
    for(var i=0;i<list.size;i++){
        if(i==null){
            continue
        }
         mouse().move(i).go()
         I_Wait_For_(5000)
    list2=driver.locateAll(locator2)
    var list2Text = list2.getText(locator2)
    }
    if(listtext==list2Text){
        return true
    }else{
        return false
    }
}
  """


    * def I_Verify_Column_Is_Sorted_In_Dashboard_ =
    """
  function(tableHeaderName,locator,sortOrder){
  if(sortOrder == 'Ascending'){
  var columnList = I_Locate_All_Elements_(locator)
  I_Wait_For_(10000)
  var sortedlColumnlist = I_Sort_List_(columnList)
  I_Compare_And_Verify_Lists_(columnList,sortedlColumnlist)
  } else if (sortOrder == 'Descending'){
    var columnList = I_Locate_All_Elements_(locator)
  I_Wait_For_(10000)
  I_Click_And_Wait_(CustomerDashboardSorting.Table_Header_Partial_Start+tableHeaderName+XPATH.PARTIAL_END, 7000)
  var sortedlColumnlist = I_Sort_List_(columnList)
  sortedlColumnlist.reverse()
  karate.log(sortedlColumnlist)
  I_Compare_And_Verify_Lists_(columnList,sortedlColumnlist)
    }
  }
"""