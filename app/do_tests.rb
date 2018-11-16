require 'eyes_selenium'
require 'selenium-webdriver'
$app_name  = "Hello World 2 App v2 ruby";

# change the value of testName so that it has a unique value on your Eyes system
$test_name = "Hello World 2 v2";

# if you have a dedicated Eyes server, set the value of the variable $serverURLstr to your URL
$serverURLstr = "https://eyesapi.applitools.com";

#set the value of runAsBatch to true so that the tests run as a single batch
$run_as_batch = true

# set the value of $change_test to true to introduce changes that Eyes will detect as mismatches
$change_test = true
$weburl = "https://applitools.com/helloworld2";

def main ()   
    eyes = Applitools::Selenium::Eyes.new($serverURLstr)
    setup(eyes)
    # viewport_size_landscape = {'width': 1024, 'height': 768}
    # viewport_size_portrait  = {'width': 500,  'height': 900}
    
    viewport_size_landscape = {'width': 800, 'height': 600}
    viewport_size_portrait  = {'width': 500,  'height': 600}
    inner_driver = Selenium::WebDriver.for :chrome                            # Open a Chrome browser.

    if ! $change_test 
        test01(inner_driver, eyes, viewport_size_landscape);
        test01(inner_driver, eyes, viewport_size_portrait);
    else 
        test01_changed(inner_driver, eyes, viewport_size_landscape);
        test01_changed(inner_driver, eyes, viewport_size_portrait);
    end
    # Close the browser.
    inner_driver.quit;
end

def test01(inner_driver, eyes, viewport_size) 
    driver = eyes.open(driver: inner_driver, app_name: $app_name, test_name: $test_name,
                viewport_size: viewport_size)
    begin
        # Navigate the browser to the "hello world!" web-site.
        driver.get($weburl)

        eyes.check_window('Before enter name')                          # Visual checkpoint #1.

        driver.find_element(:id => 'name').send_keys("My Name") # enter the name
        eyes.check_window('After enter name')                          # Visual checkpoint #2.
        
        driver.find_element(:tag_name => 'button').click()              # Click the 'Click me!' button.
        eyes.check_window('After click')                               # Visual checkpoint #3.

        result = eyes.close(false)
        handleResult(result)
    ensure
        # If the test was aborted before eyes.close was called, ends the test as aborted.
        eyes.abort_if_not_closed()
    end
end

def test01_changed(inner_driver, eyes, viewport_size) 
    driver = eyes.open(driver:inner_driver, app_name:$app_name, test_name:$test_name,
                viewport_size: viewport_size)
    begin
        web_utl_to_use = $weburl;
        if $change_test
            web_utl_to_use << "?diff2"
        end
        # Navigate the browser to the "hello world!" web-site.
        driver.get(web_utl_to_use)

        if ! $change_test
            eyes.check_window('Before enter name')                          # Visual checkpoint #1.
        end
        driver.find_element(:id => 'name').send_keys("My Name")              # enter the name
        eyes.check_window('After enter name')                               # Visual checkpoint #2.
        
        driver.find_element(:tag_name => 'button').click()                   # Click the 'Click me!' button.
        eyes.check_window('After click')                                    # Visual checkpoint #3.

        if $change_test
            eyes.check_window('After click again')                          # Visual checkpoint #4.
        end
        result = eyes.close(false)
        handleResult(result)

    ensure
        # If the test was aborted before eyes.close was called, ends the test as aborted.
        eyes.abort_if_not_closed()
    end
end

def handleResult(result) 
        url = result.url
        total_steps = result.steps
        if result.is_new 
            resultStr = "New Baseline Created: " + total_steps.to_s + " steps"
        elsif result.is_passed  
            resultStr = "All steps passed:     " + total_steps.to_s + " steps";
        else 
            resultStr = "Test Failed     :     " + total_steps.to_s + " steps";
            resultStr << " matches=" +  result.matches.to_s      #  matched the baseline 
            resultStr << " missing=" + result.missing.to_s       # missing in the test
            resultStr << " mismatches=" + result.mismatches.to_s # did not match the baseline
        end 
        resultStr += "\n" + "results at " + url
        print(resultStr)
end

def setup(eyes)
    api_key =  'd1hQAwqXH04jtJ5wGIej01whl1108x4xRPK3SvsmXP3fA110'
    eyes.api_key = api_key
    if $run_as_batch
       eyes.batch = Applitools::BatchInfo.new('Hello World 2 Batch')
    end
    #eyes.ignore_caret = true
end
main()