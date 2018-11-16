require 'eyes_selenium'
require 'selenium-webdriver'

# Initialize the eyes SDK and set your private API key.
eyes = Applitools::Selenium::Eyes.new
eyes.api_key = 'd1hQAwqXH04jtJ5wGIej01whl1108x4xRPK3SvsmXP3fA110'

# Open a Chrome Browser.
driver = Selenium::WebDriver.for :safari

begin
  # Start the test and set the browser's viewport size to 800x600.
  eyes.test(app_name: 'Hello World Safari1', test_name: 'My Safari1 Selenium Ruby test!',
            viewport_size: {width:800, height:600}, driver: driver) do
              
    eyes.baseline_name='ApplitoolsHelloWorld-Safari'
              
              
    # driver.get 'https://applitools.com/helloworld'
    driver.get 'https://applitools.com/helloworld?diff1'
    # driver.get 'https://applitools.com/helloworld?diff2'
    
    # Visual checkpoint #1.
    eyes.check_window 'Example!'

    # Click the "Click me!".
    driver.find_element(:tag_name => 'button').click

    # Visual checkpoint #2.
    eyes.check_window 'Click!'
  end
ensure
  # Close the browser.
  driver.quit

  # If the test was aborted before eyes.close was called, ends the test as aborted.
  eyes.abort_if_not_closed
end
