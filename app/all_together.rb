require 'eyes_selenium'
require 'selenium-webdriver'

def run_test(eyes,inner_driver,viewport_size)
    driver = eyes.open( driver: inner_driver, app_name: 'Hello World App v1', test_name: 'Hello World Test',
                        viewport_size: viewport_size)
    begin
        # Navigate the browser to the "hello world!" web-site.
        website = 'https://applitools.com/helloworld?diff1'
        driver.get website
    
        # Visual checkpoint #1.
        eyes.check_window 'Before mouse click'
    
        # Click the "Click me!".
        driver.find_element(:tag_name => 'button').click
    
        # Visual checkpoint #2.
        eyes.check_window 'After mouse click'
    
        # End the test.

        throwtTestCompleteException = false;
        result = eyes.close(throwtTestCompleteException)

        url = result.url;
        if result.is_new
            puts "New Baseline Created: URL=#{url}"
        elsif result.is_passed 
            puts "All steps passed:     URL=#{url}"
        else 
            puts "Test Failed:          URL=#{url}"
        end

    ensure
      # If the test was aborted before eyes.close was called, ends the test as aborted.
      eyes.abort_if_not_closed
    end
end

# Initialize the eyes SDK and set your private API key.
uri = "https://eyesapi.applitools.com"
eyes = Applitools::Selenium::Eyes.new(uri)
api_key = 'd1hQAwqXH04jtJ5wGIej01whl1108x4xRPK3SvsmXP3fA110'
eyes.api_key = api_key

batch_info = Applitools::BatchInfo.new('Hello World Batch')
eyes.batch = batch_info

# Open a Chrome Browser.
inner_driver = Selenium::WebDriver.for :chrome

  # Start the test and set the browser's viewport size to 800x600.
viewport_size_test      = {'width': 800, 'height': 600}
run_test(eyes,inner_driver,viewport_size_test)

# viewport_size_landscape = {'width': 1024, 'height': 768}
viewport_size_portrait  = {'width': 400,  'height': 900}
# run_test(eyes,inner_driver,viewport_size_landscape)
run_test(eyes,inner_driver,viewport_size_portrait)
# Close the browser.
inner_driver.quit 